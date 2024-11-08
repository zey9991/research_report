# Symbiotic实操向研报 LYS Lab出品 @Peyton

> [!NOTE]
>
> ***本报告正文部分最后编辑于2024年7月25日***

![](https://cdn.jsdelivr.net/gh/zey9991/mdpic/202409301525035.png)

# 结论

- 推荐未参与Eigenlayer空投的可以继续参与，Symbiotic是Eigenlayer的主要竞品
- 推荐大资金/精品号充分利用资金一鱼多吃，小资金有限度参与博低保
- 质押资产时推荐未发币项目或者已发币但有积分奖励的项目



# 风险

- Symbiotic代币经济学具体细节未公布
- 一鱼多吃时策略的智能合约等风险将增加，是否愿意承担需要自行衡量



# 基本面

## 产品

Symbiotic 是一个无需许可的共享安全协议。共享安全（Shared security）指的是多个网络可以共享同一组节点运营商的服务和安全保障，从而提高资本效率和安全性。该概念此前已经在 EigenLayer 再质押中得到应用。

![](https://cdn.jsdelivr.net/gh/zey9991/mdpic/202408091346278.png)

### 与Eigenlayer的对比

与EiegnLayer 不同的是，Symbiotic 允许用户质押的代币范围更广泛，包括 ERC20 代币和稳定币（例如\$ENA和\$sUSDe）、以太坊验证者提款凭证，或是流动性提供证明等。

此外，Symbiotic 提供了更灵活的组件定制选项。虽然核心协议部分由不可变的核心合约定义，但其他组件（例如质押资产、奖励机制和处罚标准等）可以由网络或其他代理根据需要进行配置。

而且，Symbiotic目前没有原生再质押功能，也没有委托（节点运营商）的功能。

更多的对比细节可以在此文中找到：https://new.qq.com/rain/a/20240710A03IWI00

### Symbiotic 架构

Symbiotic 被设计为一个极其灵活、无许可且可靠的轻量协调层（thin coordination layer），目的在于简化系统架构并减少操作成本，同时确保网络能够高效处理交易和执行协议。根据 Symbiotic文档，Symbiotic 网络架构由五个核心组件构成，它们相互协作以维护和提升去中心化网络的安全性和效率。

![](https://cdn.jsdelivr.net/gh/zey9991/mdpic/202408091401317.png)



**1）Collateral**

**角色**：在 Symbiotic 中保障经济安全

**功能**：在 Symbiotic 系统中，用户可以质押的代币是一个更广泛的概念，涵盖了各种链上资产，例如 ERC20 代币、以太坊验证者提款凭证，或是流动性提供证明等。用户可将这些资产进行质押并转换成特定的质押代币，这些代币具备扩展功能，能够在必要时用于处罚或赔偿。

**2）Valuts**

**角色**：协调和管理质押和再质押过程

**功能**：Symbiotic 协议中用于连接质押资产持有者和运营网络基础设施的 Operators（运营商）的桥梁。用户质押转换成的质押代币将会被存放在 Vaults 中，Vaults 负责将这些代币委托给网络中的运营商，支持网络运行。此外，由于 Vaults 是可配置的，因此可以通过多种方式部署以满足不同的需求和安全考量。例如，完全不可更改的预配置 Vaults （Immutable Pre-Configured Vaults）可以为那些需要高度稳定性和安全保障的应用提供服务，而多运营商服务策展 Vaults（Curated Multi-Operator Vaults）则可以集中管理多个运营商的资金和策略，提供定制化的服务。

**3）Operators**

**角色**：Symbiotic 生态系统内的基础设施提供者

**功能：**通过从 Vaults 获得质押代币，Operators 可以确保对网络安全和运营获得必要的经济支持。Symbiotic 创建了一个注册表来记录和追踪 Operators 的表现。值得注意的是，Operators 可以通过 Vaults 从多个合作伙伴处获得经济支持，而无需为每个合作伙伴单独构建或维护独立的基础设施。未来，Symbiotic 还计划引入更多的验证和评价系统，使 Network 能够根据 Operators 的声誉和历史表现进行选择。

**4）Resolvers**

**角色**：在生态系统中充当仲裁者，负责裁决和处理网络中发生的作恶行为所引发的经济处罚，可以是实体也可以是合约

**功能**：具体实现方式分为两种，一种是完全自动化的方式，适用于那些可以明确证明的作恶行为。第二种则是采取更复杂的形式，比如成立委员会或引入外部争议解决框架。Vaults 和 Network 可以共同选择适合的 Resolvers 类型。Vaults 还有权制定如何处理质押代币的 Resolvers 具体条款。此外，Resolvers 还可跨网络共享，允许多个网络采用同一 Resolvers 机制处理潜在的争议。

**5）Network**

**角色**：依赖去中心化基础设施来提供服务的各种协议或平台

**功能**：Symbiotic 允许这些 Network 通过灵活的方式获取所需的安全保障，包括运营商的技术服务和经济支持。这些 Netwrok 则可以通过 Symbiotic 的模块化设计自定义招募和管理节点运营商的策略、自主选择合作的 Vaults 等。此外，Symbiotic 提供的核心合约是开源且不可更改的，确保了网络运行的安全性和稳定性，无需担心外部治理风险。



总体来看，在Symbiotic 协议中，用户首先会将其质押资产转化为 Collateral，并被存入 Vaults，而 Vaults 根据设定的策略将这些代币委托给 Operators，为网络的运作提供必要的经济资源。Operators 则根据这些策略执行网络任务，例如数据处理及交易验证等。同时，Resolvers 在系统中扮演关键的仲裁角色，负责处理 Operators 行为可能引发的任何经济处罚问题。 而作为最终的服务提供者，Network 则负责定义和调整与 Vault 和 Operators 的交互规则，包括如何接受质押、如何分配奖励和如何应对处罚。

### Symbiotic 优势

- 模块化带来的灵活性

网络可以控制其（再）质押（restaking）实施的所有方面，包括支持的抵押资产、节点运营者选择机制、奖励、惩罚机制以及相关的解决机制。所有参与者都可以灵活地选择加入或退出通过 Symbiotic 协调的共享安全安排。

- 通过不可变性实现风险最小化

以太坊上不可升级的核心合约消除了外部治理风险和单点故障。我们简单而灵活的合约设计最大限度地减少了执行层风险。

- 通过再质押的抵押品和基于声誉的策划实现资本效率

无许可、多资产和网络无关的设计使得经济安全的获取具有可扩展性和资本效率。一个以运营商为中心、跨网络的声誉系统正在不断演进，这将进一步提高网络构建者的资本效率。



### Symbiotic 生态

目前，Symbiotic 已经与 16 个项目建立了合作伙伴关系，包括 USDe 开发商 Ethena、跨链应用构建平台 Hyperlane、预言机网络 Ojo、正在构建可验证的人工智能网络的 Aizel 及全链账本协议 Cycle Network 等。其中，Ethena正在将 Symbiotic 与 LayerZero 的去中心化验证网络（DVN）框架集成，以实现 Ethena 资产的跨链安全性；全链账本协议Cycle Network计划使用 Symbiotic 为其共享定序器提供动力；Celestia 旗下模块化 Rollup 框架产品Rollkit正在探索将 Symbiotic 再质押集成至其模块化堆栈中，以促进在 Celestia 上启动主权 Rollup。

![](https://cdn.jsdelivr.net/gh/zey9991/mdpic/202408091348270.png)

###  Symbiotic 数据

日期：2024年7月24日

- TVL  \$ETH36.89k≈\$1.272b 仅次于Eigenlayer

竞品数据：

EigenLayer (\$16.648b)

Karak (\$1.032b)

Mind Network (\$2.15m)

Solayer (\$152.46m)

Pell Network (\$128.47m)

Parasail (\$62.84m)

Allstake (\$14.78m)

Octopus Network (\$3.13m)

Binlayer (\$151.36)

- TVL 增长趋势

![](https://cdn.jsdelivr.net/gh/zey9991/mdpic/202408091355859.png)

来源：https://defillama.com/protocol/symbiotic?denomination=ETH

- TVL Token 组成 主要是wstETH

![](https://cdn.jsdelivr.net/gh/zey9991/mdpic/202408091348673.png)

来源：https://defillama.com/protocol/symbiotic?denomination=USD

- 独立再质押者总数393.19K
- 独立再质押者总数增长趋势

![](https://cdn.jsdelivr.net/gh/zey9991/mdpic/202408091348024.png)

来源：https://dune.com/pyor_xyz/symbiotic



## 团队

Misha Putiatin是Symbiotic的联合创始人兼首席执行官，区块链安全审计公司Statemind的首席执行官，之前是区块链解决方案咨询公司MixBytes的首席执行官。他毕业于国家电子技术研究所。俄国人。

Algys Ievlev是Symbiotic的联合创始人，也是区块链安全审计公司Statemind的创始人和审计主管。他之前是区块链解决方案咨询公司MixBytes的首席技术官。他毕业于莫斯科鲍曼国立技术大学。俄国人。

pseudo是Symbiotic的策略主管，之前是Variant Fund的投资合伙人，也曾在Scroll工作过。



## 融资

![](https://cdn.jsdelivr.net/gh/zey9991/mdpic/202408091349536.png)

种子轮融资\$580万，领投机构为Paradigm和cyber Fund。

据几位知情人士透露，Paradigm 曾向 EigenLayer 联创 Sreeram Kannan 表达过投资意愿，但遭到拒绝。而后 EigenLayer 选择了从 a16z 处[筹集](https://www.bloomberg.com/news/articles/2024-02-22/andreessen-invests-100-million-in-crypto-startup-eigenlayer)了 1 亿美元资金。对此，Paradigm 则表示将会投资 EigenLayer 的竞争对手项目。而cyber Fund的两位创始合伙人Vasiliy Shapovalov和Konstantin Lomashuk都是流动性聚合协议Lido的创始成员，也即Symbiotic项目实质上获得了Lido的支持。



## 经济模型

官网及白皮书暂未公布具体细节。因此需要注意反撸风险。



# 参与机会

## Symbiotic官网直接质押

**奖励说明：**仅获得Symbiotic积分，不推荐小资金参与。大部分代币质押上限已满，需要等待项目方进一步提升上限。

**交互教程：**进入官网https://app.symbiotic.fi/restake，点选要质押的资产进行质押即可，目前主网支持的资产包括wstETH，cbETH，wBETH，sUSDE，rETH，mETH，ENA，swETH（Swell未发币），sfrxETH和ETHx，其中仅cbETH池子目前未达上限。

![](https://cdn.jsdelivr.net/gh/zey9991/mdpic/202408091355470.png)



## Swell+Ether.fi+Symbiotic+Veda(+Fuel)一鱼四（五）吃

**奖励说明：**享受资产质押本身的年化收益同时，可以获得3倍的etherfi积分、1倍的Symbiotic积分、3倍的Veda积分，同时因为Swell未发币，可以博预期空投。同时，再质押获得的weETH也可以获取1.5倍的Fuel积分，具体参与方式在后面说明。

Swell网络是一个非托管的流动性ETH质押协议，为质押者、节点Operators和以太坊生态系统构建。用户可以质押ETH以获得swETH并获得DeFi收益。据Defilama数据，Swell协议的TVL为\$421.11m，在Restaking协议中排名为7/20。

Veda是协议和应用程序的原生收益基础设施。用户将资产存入Veda的合约中，然后Veda通过DeFi协议安全地部署这些资金。Veda的使命是通过透明和可获得的产量实现加密的大规模采用。Stephanie Vaughan是Veda的联合创始人和首席运营官，也是Seven Seas Capital的联合创始人和管理合伙人。此前，她是Sommelier的运营主管。她毕业于美国海军学院，并持有哥伦比亚大学工商管理硕士学位。

![](https://cdn.jsdelivr.net/gh/zey9991/mdpic/202408091355771.png)

**交互教程：**（主要参考https://x.com/MetaHunter168/status/1813112684432486500）

1.进入Swell官网：[https://app.Swellnetwork.io/stake](https://app.swellnetwork.io/stake)，选择stake，先把以太主网的ETH质押到Swell，兑换成swETH（记得要留点gas备用）

![](https://cdn.jsdelivr.net/gh/zey9991/mdpic/202408091355971.jpeg)

2.点击etherfi网站：https://app.ether.fi/liquid ，首页上方选择liquid，点击Super Symbiotic LRT，进入质押池。

![](https://cdn.jsdelivr.net/gh/zey9991/mdpic/202408091355706.jpeg)

3.点击Deposit 质押，记得选择swETH质押代币。选择好后就可以进行质押了。

![](https://cdn.jsdelivr.net/gh/zey9991/mdpic/202408091355696.jpeg)

![](https://cdn.jsdelivr.net/gh/zey9991/mdpic/202408091356499.png)



## (Lido+)Renzo+Mellow+Symbiotic+Fuel一鱼四（五）吃

**奖励说明：**获得1.5倍的ezPoints，1倍的Mellow积分，1倍的Symbiotic积分和2倍的Fuel积分。由于Renzo的池子可以质押(w)stETH，还可以把先质押主网的ETH进入Lido获取stETH，进一步获取Lido提供的APR收益。

Mellow Protocol是一种模块化的流动性再质押协议，适用于机构和复杂的风险管理者，用于发行和管理具有不同风险和收益特征的LRT。该系统允许无需许可的LRT创建，通过与不同的avse和Operators合作，允许无限的风险概况。Rootdata数据显示其种子轮融资为\$2.75M，领投方为Robot Ventures\*, Arrington Capital\*, ParaFi Capital\*

Fuel是一个专门为以太坊Rollups构建的操作系统。Fuel结合了几个创新功能，以便在不做任何妥协的情况下为以太坊生态系统带来新的功能。燃料Rollups将具有并行化和状态最小化的执行，并设计用于跨链互操作性以及原生帐户抽象和对所有网络钱包的支持。Fuel旨在通过结合专门构建的虚拟机FuelVM，高度优化的基于rust的区块链编程语言Swayalong以及完全集成的工具链Forc和几种服务来为以太坊创建完整的rollup空间，从而改变以太坊的Rollup空间。Fuel独特的架构将允许开发人员构建以太坊生态系统中从未见过的体验。RootData数据显示其融资总额达到了\$81.5M，领投方包括Blockchain Capital\*, Stratos\*和CoinFund*

**交互教程：**

1.先进入Renzo官网https://app.renzoprotocol.com/discover点击pzETH池子参与质押

![](https://cdn.jsdelivr.net/gh/zey9991/mdpic/202408091350408.png)

2.选择要质押的代币，可选(w)stETH和(w)ETH

![](https://cdn.jsdelivr.net/gh/zey9991/mdpic/202408091350138.png)

3.如果需要stETH，可以前去Lido官网https://stake.lido.fi/质押以太坊主网的ETH

![](https://cdn.jsdelivr.net/gh/zey9991/mdpic/202408091356204.png)

4.质押成功后获得pzETH（积分每日刷新需要等待），跳转Fuel活动官网https://app.fuel.network/earn-points/deposit/，并选择pzETH进行质押（积分同样24小时刷新）

![](https://cdn.jsdelivr.net/gh/zey9991/mdpic/202408091356404.png)

![](https://cdn.jsdelivr.net/gh/zey9991/mdpic/202408091356911.png)

根据Fuel项目方FAQ的说明，7月22日到8月2日质押pzETH的为2倍积分。

注意：如果前面选择了Swell+Ether.fi的模式，获得的weETH也可以参与Fuel的积分活动，但是只有1.5倍积分。

![](https://cdn.jsdelivr.net/gh/zey9991/mdpic/202408091356322.png)

# 参考文献

https://blog.symbiotic.fi/symbiotic-intro/

https://blog.symbiotic.fi/more-than-restaking/

https://docs.symbiotic.fi/

https://x.com/Ice_Frog666666/status/1802299249964863821

https://x.com/Ice_Frog666666/status/1806994377400897826

https://viewdao.mirror.xyz/OPbOZHhZLaSaxfmeTbMBfkkeRa95FJDN3b6epuq0-KA

https://x.com/MetaHunter168/status/1813112684432486500

https://www.youtube.com/watch?v=mJAqS3uCf9U&t=215s

https://dune.com/pyor_xyz/symbiotic

https://defillama.com/protocol/symbiotic?denomination=ETH

https://www.rootdata.com/Projects/detail/Symbiotic?k=MTI4MDM%3D

https://new.qq.com/rain/a/20240710A03IWI00

# 利益披露与免责声明

利益披露：截至发稿前，作者（Peyton）与 eOracle无任何商业利益行为。

免责声明：教程所有内容均不构成投资建议，仅供参考。加密货币相关资风险极高，极容易归零，请在参与时谨慎做出决策，并严格遵守相关法律法规。

![](https://cdn.jsdelivr.net/gh/zey9991/mdpic/LYS%20Lab%E4%BB%8B%E7%BB%8D%E5%88%9D%E7%A8%BF_09.png)
