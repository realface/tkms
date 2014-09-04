# tkms

## 创建Erlang App

Erlang 把相对独立的一个组件称为 application， 与 ruby 的一个 gem 类似。
OTP Principle 中对 application 进行了相关的规定。

1. application 的描述和说明 使用 `AppName.app` 来表示，类似ruby的
   `gemspec` 或者 nodejs 的`package.json`
   使用 `erl -man app` 可以查看其具体的定义
   从设计的角度来看，一个 application 的resource file应该包含哪些东西
   呢？
   * app 的 name， id， version
   * 包含的modules
   * app 运行都会注册哪些 process
   * app 的入口和启动参数
   * app 运行的 env 参数
   * app 如果失去响应，最长的等待时间？
   * 所包含的其他 app
   * 所依赖的其他app

2. 规定了 application 的基本目录结构
   * src
   * ebin
   * priv
   * include

3. 规定了一个 application 的基本框架
   在 OTP 中，定义了 `gen_server`, `gen_supervisor` 等模块，这些模块称为 `behavior`
   是比较 general 的功能，相当于一个框架的基本类，如 servlet 或者 action

## template
rebar 提供了一个 template 机制，使用 rebar create，可以根据模板生成文
件。
rebar 默认提供了一些简单的模板。
用户也可以根据自己的需求，进行模板的自定义。
自定义的模板可以放在 `~/.rebar/templates` 下面， 或者当前的工程目录下。
`rebar list-templates` 可以列出available的template

一个 template 的关键设计元素是：
1. src: 即源模板
2. destination: 即转化后模板的目标位置
3. transformation: 从 src 都 dest 如何进行转化？
   一般都是进行 var 的替换。用户提供一个binding，temp系统根据用户提供
   的binding进行替换


## config

给app传递环境变量有这几种方式:
1. .app 中定义了 env 环境变量
2. 通过 Name.config 文件定义app的环境变量， 如果使用release handling，这个config必须叫sys.config
3. 直接传递参数给 erl

## 编译
使用 rebar compile

## application 的启动和停止
OTP 规定了 application 的框架：
1. start stop load unload
2. 启动的类型
   * permanent
     如果app终止，其他app也终止
   * transient
     - 如果终止原因为 normal，则同temporary
     - 如果终止原因非normal， 同 permanent
   * temporary
     如果app终止，其他app不终止io

## 运行

运行 erlang， 最原始的方式可以通过启动 erl 来进行，加上一堆的参数。
除了 erl 启动手工加的命令行参数外，还受到几个文件的影响，
1. boot script
2. .erlang

几个比较重要的参数:
1. -pa -pz
   加入代码搜索路径
   在 erlang 默认的代码搜索路径外，我们要将自己的 application 加入到其
   搜索路径上，那么就需要加上这些参数
2. -boot
   指定 boot script， 如果不加这个参数，erl 启动时默认使用$ROOT 下一
   个文件

那么，还有没有其他的运行方式呢？是否能把 application 打包成独立运行的
程序呢？

这里，就涉及到了 `release` 的概念

## Release
mkdir rel && cd rel  && rebar create-node nodeid=tk1

结果：
    ==> rel (create-node)
    Writing reltool.config
    Writing files/erl
    Writing files/nodetool
    Writing files/tk1
    Writing files/sys.config
    Writing files/vm.args
    Writing files/tk1.cmd
    Writing files/start_erl.cmd
    Writing files/install_upgrade.escript

通过 rebar 提供的 release 功能，创建了 release 需要使用的一些文件

## 测试

使用 rebar可以调用 eunit 进行测试
`rebar eunit` 这个指令，会重新 compile 代码，在其中加入测试相关的部分，
存储在 `.eunit` 目录下。
通过 `rebar.config` 中的一些参数配置，可以进行测试覆盖率统计，并出html
报告等

# eunit

## 文档
`rebar doc` 调用 EDoc 进行文档的生成

## rebar
  rebar 是一个工具，类似 ruby 的 `bundler` 或者 `rails`命令。根据
  template生成符合OTP规范的工程结构。并能够进行依赖管理、编译、发布等
  工作。
  rebar的具体使用，参考rebar的使用指南。
  1. 依赖管理
     rebar get-deps
     根据配置文件进行依赖解析和获取
  2.

## erts
   erlang runtime system
   erlang 运行时，主要由这些方面：

   * init
   运行时启动时的第一个进程，合操作系统的init 进程类似

   * erl_prim_loader
    用来加载模块代码，由 init 启动。可以通过文件系统 或者 网络 来加载。
    通过启动参数来控制

   * erlang

   erts 和 kernel 是什么关系呢？ 照我的理解，类似于 机器 和 内核 的关系。 erts 更基础一些，是从虚拟机的角度来看的。
   而 kernel 则是从程序的角度来看的。


## 