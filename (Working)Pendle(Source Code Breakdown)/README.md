请首先介绍SYBase.sol的主要功能，然后为每行源码的上方加上代码注释：

请依次完成如下步骤：
1.介绍此合约的主要功能
2.如果有定义状态变量，则将合约中所有状态变量按照名称、参数类型做成一个表格呈现
3.如果有定义事件，则将合约中所有事件按照名称、参数、indexed变量做成一个表格呈现，其中参数以及indexed变量写完一个之后都需要换行
4.将合约的所有函数的名称、输入输出、主要功能做成一个表格呈现，而且在输入输出中按照格式“参数名称: 参数类型”呈现，写完一个之后都需要换行。
---以下是合约源码：

## 协议架构

![High Level Architecture](https://docs.pendle.finance/assets/images/high_level_architecture-457bcdd55f399a2d90b8c7bd9e2b6a09.png)

**PendleRouter**
PendleRouter 合约是用户将直接交互的合约，用于将调用者对不同的 SY、PT、YT 和市场的操作聚合在一起。它没有与其交互的任何合约的特殊权限或白名单。因此，任何第三方协议都可以自由地将该 Router 的逻辑嵌入其代码中，以提高 gas 效率。

**Standardized Yield (SY)**

SY 是一种利息生成代币（ibToken）的包装版本，也可以质押到其他协议中以赚取更多利息。在 Pendle 系统中，SY 代替 ibToken 用于所有操作，包括在 Pendle 市场上交易或铸造本金代币（PT）和收益代币（YT）。

**Principal Token (PT)**

是本金代币的合约。铸造和销毁的所有逻辑都在 PendleYieldToken 中实现。

**Yield Token (YT)**

是收益代币的合约，包含了从 SY 中铸造和赎回 YT（收益代币）和 PT（本金代币）的逻辑，以及分配给用户收益（利息和奖励代币）的逻辑。

**PendleMarket（简称Market）**
合约允许用户在 PT 和其对应的 SY 之间进行交易，同时允许正常的流动性提供。交换费用直接复利到 LP 中。每个市场都有自己的几何平均数预言机，类似于 UniswapV3。

目前没有交易 YT 的市场，但可以通过以下算法进行交易：

- SY ➝ YT = 闪电交换 SY，铸造 PT 和 YT，归还 PT，发送 YT 给用户。
- YT ➝ SY = 闪电交换 PT，使用 PT 和 YT，赎回 SY，归还，发送多余部分给用户。

**PendleGauge**
向市场 LP 持有者分发 PENDLE 和其他由 SY 生成的奖励。每个 Gauge 直接嵌入到相应的市场中，因此不需要质押 LP 即可获得这些奖励。奖励可以随时赎回。

奖励的分发不是基于 LP 持有量，而是基于 activeBalance（活跃余额）。activeBalance 的计算公式如下：
$$
activeBalance = min(userLpBalance, userBoostedBalance)\\
userBoostedBalance = 0.4 * userLpBalance + 0.6 * totalLpSupply * \frac{userVePendleBalance}{totalVePendleSupply}
$$
**VotingController**
允许用户利用他们的 vePENDLE 为市场投票。这个投票过程决定了每个市场将在接下来的周期中获得多少 PENDLE。每个周期持续一周，从周四 UTC 时间 0:00 开始，到下周四同一时间结束。在周期内，用户可以根据需要更改投票，但投票结果将在周期结束时最终确定。

**GaugeController**
接收 VotingController 的投票结果，并相应地向各个 Gauge 分配 PENDLE。每个周期的 PENDLE 不是一次性分发的，而是每秒分发一次，贯穿整个周期。

**vePENDLE**
合约允许用户锁定他们的 PENDLE 以获得 vePENDLE。每个用户的仓位由一对数值表示：（数量，过期时间）。过期后，用户可以从合约中提取其锁定的 PENDLE。用户的 vePENDLE 余额将每周递减，直到过期时变为零。

**MarketFactory** 

用于创建新 PendleMarket 的工厂合约。

**YieldContractFactory** 

用于创建新 PendleYieldToken 和 PendlePrincipalToken 合约的工厂合约。它还负责跟踪所有已创建的收益合约，并收取费用。`createYieldContract` 是核心函数，用于创建新的收益合约对，所需输入包括 SY 和到期时间。

## 源码解析

![image-20241024211030306](https://cdn.jsdelivr.net/gh/zey9991/mdpic/image-20241024211030306.png)

[pendle-core-v2-public/contracts at main · pendle-finance/pendle-core-v2-public](https://github.com/pendle-finance/pendle-core-v2-public/tree/main/contracts)

### core合约

![image-20241024211313513](https://cdn.jsdelivr.net/gh/zey9991/mdpic/image-20241024211313513.png)

[pendle-core-v2-public/contracts/core at main · pendle-finance/pendle-core-v2-public](https://github.com/pendle-finance/pendle-core-v2-public/tree/main/contracts/core)

#### SYBase.sol

`SYBase` 合约为 Pendle 提供的基础逻辑，用于实现标准化收益代币（Standardized Yield Token，SCY）。它包含了用于 SCY 的铸造和赎回的核心逻辑。合约支持接收基础代币进行存入和赎回，同时支持收益代币的铸造和销毁。该合约还包含与奖励相关的逻辑。

**状态变量**

- `yieldToken`：收益代币的地址，是一个不可变的变量，在合约构造时设定。

**事件**

- `Deposit`：当用户存入基础代币并铸造 SCY 时触发。
- `Redeem`：当用户赎回 SCY 并提取基础代币时触发。

**函数**

![image-20241024222426877](https://cdn.jsdelivr.net/gh/zey9991/mdpic/image-20241024222426877.png)

#### SYBaseUpg.sol

`SYBaseUpg.sol` 是一个抽象合约，主要用于管理基于收益代币的存取款操作，提供了一系列标准化的收益操作方法。它继承了多个合约，包括 `IStandardizedYield` 接口、`PendleERC20PermitUpg`、`TokenHelper`、`BoringOwnableUpgradeable` 和 `Pausable`，从而具备了收益计算、权限控制、暂停功能等能力。

状态变量：

1. `yieldToken`：存储了收益代币的地址，是不可变的（`immutable`）。
2. `__gap`：一个长度为100的`uint256`数组，用于占位，确保合约在未来升级时保持存储结构的稳定性。

事件：

合约没有直接声明的事件，但继承的接口 `IStandardizedYield` 中包含的事件应该包括 `Deposit` 和 `Redeem`，这些事件会在存款和赎回时触发。





### oracles合约

[pendle-core-v2-public/contracts/oracles at main · pendle-finance/pendle-core-v2-public](https://github.com/pendle-finance/pendle-core-v2-public/tree/main/contracts/oracles)

### router合约

[pendle-core-v2-public/contracts/router at main · pendle-finance/pendle-core-v2-public](https://github.com/pendle-finance/pendle-core-v2-public/tree/main/contracts/router)

### limit合约

[pendle-core-v2-public/contracts/limit at main · pendle-finance/pendle-core-v2-public](https://github.com/pendle-finance/pendle-core-v2-public/tree/main/contracts/limit)

### LiquidityMining合约

[pendle-core-v2-public/contracts/LiquidityMining at main · pendle-finance/pendle-core-v2-public](https://github.com/pendle-finance/pendle-core-v2-public/tree/main/contracts/LiquidityMining)

## 参考文献

[pendle-finance/pendle-core-v2-public](https://github.com/pendle-finance/pendle-core-v2-public)

[pendle-core-v2-public/audits/Ackee/Ackee-Part 1.pdf at main · pendle-finance/pendle-core-v2-public](https://github.com/pendle-finance/pendle-core-v2-public/blob/main/audits/Ackee/Ackee-Part 1.pdf)

[pendle-core-v2-public/audits/ChainSecurity.pdf at main · pendle-finance/pendle-core-v2-public](https://github.com/pendle-finance/pendle-core-v2-public/blob/main/audits/ChainSecurity.pdf)