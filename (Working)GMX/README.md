# (Working)GMX

![](https://cdn.jsdelivr.net/gh/zey9991/mdpic/LYS%20Lab%E4%BB%8B%E7%BB%8D%E5%88%9D%E7%A8%BF_00.png)

## 结论

## 风险

## 基本面

### 简介

GMX 是一个去中心化的现货和永续合约交易所，支持低交易费用和零价格影响交易。交易由独特的多资产池支持，该池通过做市、交易费和杠杆交易赚取流动性提供者费用。

### 团队

### 产品/服务

GMX V1 版本于 2021 年底推出，在衍生品 DEX 协议中具有重要的地位。不少项目都 fork 了 GMX V1 的模型。

2023年7月，GMX V2版本推出。

本节主要介绍现货和永续合约交易服务，有关做市或流动性提供服务将在后文介绍。

### 财务

#### 代币经济学

##### **效用和治理代币 $GMX**

（预期）最大供应量：13.25M

- 但在有需要的情况下，会出现超过此最大供应量的铸造。此要求必须经过 GMX 治理部门的投票和批准，然后才能获得批准。

供应分配：

- 600 万 GMX：[XVIX](https://xvix.finance/) 和 [Gambit](https://gambit.financial/) 迁移。GMX 是由 XVIX 和 Gambit 社区合并而成的。
- 200 万 GMX：与 ETH 配对，在 [Uniswap](https://app.uniswap.org/#/swap?inputCurrency=ETH&outputCurrency=0xfc5A1A6EB076a2C7aD06eD22C90d7E710E35ad0a) 上提供流动性。
- 200 万个 GMX：预留用于esGMX代币的Vesting。
- 200 万 GMX：用于国库。
- 100 万 GMX：用于集成激励和社区开发者。
- 250,000 GMX：在 2 年内线性分配给贡献者。
- 目前（2024年10月19日）只剩下esGMX的份额仍在释放，预计将线性释放至2028年9月，其他份额已经释放完毕，因此后续因解锁导致的抛压小。

![image-20241019095325403](https://cdn.jsdelivr.net/gh/zey9991/mdpic/image-20241019095325403.png)

图源：[GMX (GMX) | Tokenomics, Supply & Release Schedule (tokenomist.ai)](https://tokenomist.ai/gmx)

应用场景：GMX协议提供的主要是质押，可以获取三种类型的奖励。

- 70%的交易费用：分享70%的平台交易费用，代币为ETH 或 AVAX。 
  - 如果在 Arbitrum 上质押将获得 ETH；
  - 如果在 Avalanche 上质押将获得 AVAX。
  - 用户必须手动领取奖励并进行复投操作。尽管Arbitrum和Avalanche的费用很低，但手动复投多次势必会产生相应的手续费。
- 托管 GMX（esGMX，Escrowed GMX）：
  - 获取：托管 GMX将按照最新快照投票中的计划分配给质押的GMX和GLP。
  - 质押：质押以获取与常规GMX代币类似的奖励：每个质押的托管GMX代币将获得与常规GMX代币相同数量的托管GMX和ETH/AVAX奖励。
  - Vesting：在启动vesting后，esGMX代币将每秒逐步转换为GMX，并在365天内完全vesting。已转换为GMX的esGMX代币可以随时领取。
  - 托管GMX一般不可转让。
- 乘数积分（Multiplier Points）：
  - 获取：当你质押GMX时，你将以100% APR的固定速率每秒获得Multiplier Points。1000个GMX质押一年将获得1000个Multiplier Points。
  - 质押：Multiplier Points可以质押以获取手续费奖励，每个质押的Multiplier Point将以与常规GMX代币相同的速率赚取ETH/AVAX。
  - 奖励加成机制：例如，如果ETH的年收益率为10%，你持有价值10,000美元的GMX和esGMX，那么你的年化奖励将是1,000美元。如果你持有的Multiplier Points相当于你总GMX和Escrowed GMX数量的20%，那么你的“Boost Percentage”将显示为20%，你将额外获得200美元的年化ETH奖励。
  - 奖励加成上限：最大提升比例为200%，这意味着如果你拥有1000个GMX代币，并拥有2500个Multiplier Points，那么最多可质押2000个Multiplier Points以获得200%的提升；剩下的500个Multiplier Points无法质押，要质押这些Multiplier Points，需要获得额外的GMX代币，例如，如果购买了100个额外的GMX，那么这500个Multiplier Points中的200个可以质押。

##### **流动性提供代币 $GLP(v1) \$GM(v2)**

**GMX V1的流动性代币：$GLP**

![image-20241018230341001](https://cdn.jsdelivr.net/gh/zey9991/mdpic/image-20241018230341001.png)

图源：[Dashboard | Decentralized Perpetual Exchange | GMX](https://app.gmx.io/#/dashboard)

供应：前文已经说明了，GMX采用点对池的交易模型，流动性提供代币 GLP 由用于兑换和杠杆交易的一系列资产组成。可以使用任一成分资产铸造 GLP，销毁 GLP 以赎回任一成分资产。这实际上类似于传统金融股票市场的指数，每个代币就相当于计算指数的成分股。通常，池子里有稳定币部分和非稳定币部分。截至2024年10月18日，GLP共发行47M，总市值在65M美金附近。

![image-20241018225655680](https://cdn.jsdelivr.net/gh/zey9991/mdpic/image-20241018225655680.png)

铸造和赎回的价格：基于如下公式计算

$\frac{指数中所有资产的总价值，包括未平仓头寸的利润和损失}{GLP 的总供应量}$

代币权重与交易手续费：在铸造GLP、销毁GLP或执行代币交换时，手续费会根据这些操作是增加还是减少资产的平衡而有所不同。我们可以通过一个具体的例子来解释，假设GLP的资产池中有两种代币：**ETH**和**USDC**。当前的代币权重是**ETH 70%\**和\**USDC 30%**，也就是说ETH在资产池中占了大部分。

- 如果用户想用ETH来铸造GLP，那么这会**增加ETH的比例**，进一步加大ETH在池中的权重。所以，这种操作的手续费会较高。相反，如果用户用USDC来铸造GLP，这将**平衡ETH和USDC的比例**，因此手续费较低。
- 如果用户赎回ETH，这会**减少ETH的比例**，因为资产池中的ETH减少了。因此，这种操作的手续费较低。如果用户赎回USDC，由于这会进一步减少本来占比较小的USDC，操作的手续费会相对较高。
- 我们可以通过Dashboard查看代币的权重。实际中，GMX V1给每个成分代币设定一个目标权重，并基于目标权重和实际权重的大小关系实现上述的各种调节。

![image-20241018224526933](https://cdn.jsdelivr.net/gh/zey9991/mdpic/image-20241018224526933.png)

图源：[Dashboard | Decentralized Perpetual Exchange | GMX](https://app.gmx.io/#/dashboard)

从下图可以看出，低于目标权重的几个代币（ETH，USDC.e，USDT）的手续费都是比较低的。

![image-20241018230036616](https://cdn.jsdelivr.net/gh/zey9991/mdpic/image-20241018230036616.png)

图源：[GMX | Decentralized Perpetual Exchange](https://app.gmx.io/#/buy_glp)

交易方向： GLP 持有者为杠杆交易提供流动性（作为杠杆交易者的对手方），当杠杆交易者亏损时，GLP 持有者获利，反之亦然。实际上，GLP持有者在每笔交易中就是持有与交易者大小相等，方向相反的头寸/仓位。





### 竞品

## 参与机会





## 参考链接

1. [GMX | GMX Docs](https://docs.gmx.io/docs/intro/)
2. [**去中心化永续合约交易所：技术、市场与前沿预测 (qq.com)**](https://mp.weixin.qq.com/s/LPiJYixkGyE0wbw2Xs6SMw)
3. **[GMX的常见误解总结，GLP在极端行情中会归零？ - PANews (panewslab.com)](https://www.panewslab.com/zh/articledetails/ievrx7b2.html)**
4. [逆市而涨的GMX，能否成为去中心化永续合约新的王者？ - PANews (panewslab.com)](https://www.panewslab.com/zh/articledetails/1643522822971920.html)
5. [GMX：Arbitrum 生态头部衍生品交易平台 | defi.to](https://www.defi.to/cn/gmx/)
6. [GMX逆势生长的背后：真实收益、代币设计及潜在风险_腾讯新闻 (qq.com)](https://new.qq.com/rain/a/20221011A03XWU00)
7. [GMX (GMX) (binance.com)](https://www.binance.com/zh-CN/research/projects/gmx)
8. [GMX v2 及其竞争对手：颠覆去中心化衍生品市场的新浪潮 - 深潮TechFlow (techflowpost.com)](https://www.techflowpost.com/article/detail_17141.html)

## 利益披露与免责声明

利益披露：截至发稿前，作者（Peyton）与Xterio无任何商业利益行为。

免责声明：教程所有内容均不构成投资建议，仅供参考。加密货币相关资风险极高，极容易归零，请在参与时谨慎做出决策，并严格遵守相关法律法规。

![](https://cdn.jsdelivr.net/gh/zey9991/mdpic/LYS%20Lab%E4%BB%8B%E7%BB%8D%E5%88%9D%E7%A8%BF_09.png)