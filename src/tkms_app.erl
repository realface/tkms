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
    io:format("hello jason"),
    tkms_sup:start_link().

stop(_State) ->
    ok.

%% 测试代码
-ifdef(TEST).
simple_test() ->
    ok = application:start(tkms),
    ?assertNot(undefined == whereis(tkms_sup)).
-endif.
