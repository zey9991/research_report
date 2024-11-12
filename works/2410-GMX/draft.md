# GMX：

![](https://cdn.jsdelivr.net/gh/zey9991/mdpic/LYS%20Lab%E4%BB%8B%E7%BB%8D%E5%88%9D%E7%A8%BF_00.png)

## 结论

## 风险

## 基本面

### 简介

GMX 是一个部署在ARB和AVAX的去中心化的现货和永续合约交易所，支持低交易费用和零价格影响交易。交易由独特的多资产池支持，该池通过做市、交易费和杠杆交易赚取流动性提供者费用。目前该协议有V1和V2两个版本，版本之间区别较大，将在下文详细论述。

### 团队

团队成员均为匿名。

- 根据RootData信息，coinflipcanada 是 GMX 的核心贡献者，专注于战略和生态系统开发。他也是 Camelot DAO 的创始顾问，制定其生态系统战略。
- GMX DAO 管理员（Admins）：xdev_10，Saurabh，BlueBerry_KR
- GMX DAO 版主（Moderators）：Seraph，Tano，Jonezee

![image-20241020165623750](https://cdn.jsdelivr.net/gh/zey9991/mdpic/image-20241020165623750.png)

图源：[About - GMX](https://gov.gmx.io/about)

### 产品

自2021年9月问世以来，GMX V1无疑是去中心化衍生品交易行业中最成功的模型之一，其为交易者提供了简单方便的交易模式。此外，由于其对代币经济学的巧妙设计，将部分协议的费用分配给<u>1.效用和治理代币GMX质押者</u>以及<u>2.流动性提供者</u>，成功打造了**“真实收益”**的叙事，吸引了众多用户参与协议生态。

2023年7月，GMX V2版本正式上线，主要解决V1版本面临的一系列问题：未平衡的未平仓合约（OI）给LPs带来更高风险、较高的费用对中小型交易者不利、LPs对一篮子资产的广泛敞口、可交易资产有限以及资本效率低下与利用率障碍等等。为方便各位读者，笔者将GMX V1和V2版本的主要区别总结如下：

|                | GMX V1：更适合中大型交易                                     | GMX V2：更适合中小型交易                                     |
| -------------- | ------------------------------------------------------------ | ------------------------------------------------------------ |
| 交易费用       | 无滑点，预言机喂价 <br />开/平仓费用<br />交换费用 <br />借款费用 <br />网络费用 | 新增价格影响机制<br />降低开平仓费用<br /> 新增资金费率<br /><br /> 修改借款费用的支付 |
| 订单类型       | 市价单、止盈止损单                                           | 新增限价单                                                   |
| 抵押资产       | 全额支持市场（Fully backed markets）                         | 引入合成资产市场（Synthetic markets）                        |
| 杠杆上限       | 资金池的全部价值                                             | 可能会自动减杠杆（ADL）。                                    |
| 资金池类型     | 聚合资产池（GLP）                                            | 隔离资产池（GM）+聚合资产池（GLV）                           |
| 可交易资产数量 | 9                                                            | 24                                                           |
| 预言机         | -                                                            | 与Chainlink共同开发低延迟预言机                              |
| 收入分配       | 70%给LP，即GLP持有者；<br /> 30%给效用和治理代币GMX质押者。  | 63%给LP，即GM/GLV持有者。 <br />27%给效用和治理代币GMX质押者。 <br />10%转入项目国库（其中1.2%支付给Chainlink的低延迟预言机喂价服务）。 |

本文重点关注这几个关键不同：

1. **新的交易费用方案：**

- 开仓/平仓费用从0.1%减半至0.05%或 0.07%，在一众竞品的手续费率中排行中等。
- 保留借贷费率，确保流动性池的未平仓合约不会被无成本占用。
- 引入资金费率，奖励市场中的弱势方，鼓励套利交易驱动市场达到均衡，对LP更加友好。（可以简单理解如下：LP就是做市商，做市商就是通过高卖低买赚取利润，要是单边行情做市商不一定吃得消）。
- 实施价格影响机制，使多空倾向于平衡的交易将获得更有利的价格，不平衡的交易获得负面价格影响。这不利于中大型交易。

![image-20241019142832869](https://cdn.jsdelivr.net/gh/zey9991/mdpic/image-20241019142832869.png)

图源：[Dashboard | Decentralized Perpetual Exchange | GMX](https://app.gmx.io/#/dashboard)

2. **引入隔离资产池GM池：**

- 在V1的GLP模型下，每一个可交易资产都必须被纳入GLP池中，也就是说只有一个单一的GLP池在提供流动性。GLP池类似股票市场中的指数基金，由多个“成分股”（代币）组成，只不过该基金不是意在主动管理提高收益，而是专门用于给交易者提供流动性。虽然GLP池能够一定程度上聚合流动性，但LP有可能“被迫”持有其原本不希望持有的资产，而且单一资产出现风险可能导致所有 GLP 持有者面临损失。

![image-20241019143047154](https://cdn.jsdelivr.net/gh/zey9991/mdpic/image-20241019143047154.png)

图源：[Dashboard | Decentralized Perpetual Exchange | GMX](https://app.gmx.io/#/dashboard)

- V2中，可以将单一的流动性池 GLP 用多个风险隔离的 GM 池代替，每一种资产的流动性都是独立的，可以支持更多长尾资产。 GM 池就类似于Uniswap的代币对流动性池，熟悉Uniswap的朋友看到下图应该很亲切。总之，LP可以自由选择他们希望提供流动性的资产。当一种资产价格面临风险时，也不会使所有流动性提供者面临风险。


![image-20241019142959038](https://cdn.jsdelivr.net/gh/zey9991/mdpic/image-20241019142959038.png)

图源：[Dashboard | Decentralized Perpetual Exchange | GMX](https://app.gmx.io/#/dashboard)

3. **保留聚合资产池GLV池：**

- 每个GLV Vault（Vault直译就是金库的意思）都聚合了各种GM交易池，而这些交易池都具有相同的基础多头代币和空头代币。这实际上和V1的GLP池子很类似：如果你购买GLV，就相当于批量购买了某类市场的GM代币，相当于买入一个指数基金，该指数基金会自动放贷给市场交易者。

- 目前，GMX V2共支持两类GLV池，分别是BTC-USDC和WETH-USDC，如下图所示：

  ![image-20241019150156684](https://cdn.jsdelivr.net/gh/zey9991/mdpic/image-20241019150156684.png)![image-20241019150135342](https://cdn.jsdelivr.net/gh/zey9991/mdpic/image-20241019150135342.png)

  图源：[V2 Pools | Decentralized Perpetual Exchange | GMX](https://app.gmx.io/#/pools)

- GLV有助于GMX：
  - 提高资本效率：GLV允许汇总流动性，减少碎片化，提高资本部署的整体效率。
  - 改善交易者流动性：GLV内的主动再平衡有助于保持最佳流动性水平，从而为交易者提供更好的交易体验。
  - 简化LP体验：通过将流动性整合到GLV中，LPs可以更有效地管理其投资，而无需跟踪多个单独的交易池。
  - 简化新市场上市流程：被确定为安全的市场可以直接整合到适当的GLV中，确保这些市场能够获得足够的流动性，而无需单独为新市场引导流动性。


4. **引入合成资产市场（Synthetic markets）**

- 其特点是可以通过多种资产的组合来模拟其他资产的表现，而非直接使用实际的资产。比如ETH-USDC支持的DOGE永续合约市场。
- V1中是 全额支持市场（Fully backed markets），例如由ETH-USDC支持的ETH永续市场，仓位的上限由池中的ETH和USDC数量决定。

请注意，尽管V2费用更低，但由于引入了价格影响机制，加之考虑到最大杠杆的限制，V2对巨鲸的吸引力比较有限。但是GMX V2协议仍在不断演进中，近期GMX DAO的一个[热门提案](https://gov.gmx.io/t/gmx-fee-reduction-proposal/3988)就是要根据交易体量设置不同的费率，如果未来此类型的提案通过，或将改变V2对中大型交易不利的现状。

![image (2)](https://global.discourse-cdn.com/flex020/uploads/gmx/original/2X/e/e3fd016a0fb3c6f7acb993b8fc6d9fd2210bd40e.jpeg)

新提案中根据交易体量设置的交易费率 图源：[GMX Fee reduction proposal - Feature Discussion - GMX](https://gov.gmx.io/t/gmx-fee-reduction-proposal/3988)

### 财务

#### 代币经济学

##### **效用和治理代币 $GMX**

**（预期）最大供应量：**13.25M

- 但在有需要的情况下，会出现超过此最大供应量的铸造。此要求必须经过 GMX 治理部门 GMX DAO 的投票和批准。

**价格**：~$23.04（2024年10月22日）

**市值：**~$224.68M（2024年10月22日）

**供应分配：**

| 数量（GMX） | 比例 (%) | 说明                                                         |
| ----------- | -------- | ------------------------------------------------------------ |
| 600 万      | 60.0     | [XVIX](https://xvix.finance/) 和 [Gambit](https://gambit.financial/) 迁移。GMX 是由 XVIX 和 Gambit 社区合并而成。 |
| 200 万      | 20.0     | 与 ETH 配对，在 [Uniswap](https://app.uniswap.org/#/swap?inputCurrency=ETH&outputCurrency=0xfc5A1A6EB076a2C7aD06eD22C90d7E710E35ad0a) 上提供流动性。 |
| 200 万      | 20.0     | 预留用于 esGMX 代币的 Vesting。                              |
| 200 万      | 20.0     | 用于国库。                                                   |
| 100 万      | 10.0     | 用于集成激励和社区开发者。                                   |
| 250,000     | 2.5      | 在 2 年内线性分配给贡献者。                                  |

目前（2024年10月19日）只剩下esGMX的份额仍在释放，预计将线性释放至2028年9月，其他份额已经释放完毕，因此后续因解锁导致的抛压小。

![image-20241019095325403](https://cdn.jsdelivr.net/gh/zey9991/mdpic/image-20241019095325403.png)

图源：[GMX (GMX) | Tokenomics, Supply & Release Schedule (tokenomist.ai)](https://tokenomist.ai/gmx)

**应用场景：**GMX协议提供的主要是质押，可以获取三种类型的奖励。当然也可以参与GMX DAO的治理，需要质押 GMX（和 esGMX）代币按 1:1 的比例获得 GMX DAO 代币，不过本文不详细讨论细节了。

- 30%的交易费用：分享30%的平台交易费用，代币为ETH 或 AVAX。 
  - 如果在 Arbitrum 上质押将获得 ETH；
  - 如果在 Avalanche 上质押将获得 AVAX。
  - 用户必须手动领取奖励并进行复投操作。尽管Arbitrum和Avalanche的费用很低，但手动复投多次势必会产生相应的手续费。
- 托管 GMX 代币（esGMX，Escrowed GMX）：
  - 获取：托管 GMX将按照最新快照投票中的计划分配给质押的GMX和GLP。
  - 质押：质押以获取与常规GMX代币类似的奖励：每个质押的托管GMX代币将获得与常规GMX代币相同数量的托管GMX和ETH/AVAX奖励。
  - Vesting：在启动vesting后，esGMX代币将每秒逐步转换为GMX，并在365天内完全vesting。已转换为GMX的esGMX代币可以随时领取。
  - 托管GMX一般不可转让。
- 乘数积分（Multiplier Points）：
  - 获取：当你质押GMX时，你将以100% APY的固定速率每秒获得Multiplier Points。1000个GMX质押一年将获得1000个Multiplier Points。
  - 质押：Multiplier Points可以质押以获取手续费奖励，每个质押的Multiplier Point将以与常规GMX代币相同的速率赚取ETH/AVAX。
  - 奖励加成机制：例如，如果ETH的年收益率为10%，你持有价值10,000美元的GMX和esGMX，那么你的年化奖励将是1,000美元。如果你持有的Multiplier Points相当于你总GMX和Escrowed GMX数量的20%，那么你的“Boost Percentage”将显示为20%，你将额外获得200美元的年化ETH奖励。
  - 奖励加成上限：最大提升比例为200%，这意味着如果你拥有1000个GMX代币，并拥有2500个Multiplier Points，那么最多可质押2000个Multiplier Points以获得200%的提升；剩下的500个Multiplier Points无法质押，要质押这些Multiplier Points，需要获得额外的GMX代币，例如，如果购买了100个额外的GMX，那么这500个Multiplier Points中的200个可以质押。

##### **流动性提供代币 $GLP(V1) / \$GM(V2)** / $GLV(V2)

###### **GMX V1的流动性代币：$GLP**

![image-20241018230341001](https://cdn.jsdelivr.net/gh/zey9991/mdpic/image-20241018230341001.png)

图源：[Dashboard | Decentralized Perpetual Exchange | GMX](https://app.gmx.io/#/dashboard)

**供应：**GMX V1采用点对池的交易模型，流动性提供代币 GLP 由用于兑换和杠杆交易的一系列资产组成。可以使用任一成分资产铸造 GLP，销毁 GLP 以赎回任一成分资产。这实际上类似于传统金融股票市场的指数，每个代币就相当于计算指数的成分股。通常，池子里有稳定币部分和非稳定币部分。截至2024年10月18日，GLP共发行47M。

**价格：**~\$1.3729（2024年10月18日）， 基于此公式计算：$\frac{指数中所有资产的总价值，包括未平仓头寸的利润和损失}{GLP 的总供应量}$

**市值：**~$65M（2024年10月18日）

![image-20241018225655680](https://cdn.jsdelivr.net/gh/zey9991/mdpic/image-20241018225655680.png)

图源：[Dashboard | Decentralized Perpetual Exchange | GMX](https://app.gmx.io/#/dashboard)

**价格影响：**在铸造GLP、销毁GLP或执行代币交换时，交易费用会根据这些操作是增加还是减少资产的平衡而有所不同。我们可以通过一个具体的例子来解释，假设GLP的资产池中有两种代币：**ETH**和**USDC**。当前的代币权重是**ETH 70%**和**USDC 30%**，也就是说ETH在资产池中占了大部分。

- 如果用户想用ETH来铸造GLP，那么这会**增加ETH的比例**，进一步加大ETH在池中的权重。所以，这种操作的手续费会较高。相反，如果用户用USDC来铸造GLP，这将**平衡ETH和USDC的比例**，因此手续费较低。

- 如果用户赎回ETH，这会**减少ETH的比例**，因为资产池中的ETH减少了。因此，这种操作的手续费较低。如果用户赎回USDC，由于这会进一步减少本来占比较小的USDC，操作的手续费会相对较高。

- 我们可以通过Dashboard查看代币的权重。实际中，GMX V1给每个成分代币设定一个目标权重，并基于目标权重和实际权重的大小关系实现上述的各种调节。

![image-20241018224526933](https://cdn.jsdelivr.net/gh/zey9991/mdpic/image-20241018224526933.png)

图源：[Dashboard | Decentralized Perpetual Exchange | GMX](https://app.gmx.io/#/dashboard)

从下图可以看出，低于目标权重的几个代币（ETH，USDC.e，USDT）的手续费都是比较低的。

![image-20241018230036616](https://cdn.jsdelivr.net/gh/zey9991/mdpic/image-20241018230036616.png)

图源：[GMX | Decentralized Perpetual Exchange](https://app.gmx.io/#/buy_glp)

**交易方向：** GLP 持有者为杠杆交易提供流动性（作为杠杆交易者的对手方），当杠杆交易者亏损时，GLP 持有者获利，反之亦然。实际上，GLP持有者在每笔交易中就是持有与交易者大小相等，方向相反的头寸/仓位。

###### GMX V2的流动性代币：$GM

![image-20241019142308186](https://cdn.jsdelivr.net/gh/zey9991/mdpic/image-20241019142308186.png)

图源：[Dashboard | Decentralized Perpetual Exchange | GMX](https://app.gmx.io/#/dashboard)

**供应：**目前已发行约197M的GM代币。

**价格：**取决于多头和空头代币的价格以及交易者未平仓头寸的净盈亏（PnL）。由于采用了隔离池的机制，每个流动性池的多头和空头代币不同，交易者未平仓头寸的净盈亏也不同，因此GM代币的价格没有一个统一的价格。

**价格影响：**类似V1。将在下文协议费用一节中一起讨论。

###### GMX V2的流动性代币：$GLV

![image-20241019150156684](https://cdn.jsdelivr.net/gh/zey9991/mdpic/image-20241019150156684.png)

GLV Vault包含多种GM代币，并会自动进行再平衡。这些GM代币从包含的市场中的杠杆交易和兑换中累积费用。前文已经提及了，这实际上和V1的GLP池子很类似：如果你购买GLV，就相当于批量购买了某类市场的GM代币，相当于买入一个指数基金，该指数基金会自动放贷给市场交易者。目前，GMX V2共支持两类GLV池，分别是BTC-USDC和WETH-USDC。

GLV[BTC-USDC]价格：~$1.1099（2024年10月22日）

GLV[BTC-USDC]市值：~$4M（2024年10月22日）

GLV[WETH-USDC]价格：~$1.0590（2024年10月22日）

GLV[WETH-USDC]市值：~$9M（2024年10月22日）

#### 协议费用：构成、现状与分配

##### 交易费用构成

GMX V1对交易者收取的交易费用主要包括：

- 开平仓费用：仓位大小的0.1%，注意是开和平仓都需要交一次。
- 交换费用：如果开平仓时需要进行币种交换，则需要抵押物规模的0.2%至0.8%作为交换费用。
- 借款费用：支付给对手方（GLP池）的费用，每小时开始时扣除，每小时的费用将根据利用率变化，计算公式为（借贷资产）/（池中总资产）* 0.01%。
- 网络费用：支付给Keeper在区块链上监视交易请求并执行的费用。

GMX V2对交易者收取的交易费用主要包括：

- 开平仓费用：仓位大小的0.05%-0.07%。
- 交换费用：对于稳定币收取0.005%-0.02%的费用，对于其他代币收取0.05%-0.07%的费用
  - 如果交易增加了稳定币池中代币的余额，则费用为0.005%；否则，费用为0.02%。
  - 如果交易增加了池中其他代币的余额，则费用为0.05%；否则，费用为0.07%。
- 借款费用：和V1不同，如果多头仓位多于空头仓位，则多头方需要支付借款费用；如果空头仓位多于多头仓位，则空头方需要支付借款费用。
- 网络费用：支付给Keeper在区块链上监视交易请求并执行的费用。
- 资金费用（Funding Fees）：该费率会根据多头和空头的平衡情况随时间变化。这类似CEX的交易体验，相信各位不陌生。
- 价格影响（Price Impact）：如果交易改善了多空平衡或资金池中的代币情况，则会产生正面的价格影响，否则会产生负面的价格影响。

##### LP代币费用构成

GMX V1和V2都向LP收取价格影响费用，只不过

- V1基于GLP池中某个代币目标权重和实际权重的大小关系来设定费用，如果实际权重>目标权重，增加费用；实际权重<目标权重，则减少费用。
- V2基于中GM池中代币对的平衡关系来设定价格影响费用，如果购买会破坏池中代币的平衡，增加费用；如果改善池中代币的平衡，则减少费用。如果资金池大体上是平衡的，大额购买可能会导致较大的负面价格影响，此时可以用等量的美元价值的多头代币和空头代币来购买GM代币以减小价格影响。

##### 收入分配

| 主体         | GMX V1                                 | GMX V2                                                       |
| ------------ | -------------------------------------- | ------------------------------------------------------------ |
| 流动性提供者 | 70%费用分配给GLP持有者。               | 63%的费用分配给GM/GLV持有者。                                |
| GMX质押者    | 30%费用分配给效用和治理代币GMX质押者。 | 27%的费用分配给GMX质押者。                                   |
| 项目国库     | -                                      | 10%转入项目国库（其中1.2%支付给Chainlink的低延迟预言机喂价服务）。 |

##### 收入现状

根据Tokenterminal的数据，自推出以来，GMX协议（包括V1和V2）总费用收入达到3.48亿美金，在DEX赛道中排名第5；在过去一年总费用收入达到0.89亿美金，排名第4。

![image-20241019110257053](https://cdn.jsdelivr.net/gh/zey9991/mdpic/image-20241019110257053.png)
![image-20241019110207350](https://cdn.jsdelivr.net/gh/zey9991/mdpic/image-20241019110207350.png)

图源：[Token Terminal | Fundamentals for crypto](https://tokenterminal.com/terminal/metrics/fees?v=NjBhOGJjYjk4ODUyNTEyYTNjMDkxZWRk)

3.48亿美金的总费用收入在去中心化衍生品赛道中排名第二，在过去一年里的0.89亿美金则力压dYdX排名第一。

![image-20241019110625148](https://cdn.jsdelivr.net/gh/zey9991/mdpic/image-20241019110625148.png)

![image-20241019110707327](https://cdn.jsdelivr.net/gh/zey9991/mdpic/image-20241019110707327.png)

图源：[Token Terminal | Fundamentals for crypto](!https://tokenterminal.com/terminal/metrics/fees?v=NDAyMGY4MDY4MGViNjdiNGNiNWIxOGI5)

### 竞品

推荐阅读[去中心化永续合约交易所：技术、市场与前沿预测](https://mp.weixin.qq.com/s/LPiJYixkGyE0wbw2Xs6SMw)。

> 永续合约 DEX ，主要分为订单簿和资金池两大类：
>
> **a. 订单簿**
>
> 本质上是一种匹配机制，匹配买入和卖出订单。但对流动性依赖做市商，存在监管风险。代表项目：dYdX。
>
> **b. 资金池**
>
>  一揽子资产做为 LP ：提供全局流动性。代表项目：GMX
>
> 合成资产：全局债务，减少现货摩擦。代表项目：Kwenta
>
> vAMM 模式：保护抵押品，零无常损失。代表项目：Perpetua Protocol

接下来本文从三个维度（去中心化现货与合约交易所、去中心化衍生品交易所、去中心化交易所）、四个指标（交易量、市值、总锁仓价值和费用）入手，对GMX的竞争格局做一个简单的分析。





## 参与机会

![image-20241019163752780](https://cdn.jsdelivr.net/gh/zey9991/mdpic/image-20241019163752780.png)

图源：[Buy GLP or GMX | Decentralized Perpetual Exchange | GMX](https://app.gmx.io/#/buy)

注意：GMX协议前端计算的APY是基于过去七天收取的费用进行估算的，它不包含基础代币的价格变动、交易者的盈亏（PnL）以及资金费用。

### 策略一：购买并质押$GMX

- GMX质押APY：8.62%
- 通过Vesting转化esGMX为GMX：
- 继续质押乘数积分MP增强收益：
- 价格：~$23.43

### 策略二：提供流动性并质押$GLP/\$GM/\$GLV

- GLP
  - 质押APY：~4.56%-5.25%
  - 价格：~$1.3727
- GM
  - 质押APY：~4.56%-5.25%
  - 价格：因池子而异
- GLV[WETH-USDC]
  - 质押APY：~13.91%
  - 价格：~$1.0579
- GLV[BTC-USDC]
  - 质押APY：~11.84%
  - 价格：~$1.1180

## 参考链接

1. [GMX | GMX Docs](https://docs.gmx.io/docs/intro/)
2. [**去中心化永续合约交易所：技术、市场与前沿预测 (qq.com)**](https://mp.weixin.qq.com/s/LPiJYixkGyE0wbw2Xs6SMw)
3. **[GMX的常见误解总结，GLP在极端行情中会归零？ - PANews (panewslab.com)](https://www.panewslab.com/zh/articledetails/ievrx7b2.html)**
4. [逆市而涨的GMX，能否成为去中心化永续合约新的王者？ - PANews (panewslab.com)](https://www.panewslab.com/zh/articledetails/1643522822971920.html)
5. [GMX：Arbitrum 生态头部衍生品交易平台 | defi.to](https://www.defi.to/cn/gmx/)
6. [GMX逆势生长的背后：真实收益、代币设计及潜在风险_腾讯新闻 (qq.com)](https://new.qq.com/rain/a/20221011A03XWU00)
7. [GMX (GMX) (binance.com)](https://www.binance.com/zh-CN/research/projects/gmx)
8. [GMX V2 及其竞争对手：颠覆去中心化衍生品市场的新浪潮 - 深潮TechFlow (techflowpost.com)](https://www.techflowpost.com/article/detail_17141.html)

## 利益披露与免责声明

利益披露：截至发稿前，作者（Peyton）与Xterio无任何商业利益行为。

免责声明：教程所有内容均不构成投资建议，仅供参考。加密货币相关资风险极高，极容易归零，请在参与时谨慎做出决策，并严格遵守相关法律法规。

![](https://cdn.jsdelivr.net/gh/zey9991/mdpic/LYS%20Lab%E4%BB%8B%E7%BB%8D%E5%88%9D%E7%A8%BF_09.png)