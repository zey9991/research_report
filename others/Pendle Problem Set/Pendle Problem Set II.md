# QUESTION 1 What pools should Pendle support next? 

> For context: aside from the hype and narratives of the underlying pool, we want to maximise “Pool TVL multiplied by implied APY of the pool”. For example, the sUSDE May 2025 pool has a total TVL of 33.5M and Implied APY = 18.33%, hence a “value” of 18.33% * 33.5M = 6.14M

## Guideline

Our task is to identify:

- Pools that generate hype and have strong narratives.
- Pools with the maximum "Pool TVL multiplied by the implied APY of the pool."

Generally, the TVL of a pool is influenced by its hype and narrative, which aligns with the first objective. The real challenge, however, is to find a pool with the highest possible implied APY. Below are some factors to consider:

- **Pools with longer staking periods tend to have higher implied APYs.** For example, USD0++ is a USD0 staked for 4 years, which is considered a long duration in this industry. This is similar to traditional finance, where longer maturities generally offer higher interest rates due to the extended time horizon.
- **Pools from emerging sectors or new protocols often offer higher implied APYs.** These new pools come with higher risks, so a greater implied APY is typically needed to compensate investors for taking on this added risk.

It’s important to note that high TVL and high implied APY are often at odds with each other. Therefore, a comprehensive evaluation of each pool is necessary to balance these factors effectively.

## Solution





# QUESTION 2 USD0++

> Explain the mechanics and quirks of USD0++ as a yield generating asset. If Pendle tokenises it, how should the mechanics for YT-USD0++ work?

## Guideline

There are essentially two main issues to address:

1. The mechanics and unique characteristics of USD0++ as a yield-generating asset.
2. The tokenization mechanics for YT-USD0++ and how they should function.

Let’s break these down step by step.

## Solution 2.1

USD0 is a USD-pegged stablecoin fully backed by US Treasury Bill tokens. USD0++ is a **liquid staking token**(LST) derived from USD0, staked **for 4 years**.

**It offers daily yield distribution in \$USUAL tokens**, with **a variable rate** based on market price, and **guarantees a floor yield in USD0**, matching **the risk-free yield**. The mechanics can be showed clearly in the picture below.

