# 2408Witness Chain

## Witness Chain: Unifying DePIN Economies

撰文：Peyton，LYS Lab(X：[@LingyueSamaWeb3](https://x.com/LingyueSamaWeb3))

![LYS Lab品牌形象\_00](https://cdn.jsdelivr.net/gh/zey9991/mdpic/202409301525035.png)

## 结论

* 22年的项目，商业模式是主要2B的，到24年目前只有一个服务OP Rollup的Watchtower是上线了Eigenlayer主网，而且有关经济模型这一块的细节完全未公布。
* 除了节点运营商不推荐参与，特别是提供资金质押这种方式，因为收益存在巨大不确定性。

## 风险

* 项目经济模型细节未公布，收益存在巨大不确定性。
* 项目开发进度不能说快，目前只上线了一个给OP Rollup服务的2B业务，考虑到L2 ZK这一块技术愈发成熟后，OP Rollup的情况本就不容乐观，所以这个业务有没有持续的造血能力还是存疑的。

## 基本面

### 1.团队

团队在丹佛，创始人包括：

* Ranvir Rana 是 Witness Chain 的联合创始人，他于2022年创立了这家公司，凭借他在区块链技术方面的深厚专业知识。Ranvir 在攻读博士学位期间，致力于解决区块链三难困境——即在可扩展性、安全性和去中心化之间取得平衡。这一学术研究为他在去中心化网络领域的职业生涯奠定了基础。在 Witness Chain，他主要负责开发去中心化物理基础设施网络（DePIN）的协调平台，重点将信任系统从数字资产扩展到物理资产。此外，他还参与了 Watchtowers 的创建，旨在增强区块链的安全性。
* Pramod Viswanath 是普林斯顿大学的知名教授，专攻电气与计算机工程。在2022年加入普林斯顿之前，他在无线通信领域做出了重要贡献，包括共同开发了Flash-OFDM技术，该技术成为4G LTE网络的基础。他还深入研究区块链技术，专注于其技术和经济方面。此外，Viswanath 共同创立了区块链初创公司 Kaleidoscope，并撰写了一本广受欢迎的无线通信教科书。
* Himanshu Tyagi 是 Sentient 和 Witness Chain 的联合创始人，也是印度科学研究所的副教授。他拥有马里兰大学的博士学位和印度德里理工学院电气工程硕士学位。Sentient 是一个开源的人工智能开发平台。Sentient 将为贡献者发起“活动”，每个活动都有特定的指标来评估贡献，并根据这些指标给予奖励。

### 2.财务

#### 商业模式 2B

目标客户和收入来源：Optimisitic Rollups项目方+DePIN项目方+开发人员

* Rollup Watchtower网络提出了PoD（勤勉证明）的协议解决Optimisitic Rollups持续监测错误交易的激励问题，提高了Optimisitic Rollups的安全性。
* 另一方面，DePIN协调层（DCL）提供的PoL（位置证明）和PoB（带宽证明）能够给DePIN项目方提供真实的节点位置和网络性能等数据，不过目前这两个服务均未正式上线。
* 除此之外，Witness Chain计划使我们的Rollup Watchtower具备可编程性，以便其他人可以有利地利用它们进行创新应用，如快速finality和跨链桥保险等。

#### 融资信息

Rootdata上未有公开的融资信息，但是从其官网可以看出，Witness Chain 获得了包括Ethereal Ventures，**Polychain Capital**，Robot Vetures，Frontier Capital和dao5的投资。![Screenshot 2024-08-12 222255](https://cdn.jsdelivr.net/gh/zey9991/mdpic/202408122223249.png)

图源：https://www.witnesschain.com/

### 3.经济模型

未公布。

### 4.产品/服务

Witness Chain 是 EigenLayer AVS，将以太坊的安全性带入新的Optimisitic Rollups 和 DePIN 项目。

#### Rollup Watchtower网络（主网阶段）

该服务已在Eigenlayer主网上线。

Rollup Watchtower Network是Witness Chain自主开发，遍布不同地理位置的Watchtowers网络，负责监控optimistic rollups的状态。

Optimistic rollups通过在另一个链上验证交易，并将交易数据公开发布，供任何人查看，从而实现超大规模扩展。如果检测到错误交易，Ethereum验证者可以通过欺诈证明（fraud proof）参与仲裁。因此，当前的前提是，在检测到错误时，验证者会启动欺诈证明，并参与争议解决过程。然而，现有的激励机制只有在错误被发现后才会发挥作用。

但谁会持续监测这些错误交易？当一切正常时，这些参与者如何获得激励来认真执行这项任务？Witness Chain的Watchtower协议就是这些问题的答案。它是一个可编程、信任无关且去中心化的Watchtower服务，利用创新的勤勉证明（Proof-of-Diligence）来激励Watchtowers在正常路径中执行任务。

**Rollup Watchtower网络特点**

* **无需信任（Trustfree）**：通过EigenLayer提供以太坊信任，提供Watchtower的勤勉证明（Proof of Diligence，PoD）。
* **去中心化（Decentralized）**：提供位置证明（Proof of Location），用于验证Watchtower的地理位置并强制执行所需的物理去中心化。
* **可编程（Programmable）**：通过SLA智能合约，随着易受攻击的交易价值的增加，扩展Watchtower的数量/权益及其去中心化属性。

**Rollup Watchtower网络架构**

![Screenshot 2024-08-12 214059](https://cdn.jsdelivr.net/gh/zey9991/mdpic/202408122141693.png)

图源：https://docs.witnesschain.com/rollup-watchtower-network-live/watchtower-protocol/how-it-works

* **质押者（Stakers）**：通过EigenLayer为运营商质押或委托的EigenLayer质押者，为瞭望塔网络提供以太坊的加密经济信任。
*   **运营商（Operators）**：EigenLayer运营商是运行瞭望塔客户端的质押节点运营商池。

    * **瞭望塔（Watchtower）**：WitnessChain瞭望塔是运行瞭望塔客户端软件的节点，它们监视在L1链上断言的状态输出根（由L2提议者断言）与在L2存档节点上获得的状态输出根（通常与瞭望塔客户端在同一台机器上运行）之间的差异。寻求加入瞭望塔网络的节点需要通过 EigenLayer 重新质押（目前没有最低质押数额要求）。Node operator 应该已经是 EigenLayer 的注册和委托的 operator。
    * **L2存档节点（L2 archive nodes）**：节点运营商应安装瞭望塔当前支持的L2链的存档节点。这是计算L2状态的节点，瞭望塔客户端使用它来验证L1上的状态断言。如果希望重复利用一些现有的基础设施或设置，WitnessChain还提供了几种其他配置方案。

    | 配置类型 | L1节点             | L2节点                          |
    | ---- | ---------------- | ----------------------------- |
    | 轻量型  | 使用托管的L1节点RPC提供程序 | 使用Witness Chain提供的L2节点快照来启动节点 |
    | 中等型  | 使用托管的L1节点RPC提供商  | 从公共检查点同步运行L2归档节点              |
    | 完整型  | 运行一个L1完整节点       | 从公共检查点同步运行L2归档节点              |
* **用户/去中心化应用（Users/Dapps）**：利用瞭望塔网络的实时交易跟踪API构建的去中心化应用。

**Rollup Watchtower路线图**

| 主网阶段           |                              |      |
| -------------- | ---------------------------- | ---- |
| 第一阶段（4月11日）    | 运营商白名单和注册                    | 进行中  |
| 第二阶段（4月22-29日） | 提交证明                         | 尚未开始 |
| 第三阶段（4月29日起）   | 聚合商结算（Aggregator Settlement） | 尚未开始 |

数据来源：https://docs.witnesschain.com/rollup-watchtower-network-live/watchtower-protocol/diligence-watchtower-roadmap

这里比较奇怪的是，主网二三阶段理应早就开始了，但是其官方文档中仍然注明尚未开始。

#### DePIN协调层（DCL）

![Screenshot 2024-08-12 201131](https://cdn.jsdelivr.net/gh/zey9991/mdpic/202408122011352.png)

图源：https://docs.witnesschain.com/

从上图可以看出，在DePIN协调层（DCL）下面的组件包括：

* **DePIN链**是DePIN的应用层，其中包含了物理基础设施，并产生了状态信息。
* **EigenLayer的运营商**是运行DePIN挑战者客户端软件的实体。他们在EigenLayer上注册为运营商，允许再质押者（re-stakers）委托给他们，然后选择提供各种服务（AVSs），这些服务都是基于EigenLayer构建的。
* **DCL应用开发者**是在DePIN协调层上构建应用的开发者。
* **DCL证明系统贡献者**是能够帮助构建新的“X的证明”并帮助扩展DePIN协调层所支持的证明系统的贡献者。

而Witness Chain的DePIN协调层（DCL）作为统一层，将DePIN（去中心化物理基础设施网络）网络中未经验证的物理属性转化为可测量、可验证的数字证明。这些证明随后可以被不同的应用程序或DePIN链本身进行验证/质疑和使用，以构建新的产品和服务。

与DCL集成使DePIN链能够利用：

**创建新服务/捆绑优惠**：共享状态信息可以在DePIN资产的基础上促进新服务和产品的开发。DePIN项目可以实现更好的可发现性，启动其经济体系，并获得广泛的金融工具。

**提高资源利用率**：共享状态信息使应用程序能够实时查看整个网络中的可用资源。这种可见性使得任务能够根据资源可用性进行最优分配，从而减少浪费并提高DePIN资产资源利用的效率。

**创新和服务改进**：访问全面的状态信息使提供商能够识别趋势和模式，从而推动创新。应用开发者可以根据共享数据获得的见解来开发新服务或改进现有服务。

具体来看，DCL目前包括两个细分服务：

**位置证明Proof of Location（仍在开发中）**

![image](https://cdn.jsdelivr.net/gh/zey9991/mdpic/202408122013974.png)

图源：https://docs.witnesschain.com/depin-coordination-layer/proof-of-location

位置证明是一种去中心化的“地理位置”证明，可用于验证连接至互联网的“证明者”设备的地理位置。

在去中心化的物理基础设施网络中，信任无关的（trust-free）位置证明对于提供存储、GPU计算、无线连接和能源分配等服务至关重要。这些网络依赖去中心化节点提供关键服务，没有中心化控制，因此信任和验证成为关键挑战。在这种情况下，Witness Chain的信任无关位置证明能提供以下帮助：

1. **增强安全性与防止欺诈**：确保去中心化网络中的节点实际位于其声称的位置，防止虚假位置的欺诈行为。
2. **提高资源分配效率**：在能源、无线网络等场景中，基于验证位置动态分配资源，优化网络性能和访问。
3. **保障操作完整性与法规合规**：帮助网络遵守地区法规，提供不可篡改的审计记录，确保运营的合法性和透明度。
4. **自动化智能合约触发**：基于位置验证自动执行智能合约，实现如能量交易、保险理赔等的自动化和信任无关操作。
5. **增强用户信任**：通过提供可靠的位置信息验证机制，增强用户对去中心化网络的信任，促进用户参与。
6. **支持网络可扩展性**：允许网络在扩展时保持去中心化的完整性和安全性，减少对中央权威的依赖。
7. **优化网络性能**：确保任务和数据在地理上合理分布，降低延迟并提高数据可用性和冗余性。
8. **促进互操作性和灵活参与**：不同物理基础设施能够可靠地报告位置，从而更高效地进行跨部门协作。
9. **确保激励机制公平**：验证参与者的实际位置，确保基于位置的奖励和激励机制公平分配。
10. **实现基于位置的动态定价**：在能源、存储和计算资源等场景中，基于地理需求动态调整价格，优化资源利用。
11. **支持地理围栏与访问控制**：基于位置验证管理服务或资源的访问权限，确保用户或设备在特定位置时才能使用。
12. **加强去中心化验证与治理**：确保社区参与者来自真实位置，支持基于位置的投票权和治理代币分配。
13. **帮助风险评估与缓解**：通过实时位置信息进行更准确的风险评估和运营风险管理，动态调整策略和保费。

在位置证明中，证明者会声明一个地理位置，然后挑战者对其进行验证。位置证明利用互联网延迟来进行地理定位。该协议包括两个步骤：

**校准阶段**

* 该协议包括一个待验证位置的证明者（Prover）和一组位置已知的挑战者（Challengers）
* 在校准阶段，挑战者通过应用层UDP ping测量彼此之间的互联网延迟。
* 然后，挑战者使用这些延迟测量值和其他挑战者的位置来校准延迟与距离之间的映射关系。

**测量阶段**

* 在测量阶段，验证证明者的位置声明。
* 挑战者使用应用层UDP ping测量到证明者的延迟。
* 使用在校准阶段获得的延迟到距离的映射，每个挑战者输出证明者可能存在的区域。
* 协议会汇总不同挑战者的输出，并计算出证明者与其声明位置之间的最大可能距离。

**带宽证明Proof of Bandwidth（仍在开发中）**

又称为回程证明（Proof of Backhaul）。Proof of Backhaul（PoB）协议是在去中心化无线网络兴起、网络性能证明需求增加以及拜占庭容错网络遥测系统需求等背景下被提出的一种创新解决方案。该协议通过去中心化、无信任、高效性和可扩展性等特点和优势，为去中心化无线网络的性能测量和验证提供了有力的支持。

可以让“支付方”（payer）通过一组“挑战者”（challengers）发送的挑战流量，来测定“证明者”（prover）的回程容量（带宽）。

协议工作的流程如下：

1. 每个挑战者确定到证明者的往返时间（RTT）。
2. 挑战协调者（CC）告知每个挑战者何时以及向哪里发送挑战数据。
3. 挑战者发送挑战数据。
4. 证明者计算收到的所有数据的响应哈希，并将其作为响应发送给每个挑战者。
5. 每个挑战者记录开始时间和接收到响应哈希的时间。
6. 证明者将签名的验证数据发送给每个挑战者，挑战者使用这些数据计算传输时间（tt）和其流量接收到的包数量（np）。
7. 挑战者将响应哈希、来自证明者的验证数据（带有证明者签名）、以及其传输时间和包数量（tt, np）与其签名一起转发给挑战协调者。
8. 挑战协调者计算带宽，并将所有数据（挑战者列表及其响应）发布到链上。
9. 验证数据后，PoB合约终止，托管中的代币分配给挑战者。

### 5.技术

Witness Chain每个产品/服务背后都是有学术论文支撑的。

![Screenshot 2024-08-12 224725](https://cdn.jsdelivr.net/gh/zey9991/mdpic/202408122247749.png)

图源：https://docs.witnesschain.com/resources/technical-papers

目前，团队已发表了**Proof of Backhaul**，**Proof of Location**，**Proof of Diligence**和**Proof of Service**共计四篇论文。

### 6.关键数据

2024年8月12日数据：

* TVL：1.93M ETH rank 5/16
* （再）质押者总数：40709 rank 10/16
* 节点运营商总数：84 rank 4/16
* 推特粉丝数：28.7K
* 融资信息：未公布，但参投机构包括Polychain等

## 参与机会

\*\*奖励说明：\*\*目前仅Eigenlayer节点运营商有参与机会，对其他群体而言除了参与质押没有其他参与方式，而且经济模型等细节完全未公开，甚至质押的积分也是没有计算方式，贸然参与不确定性较大，不推荐现阶段参与。

交互方式：类似于eOracle，首先质押资金进入Eigenlayer，然后在AVS项目中选择质押

## 参考文献

1. [Witness Chain Watchtowers](https://www.witnesschain.com/)
2. [Introduction to Witness Chain | Witness Chain](https://docs.witnesschain.com/)
3. https://app.eigenlayer.xyz/avs/0xd25c2c5802198cb8541987b73a8db4c9bcae5cc7
4. https://www.rootdata.com/Projects/detail/Witness%20Chain?k=OTA3MA%3D%3D

## 利益披露与免责声明

利益披露：截止发稿前，作者（Peyton）与Witness Chain无任何商业利益行为。

免责声明：教程所有内容均不构成投资建议，仅供参考。加密货币相关资风险极高，极容易归零，请在参与时谨慎做出决策，并严格遵守相关法律法规。

![](https://cdn.jsdelivr.net/gh/zey9991/mdpic/202408092049535.jpg)

> \[!NOTE]
>
> _本报告正文部分最后编辑于2024年8月12日_
