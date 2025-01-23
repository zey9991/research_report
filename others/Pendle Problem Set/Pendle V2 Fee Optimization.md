## Glossary

- **Fee**: Refers to the fee settings related to the V2 PT-AMM pools.
- **The Whitepaper**: Refers to the whitepaper `V2_AMM.pdf` unless otherwise specified.
- **SY** : is a Standardized Yield token.
- **Asset**: Refers to the underlying asset of the SY token.
- **PT** : is a PT token of the same SY token.

## Guideline

This report aims to achieve two main objectives:

- **Competitiveness**: Ensure that each pool's fees are as low as possible, compared to competitors.
- **Profitability**: Maximize the fees for each pool while maintaining competitiveness, to increase treasury revenue.

*Note: The priority between these two objectives can be reconsidered as necessary.*

## Fee Computation

In V2, the mechanics of pool-related fees are described in the whitepaper `V2_AMM.pdf` and implemented in the smart contracts `MarketMathCore.sol` (Core Logic) and `PendleMarketV3.sol`.

The whitepaper defines the amount of assets going in, denoted as $$d_{asset}$$  as a function of the amount of PT tokens going out, denoted as $$d_{pt}$$:

$$
d_{asset}=\frac{d_{pt}}{exchangeRate(t)}\div or \times feeRateRoot^{yearsToExpiry(t)}
$$
Accordingly, the fee can be computed as follows:

- if $$d_{pt}>0$$ i.e. swapping assets for PT, then 

  $$
  d_{asset}=\frac{d_{pt}}{exchangeRate(t)}\times feeRateRoot^{yearsToExpiry(t)}
  $$
  The fee is:

  $$
  fee=\frac{d_{pt}}{exchangeRate(t)}(feeRateRoot^{yearsToExpiry(t)}-1)
  $$

- if $$d_{pt}<0$$  i.e. swapping PT for assets, then 

  $$
  d_{asset}=\frac{d_{pt}}{exchangeRate(t)}\div feeRateRoot^{yearsToExpiry(t)}
  $$
  The fee is:
  
  $$
  fee=-\frac{d_{pt}}{exchangeRate(t)}(\frac{1-feeRateRoot^{yearsToExpiry(t)}}{feeRateRoot^{yearsToExpiry(t)}})
  $$
  

This logic is implemented in the `calcTrade` function of `MarketMathCore.sol`. The relevant source code is as follows:

```solidity
function calcTrade(
        MarketState memory market,
        MarketPreCompute memory comp,
        PYIndex index,
        int256 netPtToAccount
    ) internal pure returns (int256 netSyToAccount, int256 netSyFee, int256 netSyToReserve) {
        int256 preFeeExchangeRate = _getExchangeRate(
            market.totalPt,
            comp.totalAsset,
            comp.rateScalar,
            comp.rateAnchor,
            netPtToAccount
        );

        int256 preFeeAssetToAccount = netPtToAccount.divDown(preFeeExchangeRate).neg();
        int256 fee = comp.feeRate;

        if (netPtToAccount > 0) {
            int256 postFeeExchangeRate = preFeeExchangeRate.divDown(fee);
            if (postFeeExchangeRate < PMath.IONE) revert Errors.MarketExchangeRateBelowOne(postFeeExchangeRate);

            fee = preFeeAssetToAccount.mulDown(PMath.IONE - fee);
        } else {
            fee = ((preFeeAssetToAccount * (PMath.IONE - fee)) / fee).neg();
        }

        int256 netAssetToReserve = (fee * market.reserveFeePercent.Int()) / PERCENTAGE_DECIMALS;
        int256 netAssetToAccount = preFeeAssetToAccount - fee;

        netSyToAccount = netAssetToAccount < 0
            ? index.assetToSyUp(netAssetToAccount)
            : index.assetToSy(netAssetToAccount);
        netSyFee = index.assetToSy(fee);
        netSyToReserve = index.assetToSy(netAssetToReserve);
    }
```

where:

1. `fee`  corresponds to $$feeRateRoot^{yearsToExpiry(t)}$$ as described in the whitepaper.
2. `netPtToAccount` corresponds to $$d_{pt}$$ in the whitepaper.
3. A key divergence to note: The whitepaper defines $$d_{asset}=\frac{d_{pt}}{exchangeRate(t)}$$ while in the `calcTrade` function, we define $$d_{asset}=-\frac{d_{pt}}{exchangeRate(t)}$$:

```
int256 preFeeAssetToAccount = netPtToAccount.divDown(preFeeExchangeRate).neg();
```

> Summary of the Execution Flow of the `calcTrade` function:
>
> 1. **Calculate the pre-fee exchange rate** using `_getExchangeRate` to determine the amount of assets per PT token.
> 2. **Calculate the pre-fee asset amount** from `netPtToAccount` by dividing it by the pre-fee exchange rate and negating it (since the assets are being withdrawn from the user).
> 3. **Set the fee rate** from `comp.feeRate` to calculate the transaction fee.
> 4. **Check if `netPtToAccount` is positive**:
> - If positive, adjust the fee and check the post-fee exchange rate to ensure it's above 1.
> - If non-positive, adjust the fee accordingly, considering asset withdrawal.
> 6. **Calculate the reserve fee** (`netAssetToReserve`) and subtract the fee from the pre-fee asset amount to calculate the final amount to the user (`netAssetToAccount`).
> 7. **Convert asset amounts into SY tokens** for the account, fee, and reserve using the `assetToSy` or `assetToSyUp` functions provided by `PYIndex`.
>

Users focus on the single fee payment, denoted as $$fee$$ , while from the protocol's perspective, we are concerned with the sum of fees generated from the pool, represented as $$\sum_tfee$$.

We may view $$fee$$ as a function of time $$t$$ and $$feeRateRoot$$ we set. Then the partial derivative of $$fee$$ can be derived as follows(consistent with the formula in the whitepaper):

if $$d_{pt}>0$$,
$$
\frac{\partial fee(t, feeRateRoot)}{\partial feeRateRoot}=\frac{d_{pt}\cdot yearsToExpiry(t)}{exchangeRate(t)}feeRateRoot^{yearsToExpiry(t)-1}
$$
Generally speaking, $$exchangeRate\ge1$$. As long as $$yearsToExpiry(t)>0$$, which holds true before the expiry date, we can conclude that:
$$
\frac{\partial fee(t, feeRateRoot)}{\partial feeRateRoot}>0
$$
This inequality shows that, given time $$t$$, when users swap assets for PT, the fee generated is higher if the $$feeRateRoot$$ is larger.

if $$d_{pt}<0$$,
$$
\frac{\partial fee(t, feeRateRoot)}{\partial feeRateRoot}=\frac{d_{pt}\cdot yearsToExpiry(t)}{exchangeRate(t)}\cdot \frac{1}{feeRateRoot^{yearsToExpiry(t)-1}}
$$
Before the expiry date, we derive that
$$
\frac{\partial fee(t, feeRateRoot)}{\partial feeRateRoot}<0
$$
This inequality indicates that, given time $$t$$, when users swap PT for assets, the fee generated is higher if the $$feeRateRoot$$ is smaller.

## References

1. [MarketMathCore.sol - WORKSPACE - Blockscan contract source code viewer](https://vscode.blockscan.com/ethereum/0x40789E8536C668c6A249aF61c81b9dfaC3EB8F32)
2. [PendleMarketV3.sol - WORKSPACE - Blockscan contract source code viewer](https://vscode.blockscan.com/ethereum/0x40789E8536C668c6A249aF61c81b9dfaC3EB8F32)