![Source: https://tech.usual.money/overview/features/usd0++](https://cdn.jsdelivr.net/gh/zey9991/mdpic/image-20241213164900795.png)

1. **Claiming Yield (3):** The holder of the USD0++ can claim their yield daily in the form of USUAL tokens.
2. **Base Interest Guarantee (4) :** The holder of USD0++ is guaranteed a yield equivalent at minimum to the yield of the USD0 collateral (Risk-free yield). To achieve this, the user must lock their USD0++ for a specified period. At the end of this period, the user can choose to claim their rewards in the form of USUAL tokens or the risk-free yield in USD0. 
3. **Return of Principal:** At the end of the bond's maturity period, the holder receives their principal in the form of the initially locked USD0.

As we can see, the liquid staking token USD0++ is pegged to the price of the USD0 stablecoin, while staking rewards are distributed through $USUAL tokens.

The yield-generating mechanics of USD0++ can also be described using the concept of a Generic Yield Generating Pool (GYGP):

|               | Defination                                                   | Stkae USD0 in USUAL Protocol                                |
| ------------- | ------------------------------------------------------------ | ----------------------------------------------------------- |
| asset         | A unit to measure the value of the pool.                     | USD0                                                        |
| shares        | A unit that represents ownership of the pool.<br />SY tokens. | USD0++                                                      |
| reward tokens | The tokens that the pool earns over time.<br />(In the context of SYS: tokens generated from holding SY tokens over time.) | USUAL(*)                                                    |
| exchange rate | How many assets each share(SY token) is worth. In this case, USD0 value per USD0++. | Remains 1 in most cases due to the repegging mechanism.(**) |

(*) According to the documentation, users can opt to claim USD0 through the Base Interest Guarantee (BIG) mechanism. For simplicity, this option can be disregarded in the tokenization process for Pendle at this stage.

(**) We can also use the SY converter in Pendle's dApp to check if the exchange rate is 1, as expected. The image below supports this analysis. Alternatively, we can verify this directly by reviewing the codebase.

![Source: https://app.pendle.finance/trade/markets?utm_source=landing&utm_medium=landing](https://cdn.jsdelivr.net/gh/zey9991/mdpic/image-20241216104929551.png)

## Solution 2.2

![High Level Architecture](https://docs.pendle.finance/assets/images/high_level_architecture-457bcdd55f399a2d90b8c7bd9e2b6a09.png)

YT is a token that represents the rights to redeem the interest generated by the SY until it reaches maturity. It's important to note that the value of YT is zero once it reaches maturity. The yield can be redeemed at any time and it can be traded on PendleMarket using special methods.

### StandardizedYieldToken

**To tokenise the USD0++, we first need to wrap USD0++ into SY-USD0++ token**. 

As discussed in the whitepaper, the **SY token standard** is essentially an interface that adds an enum data type, several events (e.g., `Deposit`, `Redeem`, and `ClaimRewards`), and multiple functions (e.g., `deposit`, `redeem`, `redeemAfterTransfer`, `exchangeRate`, etc.) on top of the ERC-20 standard.

For example, the **SY-USD0++ token address on the Ethereum mainnet** is `0x52453825c287dDef62D647ce51C0979D27c461f7`. The core logic is implemented in the `PendleUsualUSD0PPSY.sol`. Below are some of its key functions:

**Constructor**:

- Initializes the contract with a name ("SY USD0++") and symbol ("SY-USD0++").
- Sets up infinite approval for `USD0` to `USD0PP` to allow seamless conversions.

**Deposit and Redemption**:

- `_deposit`:
  - Converts `USD0` tokens into `USD0PP` by calling the `mint` function on the `USD0PP` contract.
  - The number of shares (or tokens) issued is equivalent to the amount deposited.
- `_redeem`:
  - Call `_transferOut` function to transfers `USD0PP` tokens back to the user .

**Exchange Rate**:

- The `exchangeRate` function returns a fixed value of `1`, signifying a 1:1 exchange between the input and output tokens. This behavior indicates that no interest accrues at this contract level.

**Preview Functions**:

- `_previewDeposit`and `_previewRedeem`:
  - These functions mirror the deposit and redeem logic by returning input amounts as output amounts, reflecting the 1:1 ratio.

**Token Validity**:

- `getTokensIn` and `getTokensOut`:
  - Returns valid input (`USD0`, `USD0PP`) and output (`USD0PP`) tokens for the contract.
- `isValidTokenIn` and `isValidTokenOut`:
  - Validates whether a given token can be used as input or output.

**Asset Info**:

- Provides metadata about the underlying asset (`USD0PP`), including its type, address, and decimals.

### YieldToken

**Next, we can use the SYS (Standardized Yield Stripping) mechanism to split the SY token into YT and PT components**.

This mechanism is explained in the whitepaper. Below are some important state changes related to the YT token:

| State Changes                    | Implemented in              |
| -------------------------------- | --------------------------- |
| mint/redeem before expiry        | `PendleYieldToken.sol`      |
| earning of compound interests    | `InterestManagerYT.sol`     |
| earning of rewards for SY tokens | `RewardManagerAbstract.sol` |
| user claiming interests          | `InterestManagerYT.sol`     |

This means that the YT-USD0++ token is expected to at least support these functionalities. Based on the discussion in Solution 2.1, we can visualize the yield generated by the YT-USD0++ token in the following table:

| YT        | Interest | Rewards |
| --------- | -------- | ------- |
| YT-USD0++ | -        | USUAL   |

In production environment, the core logic related to YT-USD0++ token is written in the  `PendleYieldToken.sol` and `InterestManagerYT.sol` as well as `RewardManagerAbstract.sol` .

Now, let's take a quick look through these contracts.

#### `InterestManagerYT.sol`

This contract is responsible for responsible for managing and distributing interest.

Key Features:

1. **Interest Distribution**:

   - The contract calculates and distributes interest to users. The interest is based on the current `interestIndex`, which represents the cumulative interest accrued over time.
   - The `_distributeInterest` and `_distributeInterestForTwo` functions handle interest distribution for a single user or two users respectively.

2. **User Interest Tracking**:

   - The contract tracks each user's accrued interest and their position in the interest index. This is done using a 

     ```
     UserInterest
     ```

      struct, which stores:

     - `index`: The last recorded interest index for the user.
     - `accrued`: The amount of interest accrued by the user.

   - The `userInterest` mapping associates a user's address with their `UserInterest` data.

3. **Interest Collection**:

   - The function `_doTransferOutInterest` allows users to redeem their interest, transferring the appropriate amount to the user after deducting the fee.
   - The fee rate is retrieved from the `IPYieldContractFactory`, and a portion of the interest is sent to the treasury, while the rest is transferred to the user.

4. **Private Interest Distribution**:

   - The `_distributeInterestPrivate` function is a private method that updates the user's interest based on the difference between the current and previous interest index. If the user’s interest index has changed, their accrued interest is updated.

5. **Interest Calculation**:

   - The interest for each user is calculated based on their YT balance and the difference between the current and previous interest indices. This ensures that users earn interest based on how much of the underlying asset (SY) their YT represents.

Key Concepts:

- **Interest Index**: The interest index is a cumulative value that increases over time as interest is accrued. It is used to calculate how much interest a user should earn since the last time their interest was updated.
- **Accrued Interest**: This is the interest that a user has earned but not yet redeemed. The contract tracks and updates the accrued interest as the interest index changes.
- **Fee Deduction**: Before transferring interest to the user, a fee is deducted and sent to the treasury. The fee rate is controlled by the `IPYieldContractFactory` and is a fixed percentage of the total accrued interest.

Functions:

- `_distributeInterest`: This function distributes interest to a user, calling the internal `_distributeInterestForTwo` function for two users.
- `_distributeInterestForTwo`: This function distributes interest to two users.
- `_doTransferOutInterest`: This function allows the redemption of interest, transferring the correct amount to the user after deducting the fee.
- `_distributeInterestPrivate`: This private function handles the calculation of interest owed to an individual user, updating their accrued interest based on the interest index.
- `_getInterestIndex`: A virtual function to get the current interest index. Implemented by derived contracts.
- `_YTbalance`: A virtual function to get the balance of Yield Tokens for a user. Implemented by derived contracts.

#### `RewardManagerAbstract.sol`

This an abstract contract that handles the accrual, distribution, and redemption of rewards for users based on their holdings or "reward shares." The contract is designed to ensure that rewards are properly tracked and distributed, taking into account changes in the reward index over time.

Key Features:

1. **Reward State Management**:

   - The contract manages the reward states for each token by storing the current reward index and the last balance of each token for every user. This is done using the 

     ```
     RewardState
     ```

      struct, which contains:

     - `index`: The current reward index for a given token.
     - `lastBalance`: The user's last recorded balance for the token.

   - `UserReward`: A struct that tracks the user's accrued rewards and the last index used to calculate their rewards.

2. **Accruing and Distributing Rewards**:

   - Rewards are distributed based on the difference between the current reward index and the user's previous index.
   - The contract has functions to update and distribute rewards:
     - `_updateAndDistributeRewards`: This function updates the reward index and distributes rewards to a single user.
     - `_updateAndDistributeRewardsForTwo`: This function distributes rewards for two users simultaneously, improving efficiency.
     - `_distributeRewardsPrivate`: This function calculates the reward delta and updates the user's accrued rewards.

3. **Reward Redemption**:

   - The contract allows users to redeem their accrued rewards, which can be transferred to another address.
   - `_doTransferOutRewards` handles the transfer of rewards to the user, ensuring the correct amount of rewards are paid out.
   - `_redeemExternalReward`: This virtual function is meant to be implemented in derived contracts and handles the logic for redeeming external rewards.

4. **User Reward Calculation**:

   - Rewards are based on the user's reward shares, which represent their proportionate share of the total rewards pool.
   - The contract uses the `_rewardSharesUser` function to calculate the reward shares for each user.

Key Concepts:

- **Reward Index**: The reward index is a cumulative value that increases over time as rewards are accrued. It represents how much reward a user is entitled to based on their proportionate share of the total rewards pool.
- **Reward Shares**: This represents a user's share of the total rewards pool. The number of reward shares determines how much of the total rewards a user is entitled to when rewards are distributed.
- **Accrued Rewards**: This is the total amount of rewards a user has earned but not yet redeemed. The contract keeps track of this value and updates it as the reward index changes.

Functions:

1. **_updateAndDistributeRewards**: This function updates the reward index and distributes rewards to a single user.
2. **_updateAndDistributeRewardsForTwo**: This function distributes rewards to two users in one transaction.
3. **_distributeRewardsPrivate**: This private function distributes the rewards to the user, calculating the reward delta based on the change in the reward index.
4. **_updateRewardIndex**: A virtual function to update the reward index and return the tokens and their corresponding indices. This must be implemented by derived contracts.
5. **_redeemExternalReward**: This virtual function allows for the redemption of external rewards.
6. **_doTransferOutRewards**: This virtual function handles the transfer of rewards to the user. It returns the amount of rewards transferred.
7. **_rewardSharesUser**: This virtual function calculates the reward shares of a user. It must be implemented by derived contracts to return the correct amount.

#### `PendleYieldToken.sol`

This contract allows users to mint and redeem yield tokens , manage interest and rewards, and handle post-expiry actions.

Core Features:

1. **Minting Yield Tokens**:
   - **`mintPY`**: Tokenizes the SY into PT and YT in a 1:1 ratio.
   - **`mintPYMulti`**: Tokenizes SY into PT and YT for multiple receivers.
2. **Redeeming Yield Tokens**:
   - **`redeemPY`**: Redeems PT and YT for SY (interest and rewards are not redeemed at the same time).
   - **`redeemPYMulti`**: Redeems PT and YT for SY for multiple users.
3. **Interest and Rewards Redemption**:
   - **`redeemDueInterestAndRewards`**: Redeems interest and rewards for a user, based on the amount of SY their YT represents.
   - **`redeemInterestAndRewardsPostExpiryForTreasury`**: Collects the interest and rewards for the treasury after the expiry.
4. **Handling Expiry**:
   - **`setPostExpiryData`**: Sets data that can only be collected post-expiry (e.g., first PY index, rewards for treasury).
   - **`getPostExpiryData`**: Returns the post-expiry data, including the first PY index and user rewards.
5. **Reward Indexes**:
   - **`rewardIndexesCurrent`**: Returns the current reward indexes for SY.
   - **`pyIndexCurrent`**: Returns the current PY index, ensuring it is non-decreasing.
   - **`pyIndexStored`**: Returns the last-updated PY index.

Key Components:

1. **SY (Standardized Yield)**: Represents the yield-bearing asset being tokenized.
2. **PT (Principal Token)**: Represents the principal of the yield-bearing asset.
3. **YT (Yield Token)**: Represents the yield generated by the asset, allowing users to separate principal and yield.
4. **Factory**: The contract factory that deployed the token.
5. **Expiry**: The time at which the yield tokens expire, after which the yield will go to the treasury.
6. **PostExpiryData**: Stores the data related to the post-expiry period, such as the first PY index and the amount of rewards owed.

Expiry Logic:

- After the expiry date, all accrued rewards and interest will be transferred to the treasury.
- The contract uses `PostExpiryData` to track the first PY index and reward data post-expiry.

Events:

- **`Mint`**: Emitted when PY tokens are minted.
- **`Burn`**: Emitted when PY tokens are burned.
- **`RedeemInterest`**: Emitted when interest is redeemed.
- **`RedeemRewards`**: Emitted when rewards are redeemed.
- **`CollectRewardFee`**: Emitted when reward fees are collected.
- **`CollectInterestFee`**: Emitted when interest fees are collected.
- **`NewInterestIndex`**: Emitted when a new interest index is set.

Modifiers:

- **`updateData`**: Ensures that data is updated and that the post-expiry state is handled if applicable.
- **`notExpired`**: Reverts the transaction if the contract has expired.

Internal Functions:

- **`_mintPY`**: Handles the actual minting process for PT and YT tokens.
- **`_redeemPY`**: Handles the actual redemption process for PT and YT tokens back into SY.
- **`_calcPYToMint`**: Calculates the amount of PY to mint based on the current SY index.
- **`_calcSyRedeemableFromPY`**: Calculates how much SY can be redeemed from PY, considering post-expiry interest.

### YieldContractFactory

In a production environment, the **YieldToken** contract is deployed by the **YieldContractFactory** contract. Below is a brief overview of `PendleYieldContractFactory.sol`:

**Key Features**

1. **Principal Token (PT) and Yield Token (YT) Creation**
   The contract allows users to create a pair of **Principal Tokens (PT)** and **Yield Tokens (YT)** from a Standardized Yield (SY) token and an expiry date. 
2. **Customizable Fee Rates**
   The contract supports customizable **interest fee rates** and **reward fee rates**, which are applied to yield-bearing assets. These fees are set as fixed-point numbers and can be adjusted by the owner. The maximum allowed fee rate for both interest and rewards is 20% (2e17).
3. **Expiry Divisor**
   A divisor for expiry dates is set to ensure that only valid expiry dates, which are multiples of this divisor, are accepted. This is a mechanism to prevent incorrect or overly large expiry dates.
4. **Factory Initialization and Ownership**
   The contract is initialized with parameters like the **expiry divisor**, **interest fee rate**, **reward fee rate**, and the **treasury address**. The contract inherits from **BoringOwnableUpgradeable**, meaning that only the owner can update critical parameters such as fee rates, treasury, and expiry divisor.
5. **Create2 for Contract Deployment**
   The contract uses the **Create2** opcode for deterministic contract creation. This ensures that the contract addresses for PT and YT tokens are predictable and avoid collisions, which is particularly useful for deployments that need to guarantee contract addresses in advance.

**Functions**

1. **createYieldContract**
   This function creates a new yield contract (pair of PT and YT) for a given **Standardized Yield (SY)** token and expiry date. It validates the expiry date and ensures that the contract does not already exist. The function also initializes the newly created PT and YT with the required parameters.
   - **SY**: The Standardized Yield token.
   - **expiry**: The expiry date for the yield contract.
   - **doCacheIndexSameBlock**: A flag that determines if index caching should be done within the same block.
2. **setExpiryDivisor**
   This function allows the owner to set the **expiry divisor**, which ensures that the expiry date for new contracts is always a multiple of this divisor. It helps maintain consistency in expiry dates.
3. **setInterestFeeRate**
   This function allows the owner to set the **interest fee rate**, which dictates the portion of the yield that is allocated as a fee. It ensures that the fee rate is within the defined limit (20%).
4. **setRewardFeeRate**
   Similar to the interest fee rate, this function allows the owner to set the **reward fee rate**, which governs the portion of rewards that are collected as fees.
5. **setTreasury**
   This function sets the **treasury address**, where the collected fees (interest and reward fees) are sent. It is important to ensure that the treasury address is valid (not zero).
6. **_stripSYPrefix**
   This internal function strips the predefined prefixes from the SY token’s name and symbol. It ensures that the names and symbols are formatted correctly for PT and YT tokens.

### PendleMarket

**Once the new YT contracts are deployed, a marketplace for trading PT, YT, and SY tokens is required**. The core logic for this is outlined in the PT-AMM whitepaper and implemented in `PendleMarketV3.sol`.

Key Events:

- **Mint**: Triggered when LP tokens are minted.
- **Burn**: Triggered when LP tokens are burned.
- **Swap**: Triggered for both PT to SY swaps and SY to PT swaps.
- **UpdateImpliedRate**: Triggered when the implied interest rate is updated.

Functions:

1. **Constructor**:
   - The constructor initializes the contract with the principal token (`PT`), standardized yield (`SY`), yield token (`YT`), and other market-related parameters like `scalarRoot`, `initialAnchor`, and `lnFeeRateRoot`.
   - It also sets up the initial market state and observations using the `observations.initialize()` method.
2. **Minting LP Tokens (`mint`)**:
   - Users can mint LP tokens by providing a specified amount of PT and SY, ensuring that the total liquidity does not exceed the desired amounts.
   - The contract calculates how much LP tokens to mint, adds liquidity, and issues the corresponding LP tokens to the receiver.
   - The market state is updated, and minting is performed only if the contract holds sufficient PT and SY.
3. **Burning LP Tokens (`burn`)**:
   - LP holders can burn their LP tokens to receive back PT and SY in proportion to their share of the market.
   - The contract updates the market state after burning the LP tokens and transfers the PT and SY to the specified receivers.
4. **Swapping PT for SY (`swapExactPtForSy`)**:
   - This function allows users to swap an exact amount of PT for SY.
   - The contract calculates the amount of SY to be received and performs the swap, sending the SY to the receiver and transferring the necessary PT from the user.
   - It also includes a callback mechanism if additional data is passed.
5. **Swapping SY for PT (`swapSyForExactPt`)**:
   - Similar to the PT to SY swap, this function allows users to swap SY for an exact amount of PT.
   - It ensures that the required amount of SY is transferred to the contract and the exact amount of PT is given to the receiver.
6. **Skim Function (`skim`)**:
   - This function ensures that the contract’s internal balances of PT and SY match the reserves.
   - If there is any excess of PT or SY, it is transferred to the market’s treasury.
7. **Reward Redemption (`redeemRewards`)**: LP holders can redeem rewards via this function, which calls the internal `_redeemRewards` method to distribute the rewards.
8. **Oracle Observation (`observe`)**: This function provides an interface for querying the oracle data, which tracks the cumulative implied interest rates over time.
9. **State Management (`readState` and `_writeState`)**:
   - `readState`: Reads the current market state from storage for use in minting, burning, or swapping operations.
   - `_writeState`: Writes the updated market state back to storage after performing any operation.
10. **Expiration Check (`isExpired`)**: This function checks whether the market has expired based on the `expiry` timestamp.
11. **Pendle Gauge-related Functions**: The contract inherits from `PendleGauge` and overrides relevant functions like `_stakedBalance` and `_totalStaked` to interact with the staking mechanism.
12. **Oracle Functions**: Functions like `increaseObservationsCardinalityNext` allow the contract to manage its observation data for tracking market rates over time.

# References

1. [Usual Tech Hub | Usual Tech Docs](https://tech.usual.money/)
2. [$1.00 | USD0 Liquid Bond (USD0++) Token Tracker | Etherscan](https://etherscan.io/token/0x35d8949372d46b7a3d5a56006ae77b215fc69bc0#writeProxyContract)
3. [pendle-finance/pendle-core-v2-public](https://github.com/pendle-finance/pendle-core-v2-public/tree/main)
4. [pendle-core-v2-public/contracts/core/StandardizedYield/implementations/Usual/PendleUsualUSD0PPSY.sol at main · pendle-finance/pendle-core-v2-public](https://github.com/pendle-finance/pendle-core-v2-public/blob/main/contracts/core/StandardizedYield/implementations/Usual/PendleUsualUSD0PPSY.sol)
5. [PendleYieldToken | Address 0xf650494e751878b6b2b4006d2e0618ef3e9e2579 | Etherscan](https://etherscan.io/address/0xf650494e751878b6b2b4006d2e0618ef3e9e2579#code)
6. [PendleMarketV3 | Address 0x22a72b0c504cbb7f8245208f84d8f035c311adec | Etherscan](https://etherscan.io/address/0x22a72b0c504cbb7f8245208f84d8f035c311adec)

