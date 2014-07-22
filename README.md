# tkms

## 创建Erlang App

Erlang 把相对独立的一个组件称为 application， 与 ruby 的一个 gem 类似。
OTP Principle 中对 application 进行了相关的规定。

1. application 的描述和说明 使用 `AppName.app` 来表示，类似ruby的
   `gemspec` 或者 nodejs 的`package.json`
2. 规定了 application 的基本目录结构
3. 规定了一个 application 的基本框架
   在 OTP 中，定义了 `gen_server`, `gen_supervisor` 等模块，这些模块称为 `behavior`
   是比较 general 的功能，相当于一个框架的基本类，如 servlet 或者 action


## 编译

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



## rebar
  rebar 是一个工具，类似 ruby 的 `bundler` 或者 `rails`命令。根据
  template生成符合OTP规范的工程结构。并能够进行依赖管理、编译、发布等
  工作。
  rebar的具体使用，参考rebar的使用指南。
  1. 依赖管理
     rebar get-deps
     根据配置文件进行依赖解析和获取
  2.
