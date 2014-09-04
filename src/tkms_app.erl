-module(tkms_app).

-behaviour(application).

%% Application callbacks
-export([start/2, stop/1]).

%% 测试代码
-ifdef(TEST).
-include_lib("eunit/include/eunit.hrl").
-endif.

%% ===================================================================
%% Application callbacks
%% ===================================================================

start(_StartType, _StartArgs) ->

    %% 启动依赖
    _ = application:start(crypto),
    ok = application:start(ranch),
    ok = application:start(cowlib),
    ok = application:start(cowboy),

    %% 路由
    Dispatch = cowboy_router:compile([
                                      {'_', [
                                             {'_', toppage_handler, []}
                                            ]}
                                     ]),

    %% 启动 http 服务
    {ok, _} = cowboy:start_http(http,
                                100,
                                [{port, 8080}],
                                [{env, [{dispatch, Dispatch}]}]),
    tkms_sup:start_link().

stop(_State) ->
    ok.


%% read file
read_file(Path) ->
  File = ["."|binary_to_list(Path)],
  case file:read_file(File) of
    {ok, Bin} -> Bin;
    _ -> ["<pre>cannot read:", File, "</pre>"]
  end.


%% 测试代码
-ifdef(TEST).
simple_test() ->
    %% ok = application:start(tkms),
    %% ?assertNot(undefined == whereis(tkms_sup)).
    test.
-endif.
