



# 链上分析必点技能：API调用简明教程

撰文：Peyton（X：[@0xPeyton404](https://x.com/0xPeyton404)，[@WHU_web3](https://x.com/WHU_web3)，[@LingyueSamaWeb3](https://x.com/LingyueSamaWeb3)）

# 笔者注

1. 这是一个**偏数据分析的小白实操向教程**，对**资深开发者**可能帮助不大。**推荐有需要的读者跟着本文一起实现简单的调用**。
2. 请小白读者不要迷失在各种花哨的术语中，在本文中遇到暂时不理解的术语也没有任何关系，这不影响你继续。
3. 希望本文对你有所帮助，也欢迎反馈！

# 前置要求

1. 能够运用科学上网工具访问外网。
2. 本文的具体实现例子涉及到Python程序，实操建议安装Python并配置环境，但不安装也不会影响理解。

# 学习目标

基础目标：

- 了解API的概念；
- 熟悉调用API的一般步骤。

进阶目标：

- 了解**API**与**ABI**，**RPC**之间的区别；
- 能够仿照案例自主实现**Dune平台的API调用**。

# 为什么要用API？

很多区块链数据平台，比如DeFilama，Tokenterminal或者Dune，都有现成的图表等等可视化，甚至有些支持直接下载原始数据，那为什么还要学习调用API呢？不是多此一举吗？下面是笔者提供的几个理由：

**数据**：有一些数据平台，如DeFiLlama，可以直接下载原始数据，这很好。但也有一些数据平台，如Dune，虽然提供原始数据下载选项，但是要求会员才能使用，但是普通用户有免费API使用额度，从而让使用API成为直接和灵活地获取数据的必要手段。**因此，本文的重点也是教会各位读者如何实现Dune API的调用**。

![](https://cdn.jsdelivr.net/gh/zey9991/mdpic/%E5%9B%BE%E7%89%872.png)

**分析**：访问原始数据可以让你进行自己的分析，超出预制图表所能显示的范围。你可以合并数据集、应用特定指标或计算自定义比率，以获得独特的见解。

**自动化**：通过API调用，你可以自动化数据检索，创建动态仪表板或报告，这些仪表板或报告会自动更新，非常适合跟踪实时趋势。不过本文不涉及此内容。

**集成**：API数据可以直接集成到你自己的系统中，无论是网页应用、移动应用还是电子表格，这让你能够控制数据的呈现方式和用途。不过本文不涉及此内容。

# 什么是API？

## 从抽象思维说起

抽象思维使得我们能分别从逻辑视角和物理视角来看待问题及其解决方案。举一个常见的例子：

试想大家每天开车上学或上班。作为司机——车的使用者，我们在驾驶时会通过与车的一系列交互到达目的地：坐进车里，插入钥匙，启动发动机，换挡，刹车，加速以及操作方向盘。从抽象的角度来看，这是从逻辑视角来看待这辆车。我们使用汽车设计者提供的功能进行通勤。这些功能也被称作**接口**。

而修车工看待车辆的视角与司机截然不同。他不仅需要知道如何驾驶，而且需要知道实现汽车功能的所有细节：发动机如何工作，变速器如何换挡，如何控制温度，等等。这就是所谓的**物理**视角，即**看到表面之下的具体实现细节**。

使用计算机也是同理。**大多数人不需要了解计算机的实现细节就能写文档、收发邮件、浏览网页、听音乐、存储图像以及打游戏。大家都是从逻辑视角或者使用者的角度来看待计算机。** 计算机科学家、程序员、技术支持人员以及系统管理员则从另一个角度来看待计算机。他们必须知道操作系统的原理、网络协议的配置，以及如何编写各种脚本来控制计算机。他们必须能够控制用户不需要了解的底层细节。

上面两个例子的共同点在于，**用户(或称客户)只需要知道接口是如何工作的，而并不需要知道实现细节。这些接口是用户用于与底层复杂的实现进行交互的方式。**

 下面是抽象的另一个例子：Python的math模块。一旦导入这一模块，我们便可以进行如下的计算：

```py
import math
math.sqrt(16)
```

这是一个**过程抽象**的例子。我们并不需要知道平方根究竟是如何计算出来的，而只需要知道计算平方根的函数名是什么以及如何使用它。只要正确地导入模块，便可以认为这个函数会返回正确的结果。由于其他人已经实现了平方根问题的解决方案，因此我们只需要知道如何使用该函数即可。**这有时候也被称为过程的“黑盒”视角。我们仅需要描述接口：函数名、所需参数，以及返回内容。所有的计算细节都被隐藏了起来。**

<img src="https://cdn.jsdelivr.net/gh/zey9991/mdpic/image-20241108214440669.png" alt="过程抽象" style="zoom:50%;" />

## 应用程序接口

在计算机科学中，**应用程序接口**（API，Application Programming Interface）与前文提到的**接口**概念有所不同。虽然两者都是连接不同事物的“桥梁”，但API的“接口”侧重于软件系统之间的交互，专门供程序化调用。加上“应用程序”一词后，API的范围被限定在应用程序或服务之间的通信，而不仅仅是用户与系统交互的通用接口。API通过一组功能和操作，允许应用程序之间共享数据、完成任务，无需直接涉及底层细节。

### 例子：天气应用与天气API的交互

想象一下你正在设计一个天气应用，你希望这个应用可以实时显示用户所在地的天气信息：温度、湿度、天气描述等等。为了实现这个目标，你有两种选择。

**方案一**是自己动手，采集所有需要的数据。具体而言，你可能需要安装数十个天气传感器来监测不同地理位置的天气，并开发出复杂的算法来处理温度、湿度和气压等数据。你还需要定期维护这些设备，确保数据采集无误。显然，这样做的代价高昂且耗费时间。

**方案二**，也是更常见、更高效的做法，就是使用一个现成的天气API。比如，**OpenWeather API** 就是一个能够提供全球天气数据的公共接口。通过这个API，你的应用可以发送一个请求来查询某个城市的天气情况。API提供商会在后台处理数据，并返回你所需要的信息。

让我们来看这个流程如何展开：

1. **向API发送请求**：你的天气应用可以向OpenWeather API发送一个HTTP请求，指定要查询的城市。例如，如果用户在北京，应用会向以下URL发送请求：

   ```
   https://api.openweathermap.org/data/2.5/weather?q=Beijing&appid=YOUR_API_KEY
   ```

   其中，`q=Beijing`表示查询的城市是北京，而`appid=YOUR_API_KEY`是你的API密钥，用于验证你的应用的身份。这相当于向API服务发出一条“获取北京天气”的指令。

2. **API响应数据**：API接收到请求后，会查询自己的数据库，然后返回一段**JSON格式**的数据。假设API返回的数据如下：

   ```json
   {
     "weather": [
       { "description": "clear sky" }
     ],
     "main": {
       "temp": 15.0,
       "humidity": 72
     }
   }
   ```

3. **处理响应并显示**：应用接收到数据后，就可以提取其中的字段。比如，“`weather[0].description`”描述了天气状况为“clear sky”（晴空），`main.temp`给出温度为15摄氏度，`main.humidity`显示湿度为72%。然后，你的应用会将这些信息显示在用户界面上。用户看到的只是数据结果，而无需了解这些数据的来源或处理过程。

不妨把API想象成一个**外卖配送系统**。你的天气应用就是顾客，而OpenWeather API是外卖平台。作为顾客，你只需在平台上下单，而不用知道平台如何和餐厅沟通，或者送餐员如何选择最快的路线。这种透明化的流程正是API的设计目的：**隐藏复杂性，提供简洁易用的服务**。

### 什么是URL？

URL（Uniform Resource Locator，统一资源定位符）是我们在互联网上查找和访问资源（如网页、图像、视频或API）的地址。它就像是每个网站或服务的“家地址”，告诉浏览器或应用在哪里找到特定的信息。

URL由几个部分组成：

- **协议**（如HTTP、HTTPS）：指示如何访问资源。
- **主机名**（如www.example.com）：网站的服务器地址。
- **路径**（如/contacts）：资源在服务器上的位置。
- **查询字符串**（如?q=search）：用来传递额外参数。

例如，`https://api.openweathermap.org/data/2.5/weather?q=Beijing&appid=YOUR_API_KEY`是一个访问天气数据的URL，其中包含了查询城市和API密钥的参数。

### 什么是HTTP请求？

在使用天气API获取数据时，API通过一种叫做**HTTP请求**的方式接收和发送数据。这种请求就像一封信，里面包含了你希望API完成的指令。

**HTTP**（HyperText Transfer Protocol，超文本传输协议）是互联网上用来发送和接收数据的主要协议。可以把它想象成一种“网络语言”，让不同的计算机可以相互交流。在API场景中，HTTP请求常用于发送特定指令并接收数据，比如获取天气信息。

在我们的天气应用中，当我们需要查询某个城市的天气时，应用会发送一个**HTTP GET请求**。GET请求是一种特定类型的HTTP请求，用于向API“索取”数据。就像在餐厅点菜一样，你说出你想要的菜品，服务员就会去帮你准备。通过HTTP GET请求，我们可以向API“索取”一个城市的天气信息，而API会根据请求内容返回相应的数据。

在我们的例子中，请求的格式可能是这样的：

```
https://api.openweathermap.org/data/2.5/weather?q=Beijing&appid=YOUR_API_KEY
```

其中的`https://api.openweathermap.org` 是API的基本地址，类似于邮寄地址。

### 什么是JSON格式？

当API收到我们的请求并处理完毕后，会将结果“打包”成一种称为**JSON**（JavaScript Object Notation，JavaScript对象表示法）的格式发送回来。可以将JSON想象成一个井井有条的包裹，里面放着我们点的菜品：温度、湿度、天气描述等。JSON格式的结构简单，易于人和机器理解，因而广泛用于Web开发和API数据传输。

在天气应用中，API可能返回以下的JSON数据：

```json
{
  "weather": [
    { "description": "clear sky" }
  ],
  "main": {
    "temp": 15.0,
    "humidity": 72
  }
}
```

这里的JSON数据包含多个**键值对**（key-value pairs），每个键表示数据的名称（比如`"temp"`表示温度），每个值对应实际数据（比如`15.0`摄氏度）。这些数据会由天气应用解析和展示。

JSON的语法格式也是非常简单的，可以简单了解一下：

- 数据在**名称/值**对中
- 数据由逗号 **,** 分隔
- 使用斜杆 \\ 来转义字符
- 大括号 **{}** 保存对象
- 中括号 **[]** 保存数组，数组可以包含多个对象

## API，ABI与RPC

|          | **API**                                 | **ABI**                                              | **RPC**                              |
| -------- | --------------------------------------- | ---------------------------------------------------- | ------------------------------------ |
| 主要用途 | 应用程序之间的通信接口                  | 低级别二进制格式的规范                               | 远程调用其他计算机上的程序           |
| 适用场景 | 软件功能的调用（如天气API、支付API）    | 程序、操作系统、编译器的兼容性、以太坊智能合约的交互 | 分布式系统的远程交互（如区块链节点） |
| 示例     | 提供一组函数供应用调用，例如天气API接口 | 定义智能合约的函数格式，方便DApp交互                 | 客户端通过RPC向区块链节点发送请求    |

### ABI：应用二进制接口

**ABI (Application Binary Interface)**，应用二进制接口，是一种低层级的接口，通常用于让一个程序与操作系统、编译器或其他程序在二进制层面上兼容。ABI特别重要于需要在不同硬件或编译环境上运行的应用中，因为它定义了应用如何在二进制层面处理数据，比如函数的参数如何传递、返回值如何表示等。

在以太坊上，ABI是我们与智能合约交互时的“通用语言”。与API不同，ABI规定了**数据在二进制层面如何编码和解码**，既可以从区块链外部进行交互，也可以用于合约间交互。

具体来说，ABI编码将每个数据类型的值都“填充”为**32字节**的二进制数，以便形成标准的消息格式。这种格式不仅对每个合约内的数据类型有一致的约定，同时因为填充固定，它便于以太坊合约快速解析。想象一下，如果每个合约都有自己独特的语言和格式，就像人们用不同方言交流一样，沟通的效率会极大降低。**统一的ABI标准使得数据结构在所有合约间保持一致**，从而促进了智能合约的通用性和可靠性。

想象一下世界各地的货物运输。如果每个国家都设计了自己独特形状的集装箱，那出口的商品就无法直接用标准的起重机装卸，甚至需要换成本地形状的集装箱再运输，整个过程既费时又费力。而国际贸易中，所有集装箱都遵循了统一的尺寸和规格，所以船只、码头、卡车都可以通用，货物运输变得高效快捷。ABI在以太坊中承担的就是这种“标准集装箱”角色：它**定义了所有合约交互的标准格式**，使得各个程序、钱包和智能合约可以用相同的方法解码和解析数据，不会出现因格式不兼容而产生的错误。

ABI的具体应用场景包括：

- 在合约开发中，ABI常配合call来实现对合约的底层调用。
- ethers.js中常用ABI实现合约的导入和函数调用。
- 对不开源合约进行反编译后，某些函数无法查到函数签名，可通过ABI进行调用。

我们可以通过在线ABI编码器网站直观地感受一下ABI编码标准：

{% embed url="https://adibas03.github.io/online-ethereum-abi-encoder-decoder/#/encode" %}

例如，在Argument Types（参数类型）部分输入`uint`（无符号整数），然后在Argument values（参数值）部分输入`10`，我们会得到如下返回：

```plain
000000000000000000000000000000000000000000000000000000000000000a
```

参数类型填写`address`，参数值写`0x7A58c0Be72BE218B41C608b7Fe7C5bB630736C71`，得到返回的编码数据如下：

```plain
0000000000000000000000007a58c0be72be218b41c608b7fe7c5bb630736c71
```

参数类型填写`address,uint`，参数值写`0x7A58c0Be72BE218B41C608b7Fe7C5bB630736C71,10`，得到返回的编码数据如下：

```plain
0000000000000000000000007a58c0be72be218b41c608b7fe7c5bb630736c71000000000000000000000000000000000000000000000000000000000000000a
```

由于编码规则将每个数据都填充为32字节，也就是64位16进制数，中间有很多`0`。感兴趣的读者可自行尝试更多可能得数据输入。ABI编码规则的具体内容已经超过本文的讨论范围，读者可自行查阅资料学习。

### RPC：远程过程调用

**RPC(Remote Process Call)**，远程过程调用，是一种通信方式，允许一个程序调用位于另一台计算机上的函数或方法。虽然调用的是远程代码，但RPC可以让它像在本地执行一样。RPC广泛应用于分布式系统中，比如区块链节点之间的通信就是通过RPC完成的。

API是一个宽泛的概念，它允许软件应用程序相互交互并交换信息。API提供了一套规则和约定，定义了如何请求和返回数据，从而使得各种应用程序能够以一种一致的方式进行通信。另一方面，RPC是一种特定的API交互方式。通过RPC，一个程序可以在另一台机器上执行函数，就好像这个函数是本地的一样。当在网络环境中使用时，RPC依赖于HTTP、HTTPS或WebSockets等协议来促进这些远程调用，从而实现跨系统的函数无缝执行。

例如，想象一下你手机上的数字助理应用程序。当你询问它天气情况时，该应用程序可能会使用API与天气服务器进行通信。如果API使用了RPC结构，那么助理就可以调用天气服务器上面的天气服务的函数来获取当前的天气详情，就像这个函数不是位于远程服务器上，而是应用程序的一部分一样。在这里，RPC使得远程任务感觉像是本地的，但这只是因为API结构管理了这种交互。

总结来说，API是用于交互的一般结构，而RPC是实现API以执行特定远程函数的一种方式。不是每个API都是RPC，但RPC是实现API驱动的远程通信的一种方式。因此，通常可以认为RPC包含了API的指令。

在区块链上，开发者通常使用RPC与节点交互，查询链上数据或广播交易。例如，通过RPC接口，客户端可以请求链上账户余额，甚至发送交易到区块链网络。

C端用户其实不需要理解RPC到底是什么或者RPC怎么样工作，他们直接接触的是**RPC提供商**。RPC提供商允许开发者和应用程序无需自行运行完整节点即可访问区块链网络。像Infura、Alchemy和QuickNode这样受欢迎的RPC提供商负责处理复杂的基础设施，因此用户能够可靠且快速地连接到区块链节点。这种设置使开发者能够轻松地与智能合约交互、提交交易和查询数据。

当应用程序需要从区块链获取数据（例如钱包余额或交易详情）时，它会向RPC提供商发送一个RPC请求。提供商的节点会响应这个请求，通过检索并发送所需数据或执行所需功能（如将交易广播到网络）来回应。通过这种方式，RPC提供商提供了一个与区块链节点通信的直观接口，从而消除了每个开发者都需要管理自己节点的需求。

通过RPC提供商，开发者获得了可扩展且成本效益高的区块链访问方式，使他们能够专注于构建应用程序，而无需担心节点的维护工作。

举例来说，大家可以访问如下网址：

{% embed url="https://chainlist.wtf/" %}

我们可以看到非常多区块链网络，让我们点击Ethereum Mainnet：

![](https://cdn.jsdelivr.net/gh/zey9991/mdpic/image-20241109093253789.png)

下拉可以看到非常多RPC URL，这些就是RPC请求的地址：

![以太坊主网的RPC URL](https://cdn.jsdelivr.net/gh/zey9991/mdpic/image-20241109093424102.png)

感兴趣的读者也可以访问RPCList网站，查看其对各个区块链的RPC提供商的评分：

{% embed url="https://rpclist.com/" %}

![RPCList网站前端](https://cdn.jsdelivr.net/gh/zey9991/mdpic/image-20241109093831819.png)

读者可以访问Uniswap的前端：

{% embed url="https://app.uniswap.org/" %}

然后按F12，选择Network，可以发现前端做了非常多的请求，其中一些就是RPC请求。比如下图选中的这个请求，其请求的地址（RPC URL）就是infura的地址，infura就是一个RPC提供商。

![Uniswap前端的RPC请求](https://cdn.jsdelivr.net/gh/zey9991/mdpic/image-20241109095530892.png)

再另外随机点选一个类似的RPC请求，选中Payload（请求载体）可以看到这实际上请求获取的是以太坊的区块高度。

![Uniswap前端的RPC请求](https://cdn.jsdelivr.net/gh/zey9991/mdpic/image-20241109095217251.png)

# 怎么调用API？

## JSON API

在这个行业笔者遇到的API绝大部分都是JSON API，这是一种专注于用 JSON 格式传输数据的 API 规范。其特点是：

- **统一的 JSON 数据格式**：JSON API 规范定义了数据、关系、元数据的表示方法，使得响应格式更加一致，便于客户端处理。
- **规范的响应结构**：规定了对象、数组、关系以及分页信息等应如何在 JSON 中表示。比如，它规定了使用“data”键来封装主数据，“errors”键封装错误信息等。
- **自动化的数据规范**：使用 JSON API 可以减少在客户端解析数据时的自定义代码，因为 API 已经提供了结构化的响应格式，方便解析和处理。

## 案例：DeFilama

DeFiLlama是去中心化金融（DeFi）领域最大的总锁仓价值（TVL）聚合平台。其数据完全开源，并由一支由数百个协议的热情成员和贡献者组成的团队维护。

各位可以点击下方按钮访问其API文档：

{% embed url="https://defillama.com/docs/api" %}

![DeFilama的API文档](https://cdn.jsdelivr.net/gh/zey9991/mdpic/image-20241109124218977.png)

假设我们要获取Pendle协议在所有已经部署了的区块链上的历史TVL（以USD计价）数据，应该怎么实现呢？

### 选择接口

我们首先需要找到能够获取特定协议的历史TVL的数据的接口，可以发现如下图所示的接口能够满足需要：

![](https://cdn.jsdelivr.net/gh/zey9991/mdpic/image-20241109124814252.png)

点击右上方的“Try it out”按钮，在“Protocol”一栏中填写Pendle，然后点击Execute，可以看到如下界面：

![](https://cdn.jsdelivr.net/gh/zey9991/mdpic/image-20241109130036263.png)

可以看到Responses（响应）下面多了很多信息，让我们来逐个看看：

- Curl：这是一个命令行工具，用于与API进行交互。显示的curl命令展示了如何在终端或命令行中请求DeFiLlama API中关于Pendle的数据。**本文用不到这一项。**
- Request URL（请求URL）：这是通过请求访问的地址，具体为https://api.llama.fi/protocol/pendle。
- Server response（服务器响应）：这里提供了HTTP状态码（此处为200），表明响应是成功的。随后是Response body（响应体），这里是以JSON格式获取的Pendle的实际API数据。Response Header（响应头部）字段则指定数据格式为 JSON，表示数据的缓存和更新时间，用于管理数据的刷新频率。

### 定位数据

接下来让我们需要检查Response body的结构（也可以直接访问https://api.llama.fi/protocol/pendle），定位我们要的TVL数据究竟存放在这个超大的JSON文件的何处。

请注意，非常不推荐用肉眼直接查找，这个JSON文件太大了（共计34万行+），我们需要工具来帮助我们。本文中，让我们把此JSON文件的内容复制粘贴到这个JSON Viewer里面：
{% embed url="https://jsonviewer.stack.hu/" %}

然后在Viewer处就可以看到这个JSON文件的格式了。其中的tvl键（数组）下面的数据就是我们需要的。

![](https://cdn.jsdelivr.net/gh/zey9991/mdpic/image-20241109153920127.png)

### 提取数据

现在我们已经定位了Pendle在以太坊上的TVL数据，接下来让我们“取出”对应的数据，导出成类似csv或者xlsx等格式的表格。本文使用的是Python，当然你可以使用任意其他你喜欢的编程语言尝试。提示：以下实现的具体代码不需要记忆，让GPT等AI模型帮你生成即可。

```py
import requests # 用于发送 HTTP 请求，可选择其他库
import pandas as pd # 数据处理和存储库

# 设置 API URL
url = 'https://api.llama.fi/protocol/pendle'
# 发起 GET 请求
response = requests.get(url)
# 检查响应状态
if response.status_code == 200:
    # 将 response 的内容转换成 JSON 格式的 Python 字典。
    data = response.json() 
else:
    # 如果请求失败，打印出状态码以便于调试。
    print(f"Error: {response.status_code}")   
# 提取 tvl 部分数据
chain_data = data['tvl']
   
# 使用Pandas库进行数据类型的转换
# 将提取的数据加载到 DataFrame 中
df = pd.DataFrame(chain_data)
# 将日期转换为可读格式（可选）
df['date'] = pd.to_datetime(df['date'], unit='s')    
# 导出为 Excel 文件
df.to_excel('pendle_tvl_data.xlsx', index=False)  # index=False 可以不保存行索引
print("数据已成功保存为 pendle_tvl_data.xlsx")
```

如果请求成功，接下来你应该可以在对应路径下找到pendle_tvl_data.xlsx了。

> [!TIP]
>
> 如果出现报错**PermissionError**: [Errno 13] Permission denied: 'pendle_tvl_data.xlsx'，请先确保你已经关闭pendle_tvl_data.xlsx文件。

<img src="https://cdn.jsdelivr.net/gh/zey9991/mdpic/image-20241109140303084.png" style="zoom:200%;" />

## 案例：Dune

Dune Analytics 是一个允许任何人发布和访问由区块链数据驱动的加密仪表板的网站。 Dune 为用户提供了从区块链中查询、提取和可视化大量数据的所有工具，任何人都可以免费创建对区块链数据的 SQL 查询，结果以图表的形式可视化。

### 申请API Key

与DeFilama不同的是，你必须首先申请一个Dune的API Key才能调用他们的API。API Key通常用于区分不同级别的服务。免费用户可能有基本权限，而付费用户可以获得更高的请求限额或访问更多数据。此外，API Key允许平台控制访问频率和权限，以保障服务稳定、防止滥用。

为此，如果你是初次使用，需要你访问

{% embed url="https://dune.com/settings/api" %}

选择新建一个Key：

![](https://cdn.jsdelivr.net/gh/zey9991/mdpic/image-20241109141856581.png)

自行输入API Key名字后点击生成

![](https://cdn.jsdelivr.net/gh/zey9991/mdpic/image-20241109141828186.png)

可以获得API key token：

![](https://cdn.jsdelivr.net/gh/zey9991/mdpic/image-20241109142210613.png)

请妥善保管你的API key token。原因如下：

1. **访问权限**：API密钥能为你提供对某些资源的访问权限，恶意者如果得到密钥，可能在未经授权的情况下使用这些资源，甚至获取敏感数据。
2. **请求滥用与费用**：API密钥泄露可能导致超额请求或滥用，给账户带来不必要的费用，尤其在计费API中。
3. **服务限制**：过度滥用或恶意请求可能触发平台限制你的API权限，导致服务中断，影响业务流程。

虽然不似钱包私钥那样直接管理资产，API密钥的泄露也能造成间接或潜在的经济损失，因此必须妥善保管。

### 选择接口

现在，让我们进入一个仪表盘，例如：

{% embed url="https://dune.com/zey9991/gtradeactiveusers" %}

再选中你想要获取数据的图表，本文以下面的图表为例：

![](https://cdn.jsdelivr.net/gh/zey9991/mdpic/image-20241109142938404.png)

点击后，Dune提示我们：

![](https://cdn.jsdelivr.net/gh/zey9991/mdpic/image-20241109145934613.png)

使用`pip install dune-client`以后，我们可以执行和DeFilama案例中类似的步骤。

### 定位数据

不同的是，这次我们无法直接预览Response body，也无法确定其到底是不是一个JSON文件。为此，我们可以尝试：

```py
from dune_client.client import DuneClient

# 设置 API 密钥
api_key = "<此处替换成你的API Key>"  
dune = DuneClient(api_key)
# 设置要执行的查询 ID
query_id = 4208661  # 替换为你的查询 ID
# 获取最新的查询结果
query_result = dune.get_latest_result(query_id)
if query_result:
    print(type(query_result))
else:
    print("No results returned.")
```

调用成功时的返回结果是`<class 'dune_client.models.ResultsResponse'>`，看起来这是dune_client一个自定义类的实例，而不是Python内置的字典或列表数据类型。

可以用`jsonpickle.encode()`来序列化 `query_result` 对象，也就是将该对象转换为一个 JSON 格式的字符串并导出：

```py
from dune_client.client import DuneClient
import jsonpickle  # 用于序列化非 JSON 格式的对象

# 设置 API 密钥
api_key = "<此处替换成你的API Key>"  
dune = DuneClient(api_key)
# 设置要执行的查询 ID
query_id = 4208661  # 替换为你的查询 ID
# 获取最新的查询结果
query_result = dune.get_latest_result(query_id)
# 检查结果并保存为 JSON 文件
if query_result:
    # 使用 jsonpickle 进行序列化
    json_data = jsonpickle.encode(query_result, unpicklable=False)
    # 将结果写入 JSON 文件
    with open("dune_query_result4208661.json", "w") as file:
        file.write(json_data)
    print("Data saved to dune_query_result4208661.json")
else:
    print("No results returned.")
```

成功后，我们可以将导出的JSON文件的内容粘贴至JSON Viewer查看其内部结构：

![](https://cdn.jsdelivr.net/gh/zey9991/mdpic/image-20241109152626189.png)

可以发现我们需要的数据存放在result键下面的rows子键的值（数组）里面。

### 提取数据

实现代码如下所示：

```py
from dune_client.client import DuneClient
import jsonpickle  # 用于序列化非 JSON 格式的对象
import pandas as pd 

# 设置 API 密钥
api_key = "<此处替换成你的API Key>"
dune = DuneClient(api_key)
# 设置要执行的查询 ID
query_id = 4208661  # 替换为你的查询 ID
# 获取最新的查询结果
query_result = dune.get_latest_result(query_id)
# 检查结果并保存为 JSON 文件
if query_result:
    # 提取 rows 数据
    user_data = query_result.result.rows  # 直接从 'result' 中提取 'rows'
    # 转换为 DataFrame
    df = pd.DataFrame(user_data)
    # 保存为 CSV 文件
    df.to_csv("gTrade_monthly_users.csv", index=False)
    print("Data saved to gTrade_monthly_users.csv")
else:
    print("No results returned.")
```

导出成功后打开gTrade_monthly_users.csv文件可以看到：

<img src="https://cdn.jsdelivr.net/gh/zey9991/mdpic/image-20241109160753037.png" style="zoom:200%;" />

### Dune API免费额度和代码优化

Dune平台规定，免费用户每月拥有2,500个Credits，每1,000个数据点消耗1点Credit，因此每月共能调用总计2,500×1,000=2,500,000个数据点。就笔者的体验而言，大部分情况下是够用的，不过我们能通过简单的优化节省部分Credit。

首先，上面的案例中，对于同一个Dashboard重复调用了三次，显然是一种浪费，可以先将数据存储到本地的变量中。

```py
from dune_client.client import DuneClient
import jsonpickle  # 用于序列化非 JSON 格式的对象
import pandas as pd 

# 1.定位数据
# 设置 API 密钥
api_key = "<此处替换成你的API Key>"  
dune = DuneClient(api_key)
# 设置要执行的查询 ID
query_id = 4208661  # 替换为你的查询 ID
# 获取最新的查询结果
query_result = dune.get_latest_result(query_id)
# 检查结果并保存为 JSON 文件
if query_result:
    # 使用 jsonpickle 进行序列化
    json_data = jsonpickle.encode(query_result, unpicklable=False)    
    # 将结果写入 JSON 文件
    with open("dune_query_result4208661.json", "w") as file:
        file.write(json_data)
    print("Data saved to dune_query_result4208661.json")
else:
    print("No results returned.")
  
# 2.提取数据
user_data = query_result.result.rows  # 直接从 'result' 中提取 'rows'
# 转换为 DataFrame
df = pd.DataFrame(user_data)
# 保存为 CSV 文件
df.to_csv("gTrade_monthly_users.csv", index=False)
print("Data saved to gTrade_monthly_users.csv")
```
此外，根据笔者经验，大部分情况下所需要的数据都存储在`query_result.result.rows`中，因此很多情况下我们可以跳过分析响应体结构定位数据这一步，直接针对性提取所需数据即可：

```py
#实操中只要微调这部分的代码即可
from dune_client.client import DuneClient
import jsonpickle  # 用于序列化非 JSON 格式的对象
import pandas as pd 
# 设置 API 密钥
api_key = "<此处替换成你的API Key>"
dune = DuneClient(api_key)
# 设置要执行的查询 ID
query_id = 4208661  # 替换为你的查询 ID
# 获取最新的查询结果
query_result = dune.get_latest_result(query_id)
# 检查结果并保存为 JSON 文件
if query_result:
    # 提取 rows 数据
    user_data = query_result.result.rows  # 直接从 'result' 中提取 'rows'
    # 转换为 DataFrame
    df = pd.DataFrame(user_data)
    # 保存为 CSV 文件
    df.to_csv("gTrade_monthly_users.csv", index=False)
    print("Data saved to gTrade_monthly_users.csv")
else:
    print("No results returned.")
```

## 步骤总结

根据前面几个案例学习，我们可以总结出如下调用API的标准作业程序（SOP）：

1. 可能需要获取API Key Token。
2. 选择接口：根据需要的数据，查找平台的API文档，选择适合的接口和请求地址。
3. 定位数据：分析响应体的结构，定位所需的数据。这一步可借助JSON Viewer等等工具辅助解决。
4. 提取数据：应用Python等多种编程语言，提取响应体中所需要的数据。这一步往往涉及数据类型的转换，可借助Chat GPT等AI模型辅助解决。
5. 应用所需要的数据进行后续的操作。

由于时间和篇幅限制，还有很多其他API本文没有涉及，还望读者自行学习摸索。最后，如果对本文有任何建议，非常欢迎通过X（[@0xPeyton404](https://x.com/0xPeyton404)）或邮箱（zey9991@gmail.com）联系我。

# 参考文献

1. [Contract ABI Specification — Solidity 0.8.29 documentation](https://docs.soliditylang.org/en/develop/abi-spec.html)
2. [第一周：基建之周 | 区块链节点客户端及RPC_哔哩哔哩_bilibili](https://www.bilibili.com/video/BV1sj411d7Nb/?spm_id_from=333.1007.top_right_bar_window_history.content.click&vd_source=fd015ccdec6337c64cc98064986a4512)
3. [简单api的使用教程_api使用教程-CSDN博客](https://blog.csdn.net/m15801872696/article/details/90141941)
4. [什么是 API 调用？ | Cloudflare](https://www.cloudflare.com/zh-cn/learning/security/api/what-is-api-call/)
5. [Python数据结构与算法分析 第3版 | 米勒 拉努姆 罗曼 | download on Z-Library](https://zh.z-lib.gl/book/29042122/0704e2/python数据结构与算法分析-第3版.html)
6. [JSON 教程 | 菜鸟教程](https://www.runoob.com/json/json-tutorial.html)