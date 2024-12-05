# 零融资衍生品DEX龙头GMX：V2上线一年后，现状如何？

撰文：Peyton，Gryphsis Academy 学员（X：[@0xPeyton404](https://x.com/0xPeyton404)，[@GryphsisAcademy](https://x.com/GryphsisAcademy)）

导师：Scott（X：[@0xScottBTC](https://x.com/0xScottBTC)）

# 摘要

1.GMX 是一个部署在Arbitrum和Avalanche区块链上的去中心化的现货和永续合约交易所。随着2023年8月GMX V2上线，其产品体验进一步得到优化，特别是流动性池种类的丰富，满足了不同偏好LP的需求。长远来看，GMX期望成为DeFi 生态中的无许可基础层。

2.GMX团队成员均为匿名，项目罕见的没有任何种子资金或风险投资支持，完全由社区驱动。

3.GMX拥有极强的创收能力，自2021年9月正式上线以来，GMX协议累计实现了3.5647亿美金的交易费用，其中归属协议或GMX持有者的份额达1.0698亿美金，扣除代币激励后的利润达到4750万美金。

4.GMX协议的收入主要来源就是交易费用，其中大部分分配给流动性提供者，小部分留给效用和治理代币持有者，10%转入项目国库。

5.分版本来看，GMX V2已经在未平仓位和TVL方面大幅超越V1，不过，由于费用结构的变更和存续时间较短，V2产生的费用总量还仅占V1的25.91%。用户向V2的转移仍在进行中。分链来看，Arbitrum在用户偏好、交易活跃度和资金吸引力方面相较Avalanche更具竞争力。分现货和杠杆交易来看，现货仅占很小一部分。

6.GMX协议在23Q4-24Q3时间段的平均月活、交易量、Mcap/TVL、费用和收入以及利润这几个指标的表现上要优于去中心化衍生品交易所赛道的一众蓝筹项目，特别是平均费用总量（\$28.8M）遥遥领先于包括dYdX在内的其他竞争对手，而平均月活跃用户（19.98K）仅次于本轮新兴项目Pendle。

7.GMX有两种代币：效用与治理代币和流动性提供代币。其中，效用与治理代币\$GMX预期最大供应量为13.25M，几乎全流通，后续抛压小。流动性提供代币的供应无上限，分配则由市场存入的资金量决定。

8.GMX目前主要面临的风险：一是去中心化衍生品交易所赛道竞争激烈，而GMX的费率偏高，面临一定的竞争风险。二是目前GMX协议仅在Arbitrum和Avalanche两条链上部署，在以太坊与L2叙事热度不再，BTC和meme预期走高的背景下，对用户的吸引力有所下降。

# 背景

尽管DEX赛道一直被长期看好，但是从近期市场结构来看，现货及衍生品交易仍然被 CEX 垄断。然而，却有这样一个当前牛市的新入坑散户闻所未闻的项目，凭借完全匿名的团队，在零融资的条件下，做到了衍生品交易DEX赛道的龙头，年平均利润达到 1132 万美金。

这个当前牛市下的“隐形冠军”就是老牌DEX项目GMX。

自2021年9月推出以来，GMX协议总费用收入达到3.48亿美金，在DEX赛道中排名第5，在衍生品DEX赛道排名第2；在过去一年总费用收入达到0.89亿美金，在DEX赛道中排名第4，衍生品DEX赛道力压dYdX排名第1。

![过去一年DEX板块费用排名 图源：https://tokenterminal.com/terminal/metrics/fees?v=NjBhOGJjYjk4ODUyNTEyYTNjMDkxZWRk](https://cdn.jsdelivr.net/gh/zey9991/mdpic/image-20241019110207350.png)

![过去一年衍生品DEX板块费用排名 图源：https:/tokenterminal.com/terminal/metrics/fees/](https://cdn.jsdelivr.net/gh/zey9991/mdpic/image-20241019110707327.png)

尽管此轮牛市中GMX的讨论度不及meme和BTCFi等等叙事，笔者认为GMX还是有不少值得学习研究之处。本文介绍了GMX的基本面，重点分析了其产品体验和商业模式，以求尽可能地让读者了解到GMX背后的成功原因。

# 1.项目简介

GMX 是一个部署在Arbitrum和Avalanche区块链上的去中心化的现货和永续合约交易所，支持低交易费用和零价格影响交易。交易由多种资产池支持，该池通过做市、交易费和杠杆交易赚取流动性提供者费用。目前该协议有V1和V2两个版本，版本之间体验区别较大。

# 2.团队背景

团队成员均为匿名，公开信息有限：

* 项目创始人推特昵称为 x\_dev10，是连续创业者，曾创建过 XVIX、杠杆代币、Gambit、GMX 项目。
* coinflipcanada 是 GMX 的核心贡献者，专注于战略和生态系统开发。他也是 Camelot DAO 的创始顾问，制定其生态系统战略。

另外，GMX协议由GMX DAO治理，已知信息如下：

* GMX DAO 管理员（Admins）：xdev\_10，Saurabh，BlueBerry\_KR
* GMX DAO Mods（Moderators）：Seraph，Tano，Jonezee

![图源：https://gov.gmx.io/about](https://cdn.jsdelivr.net/gh/zey9991/mdpic/image-20241020165623750.png)

2023年7月，GMX DAO Mod Jonezee回答核心贡献者匿名的原因：

* 隐私和个人安全。
* 能够掌控自己的公众形象，并且能够将过去和现在的努力（无论是加密领域还是其他领域）明确区分开来。
* 监管和法律管辖的不确定性。

除此之外，GMX协议也是罕见的没有任何种子资金或风险投资支持，全凭社区驱动做成赛道龙头的项目。截至2024年10月26日，尚未在公网上搜索到GMX协议的融资信息。

不过，GMX协议曾收到Arb或Avalanche的生态资助，例如：

* 2024年7月，GMX加入Avalanche Rush活动，将在数月的时间内分配价值 400 万美元的 AVAX 以支持 GMX。
* 2024年6月，GMX 向 Arbitrum DAO 提交的 STIP-Bridge 提案已被接受，获得540 万枚 ARB 代币，将在 12 周内用于流动性、交易和授予激励。于 2024 年 6 月 26 日开始，持续到 9 月的第二周

# 3.历史事件

| 时间      | 事件                                                    |
| ------- | ----------------------------------------------------- |
| 2021.09 | GMX V1在Arbitrum上线                                     |
| 2021.11 | GMX V1交易量超过65亿美金，TVL超过1亿美金                            |
| 2021.12 | 由XM92主导的社区NFT项目GMX蓝莓俱乐部成立                             |
| 2022.01 | GMX V1在Avalanche上线                                    |
| 2022.10 | GMX V2的智能合约发布                                         |
| 2022.12 | GMX获GMXRush活动1.1万个AVAX代币资助                            |
| 2023.05 | GMX V2测试网向公众开放                                        |
| 2023.08 | GMX V2 Beta推出                                         |
| 2023.10 | GMX V2 Arbitrum主网集成全新低延迟预言机解决方案Chainlink Data Streams |
| 2023.11 | GMX获 STIP-Bridge 提案的1200万枚ARB代币资助                     |
| 2024.02 | GMX一键交易功能上线                                           |
| 2024.03 | GMX推出#EIP4844 交易大赛，分发28万个ARB代币                        |
| 2024.04 | GMX V2 BTC和ETH单代币池上线                                  |
| 2024.05 | GMX推出由 Notifi 提供支持的实时交易和治理提醒                          |
| 2024.06 | GMX获 S.T.I.P.提案的540万枚ARB代币资助                          |
| 2024.06 | GMX V2 Avalanche主网集成 Chainlink Data Streams           |
| 2024.07 | GMX获GMXRush活动价值400万美元AVAX代币资助                         |
| 2024.09 | GMX V2 GLV聚合池上线                                       |
| 2024.09 | GMX V2 tBTC单代币池上线                                     |

数据来源：笔者根据[GMX News](https://gmxio.substack.com/archive?sort=top)整理

重大事件和公告往往会对DeFi协议的代币价格和总锁定价值（TVL）产生显著影响。笔者在上表中整理了GMX协议发展历程中的重大事件，并将其中部分重要事件在下图的价格与TVL走势中标注。

## 价格与TVL走势

![图源：[GMX - DefiLlama](https://defillama.com/protocol/gmx?twitter=false\&tokenPrice=true\&events=false)](https://cdn.jsdelivr.net/gh/zey9991/mdpic/image-20241027101439734.png)

# 4.主营业务

GMX 是首批找到明确产品市场契合度的完全链上永续交易所之一。这可能与该协议的一些定义特征有关，包括但不限于：

* **易用性**：交易者可以直接从他们的钱包中即时进行交易，无需账户、托管或注册
* **直观的界面：** 整洁的前端，新的加密交易者可以使用，并且在 Swap DEX 或 Centralised Exchange 上交易过的任何人都熟悉
* **深度流动性**：截至 2024 年 10 月，GMX 上的交易者可以使用约4.3 亿美元的流动性。Arbitrum 上 BTC 的 GM 池本身就包含 1.35 亿枚流动性。此外，所有这些流动性都是用户贡献的，并且已被证明是具有粘性的。
* **预言机喂价**：与Chainlink合作，采用基于多个交易所价格汇总的价格源，从而降低因临时价格波动导致清算的风险。V1中交易对价格没有影响，因此可以完全以标记价格执行大宗交易。在高波动时期，Chainlink 价格可能会从参考交易所的中位价出现价差。
* **多订单类型**：GMX支持市价单、限价单以及止盈止损单。

GMX 的短期目标主要集中在几个方面：首先，继续拓展新的流动性市场，以吸引更广泛的用户群体；其次，积极扩大其社区和 DeFi 生态系统，为用户提供更丰富的体验；同时，进一步优化非托管的链上交易功能，提升整体用户体验

GMX 的长期目标是成为 DeFi 生态中的无许可基础层。其战略方向分为两大方面：一方面，它致力于提供便捷的交易功能，确保资金来源的透明性和可验证性；另一方面，通过其平台的交易活动提供可持续收益，同时允许外部方托管一系列去中心化应用（dApp）前端，以提升用户体验。

此外，随着 DeFi 跟单项目、链上管理基金和 Telegram 交易机器人等技术的兴起，GMX 期望成为 Web3 下一阶段的重要组成部分，类似于 Chainlink 的角色。该愿景包含账户抽象等概念，借助社交平台的简化界面，使用户能在聊天室或去中心化自治组织（DAO）内便捷地执行复杂的交易策略。

![GMX生态系统 图源：https://gmxio.substack.com/p/case-study-gmx-x-arbitrum-x-chainlink](https://cdn.jsdelivr.net/gh/zey9991/mdpic/gmx%E7%94%9F%E6%80%81.webp)

## 交易

**从V1到V2的交易体验升级一览**

GMX协议从V1到V2交易体验的改变可以总结如下表：

|                | V1                                                           | V2                                                           |
| -------------- | ------------------------------------------------------------ | ------------------------------------------------------------ |
| 交易费用       | <p>喂价无滑点<br>开/平仓费用<br>交换费用<br>借款费用<br>网络费用</p> | <p>新增价格影响机制<br>降低开平仓费用<br>降低交换费用<br>修改借款费用<br>保留网络费用<br>新增资金费率<br></p> |
| 抵押资产       | 全额支持市场                                                 | 引入合成资产市场                                             |
| 杠杆倍数       | 最高50x                                                      | 最高100x                                                     |
| 可用流动性     | 资金池的全部价值                                             | 可能会自动减杠杆（ADL）                                      |
| 可交易资产数量 | 9                                                            | 27                                                           |
| 预言机         | Chainlink keeper，更早期时使用团队的GMX keeper喂价           | 与Chainlink共同开发的全新低延迟预言机Chainlink Keeper Data Streams |

数据来源：笔者根据官网以及官方文档等资料自行总结

下面笔者介绍一下其中的一些关键改变：

**合成市场**

V1中是全额支持市场（Fully backed markets），例如由ETH-USDC支持的ETH永续市场，仓位的上限由池中的ETH和USDC数量决定。

V2中有合成资产市场（Synthetic markets），可以通过多种资产的组合来模拟其他资产的表现，而非直接使用实际的资产。比如ETH-USDC支持的DOGE永续合约市场。

![](https://cdn.jsdelivr.net/gh/zey9991/mdpic/image-20241026224159830.png)

虽然最大多头未平仓量可能仅限于 ETH 代币数量的一小部分，但多头头寸的利润可能会超过池中代币的价值。例如，如果池中有 1000 个 ETH 和 100 万个 USDC，最大多头 DOGE 持仓量限制为 300 ETH，但 DOGE 的价格上涨了 10 倍，而 ETH 的价格仅上涨了 2 倍，在这种情况下，待处理利润将超过池中 ETH 的价值。

为避免这种情况，可能会发生 ADL（自动减仓）。当挂单利润超过市场设定的阈值时，盈利仓位可能会部分或全部平仓。这有助于确保市场始终保持偿付能力，并确保在平仓时所有收益都能得到全额支付。

**交易费用**

GMX V2新的交易费用方案可以总结如下：

* 开仓/平仓费用从0.1%减半至0.05%或 0.07%，在一众竞品的手续费率中排行中等。
* 修改借款费用：和V1不同，如果多头仓位多于空头仓位，则多头方需要支付借款费用；如果空头仓位多于多头仓位，则空头方需要支付借款费用。
* 价格影响机制，使多空倾向于平衡的交易将获得更有利的价格，不平衡的交易获得负面价格影响。这不利于中大型交易。
* 引入资金费率，奖励市场中的弱势方，鼓励套利交易驱动市场达到均衡，对LP更加友好。

![图源：https://app.gmx.io/#/dashboard](https://cdn.jsdelivr.net/gh/zey9991/mdpic/image-20241019142832869.png)

本文将在“收入来源”部分详尽介绍V1和V2的协议交易费用的有关细节。

## 做市（提供流动性）

**从V1的聚合池到V2的隔离池**

曾经的GMX以其聚合流动性池GLP池为人所知，但是面临LPs对一篮子资产的广泛敞口、资产类型有限、资本效率与利用率低下等等障碍，GMX V2上线之初将其舍弃，另设GM隔离池，其中只有一个代币对（目前均是非稳定币/USDC代币对）。

在V1的GLP模型下，每一个可交易资产都必须被纳入GLP池中，也就是说只有一个单一的GLP池在提供流动性。GLP池类似股票市场中的指数基金，由多个“成分股”（代币）组成，只不过该基金不是意在主动管理提高收益，也不是通过被动管理追踪收益，而是专门用于给交易者提供流动性。虽然GLP池能够一定程度上聚合流动性，但LP有可能“被迫”持有其原本不希望持有的资产，而且单一资产出现风险可能导致所有 GLP 持有者面临损失。

![图源：https://app.gmx.io/#/dashboard](https://cdn.jsdelivr.net/gh/zey9991/mdpic/image-20241019143047154.png)

V2中，可以将单一的流动性池 GLP 用多个风险隔离的 GM 池代替，每一种资产的流动性都是独立的，可以支持更多长尾资产。 总之，LP可以自由选择他们希望提供流动性的资产。当一种资产价格面临风险时，也不会使所有流动性提供者面临风险。

![图源：https://app.gmx.io/#/dashboard](https://cdn.jsdelivr.net/gh/zey9991/mdpic/image-20241019142959038.png)

**基于隔离池的聚合池**

2024年8月，GMX DAO 管理员 Saurabh 提案——增强流动性的GLV池（GMX Liquidity Vaults，GMX流动性金库）——重拾了V1中的GLP池设计：每个GLV池都聚合了各种GM交易池，而这些交易池都具有相同的基础多头代币和空头代币。如果LP购买GLV，就相当于批量购买了某类市场的GM代币，相当于买入一个指数基金，该指数基金会自动放贷给市场交易者。GLV池的流动性将根据利用率和 Chaos Labs 的建议在支持的市场之间转换。

2024年9月，该提案获得通过，GLV池正式上线。目前，GMX V2共支持两类GLV池，分别是BTC-USDC和WETH-USDC，如下图所示：

![](https://cdn.jsdelivr.net/gh/zey9991/mdpic/image-20241019150156684.png)

![](https://cdn.jsdelivr.net/gh/zey9991/mdpic/image-20241019150135342.png)

GLV的出现平衡了V1和V2流动性池的设计理念，让GMX的流动性池设计体系更加成熟了：

* GM池让部分LP可以仅对特定代币对提供流动性，避免受到其他资产的风险波及，
* 而GLV池又可以让对一揽子代币没有偏好部分LP更有效地管理其投资，而无需跟踪多个单独的交易池。

而且，GLV也能简化新市场上市流程，被确定为安全的市场可以直接整合到适当的GLV中，确保这些市场能够获得足够的流动性，而无需单独为新市场引导流动性。总之，GLV提高了资本部署的整体效率。

**单币池**

与双代币GM池不同，单代币GM池没有稳定币元素：多头和空头头寸都用波动性代币（BTC或ETH）来支持。

目前GMX支持3个单代币GM池，分别是BTC抵押支持的BTC/USD市场，tBTC抵押支持的BTC/USD市场和WETH抵押支持的ETH/USD市场。

![图源：https://app.gmx.io/#/pools/](https://cdn.jsdelivr.net/gh/zey9991/mdpic/image-20241026194728474.png)

这些新的GM市场将使GMX能够释放更大的市场流动性。它们将吸引一批新的流动性提供者，这些提供者希望拥有100%敞口于单一基础抵押品（BTC、ETH、稳定币或山寨币），而无需像现有GM市场、GLP和一般的流动性池那样进行再平衡。

**交易对手**

LP为杠杆交易提供流动性（作为杠杆交易者的对手方），当杠杆交易者亏损时，流动性提供代币升值，LP获利，反之亦然。实际上，LP在每笔交易中就是持有与交易者大小相等，方向相反的头寸/仓位。未实现盈利和亏损会实时计入流动性提供代币的价格。

虽然从长期看，LP的收益对交易者的盈利或亏损（PnL）应该是中性的，也就是说交易者交易者的盈利或亏损在长期应该相差无几，几乎能够相互抵消，忽略不计。但是根据现有数据来看，交易者累计的PnL为负，这变相增加了LP的收益。

| 2024年10月26日数据 | 交易者累计亏损     | 交易者累计获利     | Loss/Profit |
| ------------- | ----------- | ----------- | ----------- |
| V1            | 1,188,588   | 832,134     | 142.84%     |
| V2            | 310,421,387 | 299,052,158 | 103.80%     |
| V1+V2         | 311,609,975 | 299,884,292 | 103.91%     |

数据来源：[GMX analytics](https://stats.gmx.io/arbitrum)，[GMX V2 Overall Traders PnL](https://dune.com/queries/1518036/4759104)

**风险敞口**

除了暴露于交易者的盈亏，可以总结出流动性代币持有者的风险敞口如下：

* 只要池子不是在多空之间精确平衡（ 50：50 ），就会暴露于交易者的盈亏。不过，V2中的资金利率通常会使资金池未平仓合约恢复到平衡，从而使交易者盈亏对 LP 的影响最小。
* 受到标的资产价格变动的影响。
* 以列出的费率从矿池中赚取费用。这些费用自动复利，提高代币的价格。
* 从流动性激励活动中获得额外奖励。

注意，对于GMX的LP而言，没有无常损失的概念，因为资金池不是一个自动做市商（AMM）。该资金池并不依赖于套利者向资金池中添加或移除不同的代币来使GMX上的代币价格与“市场整体”价格相等。

GMX依赖于Chainlink价格预言机，并结合交易量领先的交易所的价格汇总，来确定其现货交易和永续合约交易的价格。GMX并不基于自身交易所的活动和套利者的行为来得出市场的清算价格。这一点与其他基于AMM池的DEX有所不同。

**价格影响**

LP在铸造或销毁流动性提供代币时，均需要考虑价格影响，交易费用会根据这些操作是增强还是减弱资产的平衡而有所不同，增强平衡则费用低，减弱平衡则费用高。

举例来说，假设GLP的资产池中有两种代币：**ETH**和**USDC**。当前的代币权重是**ETH 70%和USDC 30%**，也就是说ETH在资产池中占了大部分。如果用户想用ETH来铸造GLP，那么这会**增加ETH的比例**，进一步加大ETH在池中的权重。所以，这种操作的手续费会较高。相反，如果用户用USDC来铸造GLP，这将**平衡ETH和USDC的比例**，因此手续费较低。

GMX V1给GLP池中每个代币设定一个目标权重，并基于目标权重和实际权重的大小关系实现上述的各种调节。可以通过官网前端的Dashboard查看代币的权重。

![图源：https://app.gmx.io/#/dashboard](https://cdn.jsdelivr.net/gh/zey9991/mdpic/image-20241018224526933.png)

从下图可以看出，低于目标权重的几个代币（ETH，USDC.e，USDT）的手续费都是比较低的。

![图源：https://app.gmx.io/#/buy\_glp](https://cdn.jsdelivr.net/gh/zey9991/mdpic/image-20241018230036616.png)

V2的GM池则是基于池中代币对的以美元价格计算的平衡关系来设定价格影响费用，如果购买会破坏池中代币的平衡，增加费用；如果改善池中代币的平衡，则减少费用。例如下图中的694.61个BNB的美元价格就约占整个流动性池价值的50.45%。

![图源：https://app.gmx.io/#/pools/](https://cdn.jsdelivr.net/gh/zey9991/mdpic/image-20241026135301274.png)

如果资金池大体上是平衡的，大额购买可能会导致较大的负面价格影响，此时可以用等量的美元价值的多头代币和空头代币来购买GM代币以减小价格影响。

新的GLV池则与GLP池的设定类似。不同之处在于，类似GM池，GLV池也能以代币对的形式存入资金，减小负面的价格影响。

**资金转移**

2024年8月，GMX平台启用SHIFT功能，允许流动性提供者无需支付任何买卖费用，即可即时将其GM流动性转移到其他GM或GLV资金池中。所有具有相同基础资产的资金池均可使用SHIFT功能：

🔹 WETH-USDC流动性可以在基于这一流动性对的所有7个资金池中自由转移：ETH、DOGE、SHIB、XRP、LTC、NEAR和ATOM资金池。

🔹 BTC-USDC流动性可以在BTC、STX和ORDI资金池中自由转移。

# 5.协议收入

## 收入现状

|          | 2024  | 2023   | 2022   | 2021  | 平均  | 加总   |
| ------ | ----- | ------ | ------ | ----- | ----- | ------ |
| 费用(M$) | 96.86 | 132.63 | 116.04 | 10.94 | 89.12 | 356.47 |
| 收入(M$) | 28.35 | 39.87  | 34.81  | 3.95  | 26.75 | 106.98 |
| 利润(M$) | 9.95  | 17.79  | 16.78  | 2.98  | 11.88 | 47.50  |

2024年11月中旬数据  数据来源：[GMX (GMX) financial statement | Financial statements | Token Terminal](https://tokenterminal.com/terminal/financial-statements/gmx)

此处的费用（Fees）指交易者支付的总交易费用（不包括抵押存款费用）。收入（Revenue）指协议/GMX持有者所获得的交易费用份额（不包括抵押存款费用）。利润（Earnings）指收入减去代币激励后的部分。

自2021年9月正式上线以来，GMX协议累计实现了3.5647亿美金的交易费用收入，其中归属协议或GMX持有者的份额达1.0464亿美金，扣除代币激励后的利润达到4526万美金。平均来看，2021-2024年间GMX协议的总交易费用平均收入为8912万美金，协议平均收入为2675万美金，平均利润则为1188万美金，而且考虑到2021年实际上线仅约3个月，2024年尚未结束，这3个数字还是被低估的。

此外，除2023年12月-2024年3月，获得Arbitrum DAO资助的1200万Arb代币，导致此期间激励费用大增外，GMX协议几乎一直保持每月正利润。综上所述，GMX拥有极强的创收能力。

## 收入来源

主要收入来源包括交易费用和LP代币铸造和销毁费用。其中：

（a）GMX V1对交易者收取的交易费用主要包括

* 开平仓费用：仓位大小的0.1%，注意是开和平仓都需要交一次。
* 交换费用：如果开平仓时需要进行币种交换，则需要抵押物规模的0.2%至0.8%作为交换费用。
* 借款费用：支付给对手方（GLP池）的费用，每小时开始时扣除，每小时的费用将根据利用率变化，计算公式为（借贷资产）/（池中总资产）\* 0.01%。
* 网络费用：支付给Keeper在区块链上监视交易请求并执行的费用。

（b）GMX V2对交易者收取的交易费用主要包括

* 开平仓费用：仓位大小的0.05%-0.07%。
* 交换费用：对于稳定币收取0.005%-0.02%的费用，对于其他代币收取0.05%-0.07%的费用
  * 如果交易增加了稳定币池中代币的余额，则费用为0.005%；否则，费用为0.02%。
  * 如果交易增加了池中其他代币的余额，则费用为0.05%；否则，费用为0.07%。
* 借款费用：和V1不同，如果多头仓位多于空头仓位，则多头方需要支付借款费用；如果空头仓位多于多头仓位，则空头方需要支付借款费用。
* 网络费用：支付给Keeper在区块链上监视交易请求并执行的费用。
* 资金费用（Funding Fees）：该费率会根据多头和空头的平衡情况随时间变化。这类似CEX的交易体验，相信各位不陌生。
* 价格影响（Price Impact）：如果交易改善了多空平衡或资金池中的代币情况，则会产生正面的价格影响，否则会产生负面的价格影响。

（c）GMX 对 LP 收取的费用，如前文所述，会根据其操作是增强还是减弱资产的平衡而有所不同，增强平衡则费用低，减弱平衡则费用高。此部分占比很小。

## 收入分配

GMX 协议的收入分配总结在下表中：

| 主体     | GMX V1                 | GMX V2                                    |
| ------ | ---------------------- | ----------------------------------------- |
| 流动性提供者 | 70%费用分配给GLP持有者。        | 63%的费用分配给GM/GLV持有者。                       |
| GMX质押者 | 30%费用分配给效用和治理代币GMX质押者。 | 27%的费用分配给GMX质押者。                          |
| 项目国库   | -                      | 10%转入项目国库（其中1.2%支付给Chainlink的低延迟预言机喂价服务）。 |

数据来源：GMX官方文档及GMX DAO

# 6.运营情况

## V1和V2

|      | V1       | V2       | V2/V1   | 总和       |
| ---- | -------- | -------- | ------- | -------- |
| 用户总量 | 442.27K  | 257.28K  | 58.17%  | 699.54K  |
| 交易总量 | \$164.16B | \$65.20B  | 39.72%  | \$229.36B |
| 未平仓位 | \$24.10M  | \$170.33M | 706.76% | \$194.43M |
| TVL  | \$100.59M | \$329.70M | 327.77% | \$430.29M |
| 费用总量 | \$280.60M | \$72.71M  | 25.91%  | \$353.31M |

2024年10月底数据  数据来源：[GMX Analytics](https://dune.com/gmx-io/gmx-analytics)

自2021年9月以来，GMX协议在V1和V2上已吸引近70万用户、促成超\$229B的交易量、保持接近\$430M的TVL，产生了超过\$353M的费用收入，表明其作为去中心化交易平台的长期吸引力。

尽管V1的交易总量更大，但V2的未平仓位更多，是V1的超7倍，而笔者认为**未平仓位总量更能反映协议近期的发展情况，V2的交易实际上要更加活跃**。而且V2的TVL也超过了V1的3倍，从下面两幅图也可以看出自2023年8月V2版本推出以来，V1的TVL逐步下降，并向V2转移。不过，由于费用结构的变更和存续时间较短，V2产生的费用总量还仅占V1的25.91%。而且，用户向V2的转移仍在进行中。

![GMX V1的TVL走势 图源：https://defillama.com/protocol/gmx-v1#information](https://cdn.jsdelivr.net/gh/zey9991/mdpic/image-20241026223655022.png)

![GMX V2的TVL走势 图源：https://defillama.com/protocol/gmx-v2-perps#information](https://cdn.jsdelivr.net/gh/zey9991/mdpic/image-20241026163519483.png)

## Arbitrum和Avalanche

|      | Avax    | Arb      | Arb/Avax | 总和       |
| ---- | ------- | -------- | -------- | -------- |
| 用户总量 | 89.05K  | 610.49K  | 685.55%  | 699.54K  |
| 交易总量 | \$29.98B | \$199.38B | 665.04%  | \$229.36B |
| 未平仓位 | \$28.79M | \$165.64M | 575.34%  | \$194.43M |
| TVL  | \$73.18M | \$357.11M | 487.99%  | \$430.29M |
| 费用总量 | \$60.44M | \$292.87M | 484.56%  | \$353.31M |

2024年10月底数据  数据来源：[GMX Analytics](https://dune.com/gmx-io/gmx-analytics)

Arbitrum在各项指标上均显著领先。在两者最接近的TVL和费用总量指标方面，Arbitrum也是Avalanche的约4.8倍，剩下三个指标差距就更大了。这表明Arbitrum在用户偏好、交易活跃度和资金吸引力方面相较Avalanche更具竞争力。

此前GMX DAO陆续有用户提案部署到其他更热门活跃的链上，不过由于GMX DAO精力集中在完善V2的产品和交易体验上面，一直没有得到通过，预期后续应该会实现更多链部署。2023年3月，GMX DAO Johnzee回答认为评估下一个要部署的链的标准包括但不限于以下因素：

* 安全性，包括安全性和活动性
* 可扩展性和平均交易成本
* 自然用户活动程度
* 其他 DeFi 协议的质量，以及通过可组合性实现的潜在协同效应
* 新链带来的实施难度和增量维护成本
* 连锁激励

## Swaps与Trading

|          | 累计    | 占比    |          | 累计     | 占比    |
| -------- | ------- | ------- | -------- | -------- | ------- |
| 交易费用 | $249.3M | 88.87%  | 交易总量 | $178.46B | 92.56%  |
| 交换费用 | $31.2M  | 11.13%  | 交换总量 | $14.34B  | 7.44%   |
| 加总     | $280.5M | 100.00% | 加总     | $192.80B | 100.00% |

2024年11月中旬数据 数据来源：

GMX虽然提供现货的交换（Swaps），但从费用量和交易量来看还是合约/杠杆交易占据主导地位：交换费用只占两者和的11.13%，交换总量则仅占7.44%。从该数据看，GMX主要还是应该被定性为衍生品DEX。

# 7.竞争格局

此前Gryphsis Academy也有学员写过去中心化永续合约交易所的研报，推荐各位作为补充阅读：[去中心化永续合约交易所：技术、市场与前沿预测](https://mp.weixin.qq.com/s/LPiJYixkGyE0wbw2Xs6SMw)。

前文已述，从历史数据来看，GMX的现货交换仅占很小一部分，GMX主要还是应该被定性为衍生品DEX，故本文选取去中心化衍生品交易所赛道中进行竞品分析。具体而言，本文选取了如下蓝筹项目进行比较，下面是它们的基本情况：

| 衍生品DEX        | 简介             | 公布融资（\$M） | 推特粉丝（K） |
| :------------ | -------------- | -------- | ------- |
| GMX           | 现货和杠杆交易        | 0        | 227.41  |
| dYdX          | 在订单簿上交易现货和永续合约 | 85       | 249.51  |
| Vertex        | 在订单簿上交易现货和永续合约 | 8.5      | 114.53  |
| Gains Network | 杠杆交易平台，包括非加密资产 | 0        | 59.83   |
| MUX           | 杠杆交易平台         | 7        | 47.77   |
| Syntheix      | 合成资产平台         | 62       | 250.44  |
| Pendle        | 本息剥离协议         | 3.7      | 132.4   |

数据来源：RootData

本文选择如下指标，简要说明参见下表：

| 指标            | 说明                                                   |
| --------------- | ------------------------------------------------------ |
| 月活            | 使用协议服务的独立地址数，基于30天滚动窗口，每月统计。 |
| 交易            | 交易量                                                 |
| TVL             | 用户存入协议智能合约的资产，这些资产不属于协议所有。   |
| 流通市值        | 基于治理代币的流通供应量计算协议的估值。               |
| Mcap/TVL        | 值小于1，则说明项目价值可能被低估了                    |
| 费用            | 由终端用户支付的费用。                                 |
| 收入            | 协议（及其代币持有者）保留的费用部分。                 |
| 利润            | 协议的净收入，不包括链下支出。                         |
| 费用-收入转化率 | 收入/费用。                                            |
| 收入-利润转化率 | 利润/收入。                                            |
| 备注            | 基于2023年第4季度至2024年第3季度的数据取平均值。       |

让我们来比较选取的协议23Q4-24Q3几个重要指标的平均值：

![23Q4-24Q3项目月活等指标对比 数据来源：Token terminal, DeFilama, Dune](https://cdn.jsdelivr.net/gh/zey9991/mdpic/GMX_%E7%AB%9E%E4%BA%89%E5%B9%B3%E5%9D%87%E6%9C%88%E6%B4%BB%E7%AD%89.png)

![23Q4-24Q3项目费用等指标对比 数据来源：Token terminal, DeFilama, Dune](https://cdn.jsdelivr.net/gh/zey9991/mdpic/GMX_%E7%AB%9E%E4%BA%89%E5%B9%B3%E5%9D%87%E8%B4%B9%E7%94%A8%E7%AD%89%E7%AD%89.png)

笔者对此前两表的解读如下：

1. GMX在23Q4-24Q3时间段的平均月活、交易量、Mcap/TVL、费用和收入以及利润这几个指标的表现上要优于选取样本的平均值。
2. GMX 的平均费用总量$28.8M遥遥领先于其他竞争对手，其平均收入\$8.3M位列第2，费用-收入转化率并不高，仅为23.91%，低于样本平均值。而且GMX利润的表现并不算突出，仅占到dYdX利润的一半左右，收入-利润转化率约为23.52%。
3. 收入和利润是归属给GMX代币持有者的。笔者认为，虽然费用-收入转化率、收入-利润转化率不高可能会对项目的运营有一定影响，但是考虑到费用的剩余很大一部分（V1费用的70%，V2费用的63%，因此该部分略小于\$28.8M-\$8.3M=\$20.5M）要分红给LP，导致GMX对LP有更大的吸引力，这是在表中无法体现的。
4. GMX 的月活跃用户19.98K在样本衍生品 DEX 中处于领先地位，在23Q4-24Q3时间段的平均表现仅次于 Pendle ，略高于dYdX，显示了其用户基础的稳定性。
5. GMX 的 Mcap/TVL 为 83.99%，明显低于 dYdX（280.61%） 和 gTrade（433.31%）。该比值小于 1 通常被视为该项目的价值可能被低估，这表明 GMX 相对于其锁仓量而言可能具有更高的增值潜力。

# 8.经济模型

GMX有两种代币：效用与治理代币\$GMX和流动性提供代币，后者根据协议版本和流动性池的差异分为\$GLP，\$GM和\$GLV。由于其对代币经济学的巧妙设计，将部分协议的费用分配给1.<u>效用和治理代币GMX质押者</u>以及2.<u>流动性提供者</u>，成功打造了“**真实收益**”的叙事，吸引了众多用户参与协议生态。

## 流动性提供代币

\$GLP，\$GM和\$GLV的供应无上限，分配则由市场存入的资金量决定。

\$GLP和\$GLV代币因其聚合池的特性，可以依据公式计算出一个统一的市场价格，例如，

$$
p_{GLP}\equiv \frac{GLP池所有资产的总价值，包括未平仓头寸的利润和损失}{GLP 的总供应量}
$$

而GM代币的价格则因不同的GM池而异。

流动性提供代币的主要用例就是质押（会在铸造时自动质押）。如前文所述，\$GLP代币持有者能够获取70%的V1协议费用，而\$GM或\$GLV代币持有者可以获取63%的V2协议费用。

注意，费用收入和交易者的损失都表现为流动性提供代币的升值，也就是说，GMX协议的流动性提供代币是一种自动增值的生息代币（Reward-bearing），而不是自动增发的再定基代币（Rebasing Token）。

## 效用与治理代币

效用与治理代币\$GMX预期最大供应量为13.25M，但在有需要的情况下，会出现超过此最大供应量的铸造。此要求必须经过 GMX 治理部门 GMX DAO 的投票和批准。

\$GMX的供应分配比例为：

| 数量        | 比例 (%) | 说明                                            |
| --------- | ------ | --------------------------------------------- |
| 6,000,000 | 45.28% | XVIX 和 Gambit 迁移 （GMX 是由 XVIX 和 Gambit 社区合并而成） |
| 2,000,000 | 15.09% | 与 ETH 配对，在 Uniswap 上提供流动性。                    |
| 2,000,000 | 15.09% | 预留用于 esGMX 代币的 Vesting。                       |
| 2,000,000 | 15.09% | 用于国库。                                         |
| 1,000,000 | 7.55%  | 用于集成激励和社区开发者。                                 |
| 250,000   | 1.89%  | 在 2 年内线性分配给贡献者。                               |

数据来源：GMX官方文档

目前只剩下esGMX的份额仍在释放，预计将线性释放至2028年9月，其他份额已经释放完毕，因此后续因解锁导致的抛压小。

![图源：https://tokenomist.ai/gmx](https://cdn.jsdelivr.net/gh/zey9991/mdpic/image-20241019095325403.png)

\$GMX代币用例包括：

（a）治理

参与GMX DAO的治理，需要质押 GMX（和 esGMX）代币，并按 1:1 的比例获得 GMX DAO 代币。

（b）质押

质押GMX可以获取三种类型的奖励：

* 30%的交易费用分红：分享30%的平台交易费用，代币为ETH 或 AVAX。
  * 如果在 Arbitrum 上质押将获得 ETH；在 Avalanche 上质押将获得 AVAX。
  * 用户必须手动领取奖励并进行复投操作。尽管Arbitrum和Avalanche的费用很低，但手动复投多次势必会产生相应的手续费。
* 托管 GMX 代币（esGMX，Escrowed GMX）：
  * 获取：托管 GMX将按照最新快照投票中的计划分配给质押的GMX和GLP。托管GMX一般不可转让。
  * 质押：质押以获取与常规GMX代币类似的奖励：每个质押的托管GMX代币将获得与常规GMX代币相同数量的托管GMX和ETH/AVAX奖励。
  * 解锁：在启动vesting后，esGMX代币将每秒逐步转换为GMX，并在365天内完全vesting。已转换为GMX的esGMX代币可以随时领取。
  * esGMX 形式的激励措施已经逐渐减少：向 GLP 持有者的 esGMX 发放于 2022 年 12 月结束，向 GMX 质押者的 esGMX 发放于 2023 年 3 月结束。esGMX 排放的主要用途是激励协议的去中心化和使用。随着 GMX 采用率的增加，对质押者和流动性提供者的 esGMX 排放量减少。这种降低代币通胀的过程目前正在进行中。目标是让协议达到不再需要 esGMX 激励的状态。
* 乘数积分（MP，Multiplier Points）：
  * 获取：当质押GMX时，将以100% APY的固定速率每秒获得Multiplier Points。1000个GMX质押一年将获得1000个Multiplier Points。
  * 质押：Multiplier Points可以质押以获取手续费奖励，每个质押的Multiplier Point将以与常规GMX代币相同的速率赚取ETH/AVAX。
  * 奖励加成：例如，如果ETH的年收益率为10%，持有价值10,000美元的GMX和esGMX，那么的年化奖励将是1,000美元。如果持有的Multiplier Points相当于总GMX和Escrowed GMX数量的20%，那么的“Boost Percentage”将显示为20%，将额外获得200美元的年化ETH奖励。
  * 奖励加成上限：最大提升比例为200%，这意味着如果拥有1000个GMX代币，并拥有2500个Multiplier Points，那么最多可质押2000个Multiplier Points以获得200%的提升；剩下的500个Multiplier Points无法质押，要质押这些Multiplier Points，需要获得额外的GMX代币，例如，如果购买了100个额外的GMX，那么这500个Multiplier Points中的200个可以质押。

# 9.面临风险

## 1.费率偏高

尽管V2费用比V1更低，但由于引入了价格影响机制，加之考虑到最大杠杆的限制，V2可能对巨鲸的吸引力比较有限。此外，也要考虑到去中心化衍生品交易所赛道竞争激烈，费率可能是一个影响未来走势的关键变量。

![GMX竞争对手的吃单（以市价接单）费用 图源：https://gov.gmx.io/t/gmx-fee-reduction-proposal/3988](https://global.discourse-cdn.com/flex020/uploads/gmx/original/2X/5/568f874645d37e516fb5ef55a938a1fb02f2490b.jpeg)

近期GMX DAO的一个[热门提案](https://gov.gmx.io/t/gmx-fee-reduction-proposal/3988)就是要根据交易体量设置不同的费率，如果未来此类型的提案通过，或将改变V2对中大型交易不利的现状。不过，费率也不是越低越好，GMX也需要平衡交易者和流动性提供者（做市商）以及\$GMX代币持有者三方之间的利益关系。

## 2.部署链较少与L2赛道加持消失

2022 年 L2赛道爆发，结合了 Optimism 发币、以太坊合并、Arbitrum 奥德赛、Nitro 升级等热点，加上 zk rollup 的技术畅想，为 GMX 带来很多用户和流量。但是此轮牛市中L2的叙事因部分项目方的奇葩空投策略被玩烂，而以太坊又深陷流动性分割困境价格跑不赢比特币大饼，加之更多用户转向pump.fun这种meme类的链上DEX或是bot，L2赛道加持不复，考虑到当前GMX协议又仅在Arbitrum和Avalanche两条链上部署，对于其他链上的原生用户因需要跨链导致吸引力比较有限。因此，GMX可以在V2版本产品体验进一步优化后考虑多链部署，扩大生态影响力。

# 10.理性讨论：GMX的牛市死亡螺旋说还成立吗？

曾有一段时间（特别是2023年初），关于GMX的FUD甚嚣尘上，部分观点认为GMX（或GLP）虽然在熊市中不受影响，但在牛市极端行情中将会归零。

这种观点的逻辑是：由于GMX没有资金费率，牛市中交易者开空虽说有利于GLP池的多空平衡，但没有任何收益，反倒还会上交借贷费用，因此在牛市中没人会开空。而GLP池包含一揽子稳定币和风险资产，LP的收益受到池中资产价格的影响，在极端上涨行情中GLP将会回报下降甚至是面临巨额亏损，进而导致\$GMX/\$GLP价格暴跌，于是LP们争相撤走资产，这又导致交易者越来越少，协议获得的费用也越来越少，陷入如下图所示的死亡螺旋。

![图源：https://tokeninsight.com/zh/research/analysts-pick/could-gmx-collapse-in-a-bull-market-a-deep-dive.](https://cdn.jsdelivr.net/gh/zey9991/mdpic/img20230112060311d642db4c-6a93-405a-ac84-8971bca026a4.jpg)

首先，这些FUD出现的时间早于V2版本上线的时间，而V2版本已经新增了资金费率，尽力保障牛市中的多空平衡，V2版本的LP代币（\$GLV或者是\$GM）不会再因此暴跌了。故不难想象，随着用户由V1向V2的迁移，这种牛市暴跌的言论再也没有出现过了。

其次，就算是当时也有人发文认为牛市死亡螺旋论站不住脚了。例如，[**quantumzebra123**](https://tokeninsight.com/zh/author/quantumzebra123)认为，这个死亡螺旋最为薄弱的环节是：GLP 回报下降将导致人们从 GLP 池中移除资产、更小的 GLP 池将意味着更少的交易者和更少的费用。

历史数据表明，GLP 回报下降并不一定导致GMX的流动性枯竭，比如在2021年9月-2021年12月的牛尾行情中，GLP 的 Adjusted APR 经常为负值，但 AUM 却持续增长。

![图源：https://tokeninsight.com/zh/research/analysts-pick/could-gmx-collapse-in-a-bull-market-a-deep-dive.](https://cdn.jsdelivr.net/gh/zey9991/mdpic/img2023011206031542a1d5ce-33f9-428f-8d32-2f5e0dcd5acd.jpg)

同样地，历史数据上也看不出更小的 GLP 池是否意味着更少的交易者和更少的费用。有太多的因素在起作用，因果关系并不明显。他认为GLP 池的大幅减少都是由重大事件而不是 APR 的波动引发的，例如 2022年5 月的 Terra，6 月的 3AC 和 11 月的 FTX。这些事件都导致市场波动很大，交易者也最活跃。因此，GLP AUM 的减少通常伴随着费用的增加。

![图源：https://tokeninsight.com/zh/research/analysts-pick/could-gmx-collapse-in-a-bull-market-a-deep-dive.](https://cdn.jsdelivr.net/gh/zey9991/mdpic/img20230112060314250474ac-3db7-43ac-81d4-b856d9d69062.jpg)

总之，在现阶段GMX的牛市死亡螺旋论确实应该被舍弃了。

# 结论

作为领先的去中心化现货与永续合约交易所，GMX无风投支持，完全由匿名团队和社区驱动。自 2023 年 V2 上线后，流动性池种类增加，创收能力强，自 2021 年以来累计交易费用达 3.5647亿美元，其中大部分收入分配给流动性提供者和治理代币持有者。尽管用户向 V2 的迁移仍在进行，GMX 在多个指标上优于同类项目，尤其在费用收入方面遥遥领先。GMX 采用双代币模式，治理代币 \$GMX 几乎全流通，抛压小，主要面临费率竞争和跨链吸引力的挑战。

# 参考文献

1. [GMX | GMX Docs](https://docs.gmx.io/docs/intro/)
2. [去中心化永续合约交易所：技术、市场与前沿预测 (qq.com)](https://mp.weixin.qq.com/s/LPiJYixkGyE0wbw2Xs6SMw)
3. [GMX的常见误解总结，GLP在极端行情中会归零？ - PANews (panewslab.com)](https://www.panewslab.com/zh/articledetails/ievrx7b2.html)
4. [逆市而涨的GMX，能否成为去中心化永续合约新的王者？ - PANews (panewslab.com)](https://www.panewslab.com/zh/articledetails/1643522822971920.html)
5. [GMX：Arbitrum 生态头部衍生品交易平台 | defi.to](https://www.defi.to/cn/gmx/)
6. [GMX逆势生长的背后：真实收益、代币设计及潜在风险\_腾讯新闻 (qq.com)](https://new.qq.com/rain/a/20221011A03XWU00)
7. [GMX (GMX) (binance.com)](https://www.binance.com/zh-CN/research/projects/gmx)
8. [GMX V2 及其竞争对手：颠覆去中心化衍生品市场的新浪潮 - 深潮TechFlow (techflowpost.com)](https://www.techflowpost.com/article/detail\_17141.html)
9. [回顾 GMX V1 发展情况，简述 GMX V2 的改动与影响 - Foresight News](https://foresightnews.pro/article/detail/40451)
10. [GMX 的转型之路：从 V1 到 V2 的市场表现与前景分析 - Foresight News](https://foresightnews.pro/article/detail/44769)
11. [千呼万唤始出来，全方位解读 GMX V2 - CapitalismLab (substack.com)](https://capitalismlab.substack.com/p/gmx-v2)
12. [播客笔记｜对话 GMX 核心贡献者： V2 的创新与市场期望 - 深潮TechFlow (techflowpost.com)](https://www.techflowpost.com/article/detail\_12877.html)
13. [深入解析GMX、DYDX和SNX：衍生品 DEX 协议的代币经济模型对比分析 - 深潮TechFlow (techflowpost.com)](https://www.techflowpost.com/article/detail\_12325.html)
14. [GMX 生态速览：GLP 乐高正在搭建，有哪些协议值得关注？ - 深潮TechFlow (techflowpost.com)](https://www.techflowpost.com/article/detail\_11414.html)
15. [About - GMX](https://gov.gmx.io/about)
16. [GMX Fee reduction proposal - Feature Discussion - GMX](https://gov.gmx.io/t/gmx-fee-reduction-proposal/3988)
17. [Implementation of GMX Liquidity Vaults (GLV) for Enhancing Liquidity - Proposals - GMX](https://gov.gmx.io/t/implementation-of-gmx-liquidity-vaults-glv-for-enhancing-liquidity/3860)
18. [Gmx v2: new low-latency chainlink feeds - GMX](https://gov.gmx.io/t/gmx-v2-new-low-latency-chainlink-feeds/2050)
19. [# GMX V2: (i) UPDATING THE GMX-INTERFACE CODEBASE AND (ii) GMX V2 FEE SETTINGS - Proposals - GMX](https://gov.gmx.io/t/gmx-v2-i-updating-the-gmx-interface-codebase-and-ii-gmx-v2-fee-settings/2017)
20. [GMX Update 2 - Proposals - GMX](https://gov.gmx.io/t/gmx-update-2/38)
21. [GMX V2的改动与影响. GMX V2版本于2023年8月4日正式上线。本文回顾GMX… | by LD Capital | Medium](https://ld-capital.medium.com/gmx-v2%E7%9A%84%E6%94%B9%E5%8A%A8%E4%B8%8E%E5%BD%B1%E5%93%8D-f3f72ffe2384)
22. [Proposal for Reintroducing esGMX Incentives to Boost GMX APR - GMX](https://gov.gmx.io/t/proposal-for-reintroducing-esgmx-incentives-to-boost-gmx-apr/2794)
23. [全局流动性的威力，被低估的链上衍生品交易平台 Gmx（GMX）项目分析 - Foresight News](https://s.foresightnews.pro/article/detail/9580)
24. [GMX 将向交易员、流动性提供者和建设者分发 540 万枚 ARB，作为其 Arbitrum STIP-Bridge 激励活动的一部分](https://gmxio.substack.com/p/gmx-will-distribute-54-million-arb)
25. [GMX 将如何利用 Arbitrum 资助计划的 1200 万\$ARB奖励激励](https://gmxio.substack.com/p/how-gmx-will-utilise-the-12-million)
26. [Announcement: GMX V2 Testnet is now publicly available!](https://gmxio.substack.com/p/announcement-gmx-v2-testnet-is-now)
27. [GMX V2 Beta is now live! - GMX News](https://gmxio.substack.com/p/gmx-v2-beta-is-now-live)
28. [GMX announces the launch of Single-Token Pools on V2, starting with yield-earning BTC and ETH liquidity pools on Arbitrum](https://gmxio.substack.com/p/gmx-announces-the-launch-of-single)
29. [GMX introduces GMX Liquidity Vaults (GLV), now live on Arbitrum & Avalanche](https://gmxio.substack.com/p/gmx-introduces-gmx-liquidity-vaults)
30. [由 Chainlink Data Streams 提供支持的 GMX V2 现已在 Arbitrum 主网上线](https://gmxio.substack.com/p/gmx-v2-powered-by-chainlink-data)
31. [GMX V2 现已在 Avalanche 上与 Chainlink Data Streams 一起上线](https://gmxio.substack.com/p/gmx-v2-is-now-live-with-chainlink)
32. [GMX V2：GMX 将集成 Chainlink 的新低延迟预言机](https://gmxio.substack.com/p/gmx-v2-gmx-will-integrate-chainlinks)
33. [GMX 2024 - GMX 新闻](https://gmxio.substack.com/p/gmx-2024)
34. [X4：协议控制交换 - GMX 新闻](https://gmxio.substack.com/p/x4-protocol-controlled-exchange)
35. [案例研究：GMX x Arbitrum x Chainlink - GMX 新闻](https://gmxio.substack.com/p/case-study-gmx-x-arbitrum-x-chainlink)
36. [GMX 启动计划 - GMX 新闻](https://gmxio.substack.com/p/gmx-launch-plan)
37. [公告：年终 #GMXRush Avalanche 交易大赛，奖池 150,000 美元](https://gmxio.substack.com/p/launching-this-friday-the-year-end)
38. [GMX is now live on Avalanche! - GMX News](https://gmxio.substack.com/p/gmx-is-now-live-on-avalanche)
39. [GMX 更新 1 - GMX 新闻](https://gmxio.substack.com/p/gmx-update-1)
40. [GMX 更新 2 - GMX 新闻](https://gmxio.substack.com/p/gmx-update-2)
41. [GMX 更新 3 - GMX 新闻](https://gmxio.substack.com/p/gmx-update-3)
42. [GMX Arbitrum 奥德赛 - GMX 新闻](https://gmxio.substack.com/p/gmx-arbitrum-odyssey)
43. [GMX 部署更新（2022 年 11 月） - GMX 新闻](https://gmxio.substack.com/p/gmx-deployment-updates-nov-2022)
44. [GMX 加入 Avalanche Rush，获得 \$4M 交易奖励 |作者 Avalanche |雪崩 |中等](https://medium.com/avalancheavax/gmx-joins-avalanche-rush-with-4m-in-trading-rewards-ce5c66f0e3b3)
45. [GMX 推出由 Notifi 提供支持的实时交易和治理警报](https://gmxio.substack.com/p/gmx-introduces-real-time-trading)
46. [常见问题解答： - 作者：Jonezee - GMX 新闻](https://gmxio.substack.com/p/frequently-asked-questions)
47. [GBC 2022 年计划 |作者 GBC |中等](https://findgbc.medium.com/gbc-plans-for-2022-3ffe57e04087)
48. [GBC 路线图更新 1 |作者 GBC |中等](https://findgbc.medium.com/gbc-roadmap-update-1-22b06f4f6353)
49. [Blueberry Lab 版本 + 更新 |作者 GBC |中等](https://findgbc.medium.com/blueberry-lab-release-2-upcoming-products-a4db306e4658)
50. [GBC 路线图更新（第 1 部分）。嘿，浆果！是时候更新一下了... |作者 GBC |中等](https://findgbc.medium.com/gbc-roadmap-update-pt-1-316228c1ebe7)
51. [GMX, A Can-Be-Evil “AMM”. Author: 0xAlpha | by Deri Protocol | Medium](https://deri-protocol.medium.com/gmx-a-can-be-evil-amm-5558564b2eea)
52. [如何防止抢先交易：以Chainlink低延迟预言机方案在GMX的应用为例 - BlockBeats](https://www.theblockbeats.info/news/33223)
53. [GMX research. I did some research on GMX perpetual… | by richmanbtc | perpdex | Medium](https://medium.com/perpdex/gmx-research-9da560f1e447)
54. [Cyfrin/chainlink-gmx-automation: High Frequency Price Automation for GMX, Using Chainlink Keeper Data Streams](https://github.com/Cyfrin/chainlink-gmx-automation)
55. [dYdX与GMX对比：谁能引领下轮牛市衍生品DEX叙事？ - AICoin](https://www.aicoin.com/zh-Hans/article/330913)
56. [GMX 会在牛市中崩盘吗？ | TokenInsight](https://tokeninsight.com/zh/research/analysts-pick/could-gmx-collapse-in-a-bull-market-a-deep-dive.)

