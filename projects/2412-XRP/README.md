# 审视起飞的XRP：业务、数据、潜力和风险

撰文：Peyton，Core Builder of LYS Lab（X：[@0xPeyton404](https://x.com/0xPeyton404)，[@LingyueSamaWeb3](https://x.com/LingyueSamaWeb3) ）

# 前情提要

## 近期行情

过去一周，各大媒体平台因XRP行情爆发而频频刷屏，单月涨幅约400%，多重利好消息接踵而至：

**宏观上：监管放松与政策寻租**

- **政策环境**：11月，倡导加密友好政策的特朗普当选第47任美国总统，并计划成立加密货币顾问委员会。Ripple正积极争取在这一委员会中占据一席之地。此外，Ripple早在2023年12月就捐赠2500万美元成立了名为Fairshake的超级政治行动委员会，表明其在政策寻租和合规布局上的战略前瞻性。
- **监管变动**：同月，现任SEC主席Gary Gensler透露有意于特朗普上任前后辞职，新任SEC主席的政策倾向备受市场期待。
- **司法进展**：Ripple相关诉讼也出现积极进展，法官Phyllis Hamilton批准了对已解决集体诉讼案的最终判决，并暂缓处理其他未决案件。这一决定为2025年1月21日即将开始的审判扫清了障碍，增强了市场信心。

**微观上：机构合作和产品预期**

- **稳定币产品**：11月，纽约金融服务部初步批准Ripple推出稳定币RLUSD，计划于12月4日正式上线。（然而，Ripple随后于12月5日宣布推迟发布。）
- **机构合作**：11月下旬，Ripple宣布与Archax及英国资产管理公司ABRDN PLC达成合作，计划在XRP Ledger上推出首个代币化货币市场基金。
- **ETF申请**：截至12月初，多家机构，包括Bitwise、Canary、21 Shares和WisdomTree，相继提交了现货XRP ETF申请，为市场注入更多想象空间。

截至2024年12月8日，XRP现报2.55美元，尚未收复2018年的历史高点\$3.84。笔者对XRP此次大幅上涨深感兴趣。回顾历史，XRP曾多次跃升为加密资产市值排名第三的标的。这次行情能否持续？后市是否仍具上车机会？围绕这些问题，本文将尝试对XRP进行简要分析，以期为投资者提供参考。

## 研究目标

本文尝试研究并回答如下主要问题：

- **Ripple的商业模式及其对XRP估值的影响**：Ripple的商业模式如何？该商业模式是否在XRP的估值逻辑中发挥作用？其团队和融资背景如何？
- **XRPL的当前发展状况**：XRPL发展的怎么样？相比其他公链有什么特点？目前的链上数据如何？XRPL值得期待的叙事和未来发展？
- **XRP的经济模型与代币估值**：XRP的经济模型、代币效用和估值水平如何？最后，基于对前面问题的回答，探讨XRP的此次涨幅是否有持续的可能，面临哪些阻力？

# Ripple：全球跨境支付网络公司

## 项目定位

> Crypto Solutions for Business

Ripple（瑞波）是由Ripple Labs创建的全球跨境支付网络，基于分布式账本技术，旨在提供安全、即时且几乎免费的全球金融交易解决方案。作为数字资产基础设施的领先提供商，Ripple致力于帮助金融服务行业实现金融基础设施的现代化。通过Ripple平台，用户不仅可以进行实时的跨境支付，还可以参与代币化和数字资产的交易，同时确保符合相关的监管合规要求。

## 团队背景

- **Brad Garlinghouse** 是 Ripple 的首席执行官及董事会成员。在加入 Ripple 之前，他曾担任文件协作平台 Hightail 的首席执行官、美国在线 AOL 的消费者应用总裁，以及雅虎的多个高级职位。
- **Chris Larsen** 是 Ripple 的联合创始人及执行主席，目前担任数据科学公司 Distilled Analytics 的顾问。在创办 Ripple 前，他曾担任 P2P 贷款平台 Prosper 的首席执行官，并领导在线贷款公司 E-LOAN。
- **David Schwartz** 是 Ripple 的首席技术官及 XRP Ledger 的首席架构师，外界称他为“JoelKatz”。在此之前，他曾任 Santa Clara 的软件公司 WebMaster Incorporated 的 CTO，并为 CNN、NSA 等机构开发加密云存储和企业消息传递系统。
- **Monica (Appelbe) Long** 是 Ripple 的总裁，曾担任 RippleX 的营销高级副总裁和总经理。她在职业生涯中一直致力于推动技术公司在金融行业的深度变革，曾在 Intuit 从事企业传播，并为多领域客户提供支持。
- **Stuart Alderoty** 是 Ripple 的首席合规官，拥有超过 30 年的法律经验，专长于金融服务和监管事务。他曾在 CIT Group 和 HSBC North America Holdings 担任领导职务，也曾为美国运通提供法律顾问服务。

## 融资背景

Ripple 是一家私人投资公司。该公司已完成五轮融资，其中包括两轮天使投资、一轮种子投资、一轮A 轮、一轮B 轮和一轮C 轮。详情见下表：

![](https://cdn.jsdelivr.net/gh/zey9991/mdpic/Ripple%E7%91%9E%E6%B3%A2XRP%20-%20%E5%9B%BE%E7%89%87%E5%89%AF%E6%9C%AC_%E8%9E%8D%E8%B5%84.png)

## 发展历程

![](https://cdn.jsdelivr.net/gh/zey9991/mdpic/Ripple%E7%91%9E%E6%B3%A2XRP%20-%20%E5%9B%BE%E7%89%87%E5%89%AF%E6%9C%AC_Ripple2011.png)

![](https://cdn.jsdelivr.net/gh/zey9991/mdpic/Ripple%E7%91%9E%E6%B3%A2XRP%20-%20%E5%9B%BE%E7%89%87%E5%89%AF%E6%9C%AC_Ripple2016.png)

![](https://cdn.jsdelivr.net/gh/zey9991/mdpic/Ripple%E7%91%9E%E6%B3%A2XRP%20-%20%E5%9B%BE%E7%89%87%E5%89%AF%E6%9C%AC_Ripple2020.png)

值得指出的是，Ripple多次面对监管机构的调查和诉讼，例如2015年因未经授权销售瑞波币被罚款，以及2020年SEC指控其未经注册发行证券。

这些挑战不仅消耗了大量资源（超过1亿美元的法律费用），也推动了Ripple调整运营模式和合规策略（如获得BitLicense和新加坡央行许可），促使了它谋求推动监管政策变革（如捐款名为Fairshake的超级政治行动委员会）。

## 商业模式和产品矩阵

Ripple 要求人们获得使用许可，这意味着使用区块链的主要是银行和金融机构。这里的目标是为金融机构提供一种无需使用 SWIFT 系统即可进行国际转账的方式。

Ripple官网列出的产品包括：直接支付、按需支付、资产托管和稳定币四种。下面分别介绍它们。其中仅按需支付ODL可能对C端个人有一定吸引力。

#### 直接支付（Direct）

该产品中，Ripple 负责向受益人付款、管理支付合作伙伴、向支付合作伙伴提供资金，以及支付费用以换取向受益人付款。

整个支付流程如下图所示：

![](https://docs.ripple.com/payments-direct/61c0b9828b9229dd6cdd282a48c1f795/direct-payment-flow.png)

1. 发送方客户（节点 1）在 Ripple Payments UI 中输入支付信息。
2. 中介方 Ripple（节点 2）验证交易。如果风险和合规检查均成功，Ripple 将批准该交易。
3. 支付合作伙伴（节点 3）现在验证交易。如果他们的合规检查成功，他们将批准该交易。
4. XRP 将被转移并转换为目的国货币，由支付合作伙伴进行分配。
5. 支付合作伙伴通过向收款人发送资金来完成支付。

特别注意：将 Ripple 设置为支付提供商后，客户不再需要购买、出售或拥有 XRP！

#### 按需支付（ODL）

ODL，全称On-Demand Liquidity，按需流动性。ODL 使用 XRP 作为过渡货币，按需获取流动性，并实时转移资金。该产品仍然主要是ToB的，但是也可能吸纳部分C端个人。

ODL的用户界面基于点对点分布式应用程序RippleNet，它维护一个虚拟账本来模拟 Nostro 和 Vostro 账户和关系，由一个双向消息传递层和一个结算层组成。可以使用一些 API 操作将 RippleNet 与支付系统集成，使用 API 操作将资金复制到 RippleNet 虚拟账户，而不是访问金融机构的核心银行系统。

RippleNet 可以使用 Ripple 的 ODL（按需流动性）产品访问 XRP 账本上的流动性。RippleNet 部署在 Ripple 托管的云环境中，不需要客户维护。

以个人付款为例，支付流程如下图所示：

![](https://docs.ripple.com/payments-odl/b1d8371f4583454e0570653b55ee9a16/use-cases-1-individual-payments.svg)

1. Ripple 将 XRP 存入发送者的指定钱包。
2. 发送者使用 RippleNet API 操作检索并接受报价。
3. RippleNet 将 XRP 从发送者的钱包转移到接收者的钱包。
4. 收款人向收款人支付法定货币。
5. 接收方将 XRP 清算为法定货币。
6. Ripple 向发件人开具发起付款的发票汇总。

#### 资产托管（Custody）

Ripple Custody 被描述为用于保护、转移和结算代币化金融资产的重要软件基础设施。该产品主要面向企业级用户。

XRPL 代币化功能的集成使使用 Ripple Custody 的企业能够处理各种资产，除了现实世界的资产外，还包括加密货币和法定货币。它还促进了数字资产的发行和从平台的安全转移，同时提供对 XRPL 去中心化交易所的访问，以便高效地交易代币化资产。

#### 稳定币（RLUSD）

今年4月，Ripple首次宣布推出 RLUSD 的计划。

6月，Ripple收购了Standard Custody & Trust Company，这是一家由NYDFS特许的有限目的信托公司。

8 月，Ripple [开始](https://cryptoslate.com/ripple-starts-testing-its-stablecoin-rlusd-on-xrp-ledger-and-ethereum/)在 XRP Ledger 和以太坊主网上对 RLUSD 进行 beta 测试。当时，该公司还宣布了将稳定币扩展到其他区块链的计划。在一份声明中，Ripple 表示：“对提供信任、稳定性和实用性的稳定币有明显的需求。一旦 RLUSD 可用，Ripple 将在其跨境支付解决方案中使用 RLUSD 和 XRP 来为其全球客户提供服务并显着改善他们的体验。

10 月，Ripple 宣布已与顶级交易所合作，向用户提供 RLUSD。这包括 Uphold、Bitstamp、Bitso、MoonPay、Independent Reserve、CoinMENA 和 Bullish。并由市场 B2C 2 和 Keyrock 支持其流动性。

11月末，Fox Business 援引知情人士的话报道，该稳定币将获得纽约金融服务部 （NYDFS） 的批准，并可能在 12 月 4 日之前准备好推出。

根据其官方文档，RLUSD稳定币合约计划部署在XRP Ledger和Ethereum上。

稳定机制方面，每个 RLUSD 代币都由美元存款、美国政府债券和现金等价物支持。Ripple 已承诺每月发布由会计师事务所 BPM 进行的储备资产的第三方审计证明。

## 价值脱钩

XRP的价值真的与Ripple的核心产品挂钩吗？

让我们一起再来回顾一下Ripple现阶段的产品架构：

- **Ripple Payments Direct**：根据官方文档，客户不需要购买、出售或拥有 XRP。**笔者认为这代表着：与该业务相关的一切利好消息（比如与XX银行XX公司达成合作等等）都与XRP代币无关**。
- **Ripple Payments ODL**：ODL 使用 XRP 作为过渡货币，按需获取流动性，并实时转移资金。在这个场景中，XRP被用作资金转换的媒介，涉及XRP的买入和卖出操作，似乎可能会对XRP有一定的买盘支撑。**但根据笔者整理的Ripple历史季度报告中的数据，ODL业务的结果是净出售XRP代币，业务中出售的XRP数额往往高于回购的XRP数额**。此外，2020年[深潮文章](https://www.techflowpost.com/article/detail_9541.html)分析称“实际上它（指ODL）的成本要高得多，因此，如果没有 Ripple 的大量补偿，机构不希望使用这种产品”，“货币支付机构成为 Ripple 销售未注册的 XRP 的又一渠道”。
- **Ripple USD (RLUSD)**：跨境支付解决方案中，**客户出于减小汇兑损失的目的，在RLUSD推出后，理应更倾向于选择稳定币RLUSD作为支付方案，使人更难相信这个业务的推出能够为XRP赋能**。

![](https://cdn.jsdelivr.net/gh/zey9991/mdpic/Ripple%E7%91%9E%E6%B3%A2XRP%20-%20%E5%9B%BE%E7%89%87%E5%89%AF%E6%9C%AC_ODL.png)

注：

1. ODL 相关销售额包括支持 ODL（包括信用额度）和关键基础设施合作伙伴的 XRP 销售额；
2. 净ODL相关销售额=XRP总出售额-XRP总回购额；
3. Ripple似乎仅于2020Q2-2023Q1时间段内公布ODL业务数据，2023Q2及以后仅公布Ripple持有的XRP代币总量和托管账户中的XRP代币总量。

综上所述，**笔者认为现阶段来看，Ripple的核心业务逻辑似乎并未给XRP提供多少买盘基础**，而且Ripple事实上在通过账户托管和ODL业务等等渠道释放XRP，因此不能简单地将Ripple的各类业务拓展视为XRP代币的利好，只有那些确实计划在XRPL公链开发新业务的合作才是实在的利好消息。例如在上季度，Meld Gold [宣布](https://medium.com/meld-gold/meld-gold-to-launch-rwas-on-xrp-ledger-05eee5da97ea)与 Ripple 合作，将可替代的黄金和白银资产引入 XRPL，这确实丰富了链上资产种类，增加网络交易费用。

团队业务和代币价值脱钩的问题其实广泛存在，甚至出现在不少知名项目上。例如，宣布分红前的UNI代币就是例子，但是这些代币的价格走势还是往往会受到“表面上”的利好消息影响。对这种现象，笔者想提出一些粗鄙的看法：

解释一：如果认为市场并非完全有效的，参与者也不是完全理性的，那么得益于宣传造势、企业形象方面Ripple与XRP代币的密切关联，Ripple官方的利好消息，可能“误导”了投资者，增加了XRP的上涨可能。

解释二：如果认为市场是有效的，参与者都是理性的，那为什么XRP代币价格上涨呢？可能是Ripple官方给下文要介绍的XRPL公链及基金会等相关主体提供了一定的资金支持、人才支撑，等等。这些支持虽说不太可能直接支撑起XRP的买盘，但是长远来看，这对XRPL公链的生态发展是一种利好，进而利好XRP代币。市场可能只是提前把这部分长远期的利好反映在了XRP代币的价格上面。

这两种解释都是有可能的。总之，虽说Ripple的核心业务逻辑确实没有直接赋能XRP价格上涨，但是却能够通过其他渠道发挥支撑作用，笔者认为还是不要低估了Ripple利好消息对XRP价格的影响。

# XRP Ledger：ToB的高性能区块链

## 项目定位

在[XRPL的官网](https://xrpl.org/about)上写道：

> The XRP Ledger is a decentralized public blockchain built for business.

XRP Ledger 的主要优势之一是快速高效的共识算法，它可以在 4 到 5 秒内结算交易，同时以每秒高达 1,500 笔交易的吞吐量进行处理，适用于企业级客户的日常支付和跨境交易和汇款。

## 发展历程

![](https://cdn.jsdelivr.net/gh/zey9991/mdpic/Ripple%E7%91%9E%E6%B3%A2XRP%20-%20%E5%9B%BE%E7%89%87%E5%89%AF%E6%9C%AC_XRPL2011.png)

![](https://cdn.jsdelivr.net/gh/zey9991/mdpic/Ripple%E7%91%9E%E6%B3%A2XRP%20-%20%E5%9B%BE%E7%89%87%E5%89%AF%E6%9C%AC_XRPL2016.png)

![](https://cdn.jsdelivr.net/gh/zey9991/mdpic/Ripple%E7%91%9E%E6%B3%A2XRP%20-%20%E5%9B%BE%E7%89%87%E5%89%AF%E6%9C%AC_XRPL2020.png)

![](https://cdn.jsdelivr.net/gh/zey9991/mdpic/Ripple%E7%91%9E%E6%B3%A2XRP%20-%20%E5%9B%BE%E7%89%87%E5%89%AF%E6%9C%AC_XRPL2022.png)

注：XRP Ledger客户端软件旧称为rippled，这里为了方便统一写了XRP Ledger。

XRPL 的发展历程反映出其技术导向、市场化需求与去中心化生态建设之间的平衡。它从一个基础支付解决方案逐步演变为一个多功能、开放的区块链生态系统，具有不错的行业适应力和创新能力。

- **早期阶段（2012-2016）：**
  系统基础架构的搭建，包括延迟支付、托管账户和严格交易控制等基础功能。
- **成熟阶段（2017-2020）：**
  引入高级功能如多重签名、历史记录分片、账户删除和动态储备金调整，使系统更高效且更具适应性。
- **多样化阶段（2021-至今）：**
  支持NFT、自动做市商（AMM）、跨链桥（XChainBridge）和去中心化标识符（DID）等功能，展现出生态系统扩展和多样化的趋势。

目前XRPL上主要能够支持的市场级应用包括：

- 同质化代币标准与CLOB和AMM的DEX；
- 非同质化代币标准与NFT市场；
- 基础设施例如XRP侧链、跨链桥（XChainBridge修正案）、价格预言机、DID等等。

值得指出的是，XRPL 有一个内置的CLOB DEX（中央限价订单簿去中心化交易所），与其他使用智能合约建立 DEX 的网络不同。原生 DEX 的好处是信任假设较少和流动性整合，而不是智能合约固有的漏洞。尽管 XRPL 只有一个 CLOB，但多个市场（也称为网关）为用户提供了访问界面。这些市场共享流动性，并为普通用户提供了便捷的操作体验。

## 技术特点

### 信任线与储备金

除XRP外的链上同质化代币都存储在连接两方账户的被称为“信任线”（Trust Lines）的会计关系中。所有同质化代币的转移都沿着信任线进行。

每个信任线都是一个双向关系，包括：

- 信任线连接的两个账户的标识符。
- 单一的共享余额，从一个账户的角度来看是正的，而从另一个账户的角度来看是负的。余额为负数的一方称为 “发行者”，可以控制这些代币行为方式的一些属性。
- 各种设置和元数据。这两个账户中的每一个都可以在信任线上控制自己的设置。最重要的是，每一端都在信任线上设置了一个限制，默认情况下为 0。一般而言，每个账户的余额（从信任线的角度来看）不能超过该账户的限制，但是信任线可以通过某些交易隐式创建，例如当在去中心化交易所购买代币时。

信任线主要可以避免其他人持有他们不想要的代币。

由于信任线占用了XRPL中的空间，因此信任线会增加账户必须保留的 XRP。当一个账户拥有超过2条信任线后，就可能被收取信任线的预留金。

这种储备要求旨在防止垃圾数据填充账本。这些数据需要在整个网络中复制，并由系统中的所有服务器维护。基本储备（目前为 10 XRP）规定了创建新账户时必须发送的最低 XRP 数量；拥有者储备（目前为每项 2 XRP）会根据账户在账本状态数据中持有的额外对象（如报价、信任线和托管）逐项增加账户的储备要求。当前的储备金要求是在2021年9月19日投票生效的。

![来源：https://livenet.xrpl.org/transactions/5922A0BA30621C60B2B6DDBC3FF6B5BB509EB3685C4C3D56696A9FE4FE6D48A3/simple](https://cdn.jsdelivr.net/gh/zey9991/mdpic/image-20241207164409676.png)

### 涟漪结算（Rippling）

当地址通过使用相同货币代码的信任线链接时，会出现“涟漪结算”（Rippling）。例如，如果 Alice 欠 Charlie 钱，而 Alice 也欠 Bob 钱，那么用信任线表示为：

![](https://xrpl.org/assets/noripple-01.04726bfaef98a92eae3f05f6cc8fef4858906b3a0ae7bb0eee298b3f5f96a719.ac57e6ef.svg)

如果 Bob 想向 Charlie 支付 3 美元，那么他让Alice 将 Bob 的部分债务转移给 Charlie，用信任线表示如下：

![](https://xrpl.org/assets/noripple-02.1953e85ff4f44374629f95216bb4ba493dac30a2d2a555aa4db9c4f9cf11bba2.ac57e6ef.svg)

两个地址通过调整它们之间的信任线余额来相互支付的过程称为“涟漪结算”，其中两个地址通过调整它们之间的信任线余额来相互支付。

信任线上可以设置 No Ripple 标志。当两条信任线都启用了同一地址的 No Ripple 时，来自第三方的付款无法通过这些信任线上的该地址进行波纹。这可以防止流动性提供者在使用相同货币代码的不同发行商之间意外转移余额。

### Hooks

XRPL虽然没有严格意义上的智能合约，但是Hooks修正案（类似于ETH的EIP，BNB的BIP等等）中通过的Hooks功能，能够小而高效的代码段来影响交易的行为和流程，这些代码可以在交易之前或之后在执行逻辑。

截至2024年12月7日，该修正案仍在开发阶段，尚未上线。

### 定制化开发的侧链

例如，可以添加智能合同层、添加以太坊虚拟机 （EVM） 兼容性、使用自定义账本类型和交易规则等等。

### 无激励的PoA共识机制

XRP Ledger 的主要优势之一是快速高效的共识算法，它可以在 4 到 5 秒内结算交易，同时以每秒高达 1,500 笔交易的吞吐量进行处理。根据XRPScan的数据，实际的TPS峰值出现在2023年12月31日，达到329。

XRP Ledger 背后的开发人员认为，工作量证明 （PoW） 存在能源浪费，并且仅对初始分配和解决双花真正有用。核心开发人员得出结论，比特币的真正魅力在于交易和状态的公开，而不是 PoW 共识机制，他们通过构建一个节能的替代方案 XRPL 来挑战 PoW 的主导地位。

XRPL 使用关联证明 （PoA） 共识算法——以前称为联邦拜占庭共识协议。PoA 要求每个节点设置一个可信节点列表，它将依赖该列表来达成共识。此可信节点列表称为唯一节点列表 （UNL）。验证者不能仅依靠财务手段来获得共识过程的访问权限，必须首先获得其他节点的信任。许多节点使用默认 UNL 之一来设置自己的可信节点。默认 UNL 是 XRPL Foundation、Ripple 和 Coil 推荐为值得信赖的节点列表，但节点可以选择他们认为值得信赖的任何验证者列表。

在网络运行的过程中，每个服务器都会监听其信任的验证者的反馈；只要有足够多的验证者（80%以上）同意某组交易应该被执行且生成的账本是正确的，该服务器就会宣布达成共识。如果未达成一致，验证者将修改其提案以更接近其他信任的验证者的建议，并多轮重复这一过程，直到达成共识。

![](https://xrpl.org/assets/consensus-rounds.53c6bfe2b6dc594a8fb285b51215249bf405263ab2a694b04532994c17b4d065.ac57e6ef.svg)

此外，与其他去中心化账本不同，XRPL不会通过运行验证者为共识过程做出贡献提供直接的经济激励。其他区块链提供直接激励，例如挖矿和质押或交易优势的奖励。相反，官方声称“缺乏对 XRP Ledger 验证者的直接激励吸引了自然的利益相关者”。（这一点后文会吐槽。）

与工作量证明（PoW）和权益证明（PoS）相比，PoA 具有以下优势：

1. **硬件要求较低**，从而减少电力和运营成本，使得运行验证节点的成本比 PoW 挖矿更低。
2. **区块生成不直接依赖于拥有最多资本的参与者**，这与 PoS 不同。
3. **不存在重组（即区块验证后被更改的情况）**。

此外，PoA 也存在一些潜在的缺点：

1. 由于 PoA 不需要高昂的外部成本或锁定资本，对恶意行为者的经济惩罚能力较弱。
2. 尽管可以通过切断验证者连接或将节点从 UNL（唯一节点列表）中移除来进行报复，但攻击者不会面临经济损失。
3. XRPL 上的 PoA 实现**在出块节点的去中心化程度上不如主流 PoW 或 PoS 链**。这可能是因为 PoA 缺乏参与的经济激励。

## 费用类型

XRPL上的费用主要包括：

- 交易费用（transaction cost）：发送交易时销毁的微量XRP。这一费用随网络负载而变化。
- 储备要求（reserve requirement）：账户必须持有的最低XRP数量。该数量随账户在账本中拥有的对象数量增加而增加。
- 转账费用（transfer fees）：可选费用。发行方在将发行的货币转移到XRP Ledger内的其他地址时可选择收取的百分比费用
- 信任线质量（trust line quality）：可选费用。允许账户将信用额度上的余额设定为高于或低于面值。这可能会导致类似于收取费用的情况。

## 链上数据

XRPL目前的核心业务还是在同质化代币和去中心化交易所相关服务上面，同时考虑到其公链属性，我们可以重点观察总锁仓价值（TVL）、活跃交易者数量、链上资产数量、链上资产市值、信任线数量、交易量、交易费用（网络收入）这几个核心指标。

更详细的分析笔者推荐进一步查看Messari的文章，在深潮上有搬运：[Messari XRP 深度报告：Q3 原生智能合约提案新高，日交易量环比增长 94% - 深潮TechFlow](https://www.techflowpost.com/article/detail_22024.html)

### 总锁仓价值

![2024年3月-2024年12月XRP锁仓量 图片来源：https://xrpscan.com/amms](https://cdn.jsdelivr.net/gh/zey9991/mdpic/image-20241208145513862.png)

上图显示自24年初XRP的锁仓量整体呈增长趋势，11月初左右达到峰值15M（1500万）左右，后锁仓量有所减小（可能是部分LP套现离场），但仍保持在10M（1000万）以上。

AMM池中的锁仓量要小得多，自10下旬开始快速增长，但2024年12月8日也仅达到10K（1万）XRP左右。

### 日活跃用户数

这里是指XRPL链上活跃的（独立）账户数。

![2022年5月-2024年12月XRPL活跃账户数量 图片来源：https://xrpscan.com/metrics](https://cdn.jsdelivr.net/gh/zey9991/mdpic/image-20241208084030781.png)

截至2024年12月8日，XRPL的最新日活12月初达到了历史新高（注意XRPScan中该项数据自2022年5月起才有记录），为105,956。新的一周日活量有所下降，但是仍然维持在历史高位。

### 日交易数量

![2022年5月-2024年12月XRPL交易笔数 图片来源：https://xrpscan.com/metrics](https://cdn.jsdelivr.net/gh/zey9991/mdpic/image-20241208103209933.png)

截至2024年12月8日，XRPL链上日交易笔数也是维持在高位200万笔左右，不过不及2024年初的超600万笔的峰值（Messari分析师认为，这可能与2023 年底开始的[铭文活动](https://twitter.com/offledger/status/1742338406829773066)激增有关）。由于XRPScan该项指标自2013年起就有记录，我们可以再看看这些数字在XRPL的生命周期的地位。

![2013年1月-2024年12月XRPL交易笔数 图片来源：https://xrpscan.com/metrics](https://cdn.jsdelivr.net/gh/zey9991/mdpic/image-20241208085140919.png)

可以看到，截至2024年12月8日，XRPL的最新日交易笔数总体而言还是在全生命周期的高位。峰值方面，超600万笔的日交易笔数已经超过上轮牛市的约500万笔的极值。而趋势方面，这轮牛市中也是要高出约几十万笔左右。

值得指出的是，在熊市期间XRPL的日交易笔数也是维持一定水位，甚至从直观上看还略高于上轮牛市期间，说明XRPL的日交易笔数总体上不分牛熊，保持逐步上升的趋势。

### 日交易体量

![](D:\Learning Materials\Web3俱乐部\research_report\projects\2412-XRP\data\Ripple瑞波XRP - 图片副本_Trading Volume.png)

因为实际数据中有非常多数值特别大的极值，上图中的竖轴取了对数平滑处理。可以看出，截至2024年12月8日，大部分时段XRPL交易体量保持在100万至1000万美元之间。2024年11月末突破1000万美元大关后仍然保持。

![](D:\Learning Materials\Web3俱乐部\research_report\projects\2412-XRP\data\Ripple瑞波XRP - 图片副本_DEX vs. CEX.png)

根据上面这幅图可以看清楚DEX和CEX的交易体量占比情况，CEX自2022年8月初有数据以来，几乎瞬间就占据了主导态势，此后的大多数时间段还是CEX交易量占主导，其中有部分时间段DEX占比短暂大幅提升，可能是meme热潮的结果。

### 日交易费用

![2022年5月-2024年12月XRPL交易费用 图片来源：https://xrpscan.com/metrics](https://cdn.jsdelivr.net/gh/zey9991/mdpic/image-20241208085540183.png)

![2022年5月-2024年12月XRPL交易笔数 图片来源：https://xrpscan.com/metrics](https://cdn.jsdelivr.net/gh/zey9991/mdpic/image-20241208103209933.png)

截至2024年12月8日，大部分时间段交易费用保持在几千XRP的水平，折合当时的美元价值，交易费用是非常便宜的。图中的“尖刺”发生时间段并没有对应交易笔数中的极值的出现时间，具体产生原因笔者暂时不清楚。

### Token数量

![](D:\Learning Materials\Web3俱乐部\research_report\projects\2412-XRP\data\Ripple瑞波XRP - 图片副本_Listed Tokens.png)

从2024年10月末（美大选接近尾声时）开始，XRPL上的资产数量开始暴增，2024年12月8日已经达到了12,428。其余时段，资产数量缓慢增长。

### Token市值

![](https://cdn.jsdelivr.net/gh/zey9991/mdpic/Ripple%E7%91%9E%E6%B3%A2XRP%20-%20%E5%9B%BE%E7%89%87%E5%89%AF%E6%9C%AC_Token%20Mcap.png)

代币市值方面，同样在10月底11月初（美大选接近尾声时）有一个突破，11月22日曾短暂达到过\$393.96M的历史峰值。2024年12月8日这一数字为\$347.33M。

根据Messari的报告，截至第三季度末，XRPL 上按市值排名的顶级代币如下：

- Sologenic ( [SOLO](https://xpmarket.com/token/SOLO-rsoLo2S1kiGeCcn6hCUXVrCpGMWLrRrLZz) ) 的市值为 3430 万美元，拥有 228,000 名持有人。 SOLO主要用于支付 [Sologenic 网关](https://www.sologenic.com/)上的交易费用。
- Bitstamp BTC ( [BTC](https://xpmarket.com/token/BTC-rvYAfWj5gh67oV6fW32ZzP3Aw4Eubs59B) ) 的市值为 1,250 万美元，拥有 4,500 名持有者。 Bitstamp BTC 是 [Bitstamp](https://gatehub.net/) 提供的比特币的包装版本。
- Gatehub Fifth ETH ( [ETH](https://xpmarket.com/token/ETH-rcA8X3TVMST1n3CJeAdGk1RdRCHii7N2h) ) 的市值为 1130 万美元，拥有 26,000 名持有者。 Gatehub 第五版是 [GateHub](https://gatehub.net/) 提供的 Ether 的包装版本。
- Coreum ( [CORE](https://xpmarket.com/token/CORE-rcoreNywaoz2ZCQ8Lg2EbSLnGuRBmun6D) ) 的市值为 890 万美元，拥有 71,000 名持有人。 CORE是 [Coreum 侧链](https://www.coreum.com/)的原生代币，也是由 Sologenic 团队开发的。

# XRP：经济模型与估值水平

XRP代币是XRP Ledger（XRPL）上的原生代币。

## 经济模型

- 供应上限：100B（1000亿）。

- 分配比例：代币的20%分配给三个创始人Jed McCaleb、David Schwartz 和 Arthur Britto，80%分配给后来的Ripple。
- 通胀机制：无。意味着XRP代币的排放实质全由市场供需决定。其中Ripple作为巨庄，它的排放（包括托管锁定和即时可用的部分）尤其值得关注。
- 通缩机制：交易费用会被销毁。自网络启动以来，已销毁近 1300 万 XRP。因交易费用较低，销毁率较低。

![来源：https://messari.io/report/xrp-ledger-more-than-ripples](https://cdn.sanity.io/images/2bt0j8lu/production/6344aa6e243976a27b537b66ee7b18cb945c80b7-1280x720.png?w=714&fit=max&auto=format&dpr=3)

从2023年Q1开始，Ripple在季度报告中会公布排放的XRP数量。Ripple 拥有的 XRP 分为两类：目前在其钱包中可用的 XRP，以及受账本托管锁定的 XRP。对于后一类，Ripple 无法直接访问该 XRP，这类XRP从2017年12月开始排放至今，月末未被购买的XRP，将会放回到新的智能合约。

![](https://cdn.jsdelivr.net/gh/zey9991/mdpic/Ripple%E7%91%9E%E6%B3%A2XRP%20-%20%E5%9B%BE%E7%89%87%E5%89%AF%E6%9C%AC_XRP%E6%89%98%E7%AE%A1%E6%95%B0%E9%87%8F.png)

注：减持XRP总量=本季度钱包中可用的XRP总量+本季度托管锁定的XRP总量-上季度钱包中可用的XRP总量-上季度托管锁定的XRP总量

可以看出，在23Q1-24Q3这个时间段内，每季度Ripple减持约800M（8亿）以上的XRP代币，价值几乎都在400M（4亿）美元以上。

其实从这里就可以再次PoA存在的问题：前面文档中声称“缺乏对 XRP Ledger 验证者的直接激励吸引了自然的利益相关者”，而Ripple作为高度控盘的巨鲸出售XRP，变相充当XRPL网络的通胀机制，实际上类似于把PoW或PoS共识协议中给验证者的激励部分囊括到自己的收入里面去，对于那些参与网络维护的验证者没有任何激励，这从纯商业的角度看来不太可行。

## 代币效用

XRP没有特别的用途，主要是支付XRPL网络上的各种费用、购买各种链上资产等等，充当交易媒介。

## 代币估值

选择竞品Stellar Network(\$XLM)应用相对估值法。注意，尽管两者的产品有一定的相似性，在目标客户、通胀机制等方面还是有一定的差异性。XRP旨在服务金融机构的需求，而XLM旨在服务（尤其是在发展中国家）个人和小型企业的需求。

经济模型方面，虽然现阶段Ripple的XRP排放实质上相当于网络通胀机制，但是没有新增发的XRP，而Stellar Network的经济模型中，其中一小部分新创建的 XLM 被分发以激励参与网络，形成缓慢通胀。总之，请读者注意，此处的估值仅具有一定参考意义，不一定完全准确。

![](D:\Learning Materials\Web3俱乐部\research_report\projects\2412-XRP\data\Ripple瑞波XRP - 图片副本_估值.png)

注：

1. 上表中，XRP的年化费用根据XRPScan上个月费用数据和CoinMarketCap, The Wall Street Journal的价格数据测算得来，其他部分的数据全部来自Tokentermianl。
2. P/F即FDV或MC除以近30天的年化费用。

可以看出，相对于竞品XLM，XRP的PF比值还要更低，价格更具性价比。根据当前的XRP流通数量61,935,346,471（XRPScan），可计算出对应的XRP代币价格约为\$3.4957。这说明，根据此处的估值方法，此时XRP的市值和价格仍可能有一定上探的空间。考虑到XRP价格的ATH是\$3.84，本文的估值可能相对保守。

## 未来展望

### Ripple公司IPO预期

2024年11月18日，据 U.Today 报道，SBI Holdings 首席执行官北尾吉孝 (Yoshitaka Kitao) 建议，知名企业区块链公司 Ripple 应考虑在与美国证券交易委员会 (SEC) 的法律问题得到解决后准备首次公开募股 (IPO)。

Ripple 首席执行官布拉德·加林豪斯 (Brad Garlinghouse) 此前曾提到，上市并不是该公司的当务之急，他以强大的财务状况作为推迟上市的理由。不过，他并没有完全排除未来 IPO 的可能性。2022 年，加林豪斯表示，Ripple 将在 SEC 诉讼结束后探索 IPO，并表达了 Ripple 最终成为上市公司的愿景。

2024年12月4日，《巴伦周刊》（Barron's Weekly）报道称，特朗普政府正考虑向加密货币公司开放首次公开募股（IPO）市场，进一步打开了市场对此的想象空间。

正如前文所述，虽说Ripple公司的IPO业务与XRP代币价值理论上不太相关，但是就历史上此类利好的市场反应来看，可以预计Ripple公司未来IPO的利好消息将短暂提振XRP代币价格。

### 机构采用

Ripple 最初的战略是将自己定位为加密货币领域的成熟实体，避免与当时盛行的无政府主义和自由主义文化产生关联。Ripple 的目标并非取代传统金融体系，而是通过推动金融科技公司和银行采用 XRP 来改善现有的金融架构。这一战略一直是 Ripple 市场布局的核心。

随着特朗普当选第47届美国总统和加密监管环境的放松，Ripple 长期以来的合规化战略和政策寻租举措将有望促使 XRPL 获得更多机构采用。这一趋势预计将为 XRPL 带来包括更丰富的链上资产和更多交易费用在内的益处，并进一步推动 XRP 代币的上涨预期。

此外，10 月下旬，Ripple 首席执行官 Garlinghouse 在接受彭博电视采访时表示：“我认为，XRP ETF 获得批准是不可避免的。”他补充道，“机构和散户对这一资产类别的需求非常强烈。”截至 12 月初，多个机构，包括 Bitwise、Canary、21 Shares 和 WisdomTree，相继提交了现货 XRP ETF 申请，为市场带来更多想象空间。

### 生态拓展

XRPL公链的生态拓展可以从两个方面看待。一方面，特别是2020年以来，XRPL链上各类应用发展更加成熟完善了，不再只是由单纯的交易和转账功能，这一点在前文也提到过。

另一方面，XRPL 正在积极提升与其他区块链的互操作性。例如，2024年1月上线的 XRPL 2.0.0 版本中的 XChainBridge 修正案便引入了跨链桥功能。此外，2024年第一季度，去中心化的跨链通信网络 Axelar与 XRPL 进行了集成，进而将 XRPL 生态系统与[60多个](https://axelarscan.io/)区块链网络连接，包括以太坊和 Cosmos 生态系统。随着XRPL链AMM的发展，Axelar 的连接使得从多个高 TVL 网络获取流动性变得更加便捷。

## 潜在风险

### Ripple公司的业务逻辑与XRP代币价值脱钩

这一问题在前文已有提及。在乐观情绪下，短期内可能不会引发太大问题，但在悲观情绪或长期视角下，这一脱钩现象可能会被放大并产生不利影响。

### 经济模型和共识机制设计的历史问题

如前所述，尽管在 PoA 共识机制下，XRPL 的可扩展性已经足够强大，但仍存在一定的问题。当前，XRPL 网络的实质性通胀机制更多反映为 Ripple 作为“巨鲸”或“庄家”不断向市场抛售 XRP，而非像其他区块链那样通过奖励验证者来激励网络参与。这种机制容易导致市场对其产生看空情绪。试想，如果在以太坊价格上涨时，我们得知以太坊基金会或 Vitalik 不断抛售 ETH，这显然会引发类似的担忧。虽然 Ripple 已经设立了账户托管机制，并且每季度公开报告其持仓的 XRP 数量，但这种抛售行为仍然不时遭到外界的批评。

### 持续吸纳C端消费者的叙事逻辑不足

这与Ripple以及XRPL的定位有关。在主要是ToB的商业模式下，如何持续地吸引散户投资者或其他链上用户值得商榷。笔者注意到XRPL的生态及应用确实是逐渐丰富，但是相较于其他链的使用体验还有一定差距。未来能否吸引更多的社区成员参与进来，让我们拭目以待。

# 参考文献

1. [Global Payments & Financial Solutions for Businesses | Ripple](https://ripple.com/)
2. [Stablecoins: Essentials and Impact](https://ripple.com/reports/Stablecoins-Essentials-and-Impact.pdf)
3. [Ripple Documentation](https://docs.ripple.com/)
4. [XRP Ledger Documentation & Developer Resources](https://xrpl.org/docs)
5. [Fungible Tokens](https://xrpl.org/docs/concepts/tokens/fungible-tokens)
6. [Authorized Trust Lines](https://xrpl.org/docs/concepts/tokens/fungible-tokens/authorized-trust-lines)
7. [Deposit Authorization](https://xrpl.org/docs/concepts/accounts/depositauth)
8. [Freezing Tokens](https://xrpl.org/docs/concepts/tokens/fungible-tokens/freezes)
9. [XRPL Explorer | Ledgers](https://livenet.xrpl.org/)
10. [XRP Ledger Explorer - XRPSCAN](https://xrpscan.com/)
11. [XRP Rich list and balance distribution | XRPSCAN](https://xrpscan.com/balances)
12. [XRPL Commons - Building the commons with the XRPL Community](https://www.xrpl-commons.org/)
13. [Software Developer Grants Program - XRPLGrants.org](https://xrplgrants.org/)
14. [运行 XRP Ledger Validator](https://xrpl.org/blog/2020/running-an-xrp-ledger-validator)
15. [rippled 版本 1.0.0](https://xrpl.org/blog/2018/rippled-1.0.0)
16. [去中心化策略更新](https://xrpl.org/blog/2017/decent-strategy-update)
17. [XRPL Hooks - XRP 账本的智能合约提案](https://xrpl-hooks.readme.io/)
18. [XRP 市值重返加密第三，XRP ETF 先行一步？ - Foresight News](https://foresightnews.pro/article/detail/72855)
19. [Ripple 首席执行官 Garlinghouse 揭示 XRP 上涨的主要原因 | 加密探险家o on Binance Square](https://www.binance.com/en-BH/square/post/16306098656497)
20. [错过 XRP 涨幅？不妨看看瑞波生态内的热点 Meme 币（附参与教程） - 深潮TechFlow](https://www.techflowpost.com/article/detail_21969.html)
21. [XRP 一路高涨：为什么零风投、无智能合约、低用户量，反而成就了 1,800 亿美元市值？ - 深潮TechFlow](https://www.techflowpost.com/article/detail_21962.html)
22. [金色观察 | 单月上涨400% XRP还能上车吗](https://www.jinse.cn/blockchain/3704258.html)
23. [利好频出，老牌公链代币XRP焕发新生，未来能走多远？-非小号](https://www.feixiaohao.com/news/13033930.html)
24. [與川普會面討論加密幣政策？ Ripple CEO 耐人尋味回應引爆 XRP 飆漲 - 區塊客](https://blockcast.it/2024/11/18/ripple-ceos-remarks-spark-rumors-of-presidential-talks-during-xrp-surge/)
25. [Ripple和XRP：加密政策驱动与去中心化挑战](https://www.jinse.cn/blockchain/3704195.html)
26. [万字解析 Web3 支付赛道：全球化支付的未来](https://mp.weixin.qq.com/s/zRwYAunc8Am5HHzhyJIDew)
27. [XRP 调研分析报告 - Foresight News](https://dev.foresightnews.pro/article/detail/49717)
28. [SEC解密Ripple坐庄手法：拉拢机构出货，配合利好拉盘 - 深潮TechFlow](https://www.techflowpost.com/article/detail_9541.html)
29. [Read RIPPLE 开放式全球支付网络 | Leanpub](https://leanpub.com/ripple/read#leanpub-auto-ripple-1)
30. [饱受诟病的Ripple 凭什么估值100亿美金？_手机新浪网](https://finance.sina.cn/blockchain/2020-02-18/detail-iimxyqvz3912668.d.html)
31. [深扒！市值暴跌80%,共识机制被质疑,Ripple从天堂跌落地狱](https://www.sohu.com/a/221640234_114877)
32. [Ripple 声称在 SEC 诉讼中获胜，XRP 价格飙升 - Securities.io](https://www.securities.io/zh-CN/xrp-price-surges-as-ripple-claims-victory-in-sec-lawsuit/)
33. [日内涨幅近70%！XRP带飞整个加密市场，但监管走向依旧不明朗_腾讯新闻](https://news.qq.com/rain/a/20230714A06JBR00)
34. [Stellar 与 Ripple：评估长期竞争对手的表现 - Securities.io](https://www.securities.io/zh-CN/Stellar-与-Ripple-评估长期竞争对手的表现/)
35. [Messari XRP 深度报告：Q3 原生智能合约提案新高，日交易量环比增长 94% - 深潮TechFlow](https://www.techflowpost.com/article/detail_22024.html)
36. [XRP Ledger: More than Ripples | Messari](https://messari.io/report/xrp-ledger-more-than-ripples)
37. [Ripple Drops Another $25M Into Crypto PAC to Sway 2026 Congressional Races](https://finance.yahoo.com/news/ripple-drops-another-25m-crypto-004106887.html)
38. [Ripple Vs. Stellar (2024 Edition) - Securities.io](https://www.securities.io/xrp-vs-stellar/)
39. [XLM vs XRP: What's the difference?](https://atomicwallet.io/academy/articles/xlm-vs-xrp-whats-the-difference)
40. [Ripple的策略性成长与未来前景 | Binance News发布于币安广场](https://www.binance.com/zh-CN/square/post/12-04-2024-ripple-s-strategic-growth-and-future-prospects-17102872602922)
41. [Ripple’s stablecoin RLUSD expected to launch on Dec. 4 with NYDFS approval](https://cryptoslate.com/ripples-stablecoin-rlusd-expected-to-launch-on-dec-4-with-nydfs-approval/)
42. [Ripple launches RLUSD stablecoin with global exchange partners | FinTech Magazine](https://fintechmagazine.com/articles/ripple-unveils-rlusd-stablecoin-with-exchange-partners)
43. [Ripple Names Exchange Partners for Stablecoin RLUSD](https://www.pymnts.com/cryptocurrency/2024/ripple-names-exchange-partners-for-us-dollar-denominated-stablecoin-rlusd/)

# 利益披露与免责声明

利益披露：截至发稿前，作者（Peyton）与Ripple、XRPL等主体无任何商业利益关系。

免责声明：本文观点带有主观性，文中可能存在数据和推理上的错误，欢迎批评指正。教程所有内容均不构成投资建议，仅供参考。加密货币相关资风险极高，极容易归零，请在参与时谨慎做出决策，并严格遵守相关法律法规。

# 致谢

特别感谢LYS Lab的联合创始人Matthew为本文提供的信息分享与支持。

# 关于我们

LYS Lab是一支专注于Web3领域投研、教育与交易的创新团队。我们的成员均来自中国大陆顶尖的985高校及Web3行业的精英。欢迎关注我们的官方推特[@LingyueSamaWeb3](https://x.com/LingyueSamaWeb3)和B站账号[@凌岳Sama](https://space.bilibili.com/2062296483?spm_id_from=333.337.0.0)。

![](https://cdn.jsdelivr.net/gh/zey9991/mdpic/LYS%20Lab%E4%BB%8B%E7%BB%8D%E5%88%9D%E7%A8%BF_00.png)