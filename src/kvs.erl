-module (kvs).
-export ([start/0, rpc/2, loop/0]).

start() ->
    register(kvs, spawn(fun () -> init(), loop() end)).

init() ->
    process_flag(trap_exit, true).

rpc(Pid, Q) ->
    Pid ! {self(), Q},
    receive
       Reply ->
            Reply
    end.

echo() ->
    open_port({spawn, "echo"}, [{packet, 1}]).

loop() ->
    receive
        {From, {store, Key, Value}} ->
            put(Key, {ok, Value}),
            From ! {self(), true},
            loop();
        {From, {loopup, Key}} ->
            From ! {self(), get(Key)},
            loop();

        {From,switch_code} ->
            io:format("V2"),
            From ! {self(), code_switched},
            loop();
        {From, spawn_child} ->
            Pid = spawn_link(fun() -> echo() end),
            From ! {self(), Pid},
            loop();
        {From, q} ->
            exit(exit_reason);
        {Port, Any} ->
            io:format("port: ~p~n", [{Port, Any}])
    end.


