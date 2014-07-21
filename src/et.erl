-module(et).
-behaviour(gen_server).

%% API
-export([start_link/0]).

%% gen_server callbacks
-export([init/1, handle_call/3, handle_cast/2, handle_info/2,
         terminate/2, code_change/3]).

-define(SERVER, ?MODULE).

-record(state, {}).


start_link() ->
    gen_server:start_link({local, ?SERVER}, ?MODULE, [], []).

init([]) ->
    {ok, #state{}}.


handle_call(_Request, _From, State) ->
    Reply = ok,
    {reply, Reply, State}.

handle_cast(_Msg, State) ->
    {noreply, State}.


handle_info(_Info, State) ->
    {noreply, State}.


terminate(_Reason, _State) ->
    ok.

code_change(_OldVsn, State, _Extra) ->
    {ok, State}.



test_ets(Mode) ->
    TableId = ets:new(test, [Mode]),
    ets:insert(TableId, {a, 1}),
    ets:delete(TableId).

%% for_each_trigram_in_the_english(F, A0) ->
%%     {ok, Bin0} = file:read_file("354984si.ngl.gz"),
%%     Bin = zlib:gunzip(Bin0),
%%     scan_word_list(binary_to_list(Bin), F, A0).

%% scan_word_list([], _, A)     ->
%%     A;

%% scan_world_list(L, F, A) ->
%%     {Word, L1} = get_next_word(L, []),
%%     A1 = scan_grigrams([$\s|Word], F, A),
%%     scan_word_list(L1, F, A1).

%% get_next_word([$\r, $\n|T], L) -> {reversef($\s|L), T};
%% get_next_word([H|T], L) -> get_next_world(T, [H|T]);
%% get_next_word([], L) -> {reverse([$\s|L], [])}.

%% ========================================================
%% test error handling syntax
%% ========================================================

gexp(error) ->
    error(1);

gexp(throw) ->
    throw(throw_exp);

gexp(exit) ->
    exit(exit_exp).

test(N) ->
    try gexp(N)
    catch
        throw:X ->
            {X};
        error:X ->
            {X};
        exit:X ->
            {X}
    end.

eot(Bs) ->
    eot(Bs, []).

eot([4| _Bs], As) ->
    {done, lists:reverse(As)};
eot([B| Bs], As) ->
    eot(Bs, [B| As]);
eot([], _As) ->
    more.

%% subst(Str, Vars)
%% Vars = [{Var, Val}]
%% Var = Val = string()
%% Substitute all occurrences of %Var% for Val in Str, using the list
%% of variables in Vars.
%%
subst(Str, Vars) ->
    subst(Str, Vars, []).

subst([$%, C| Rest], Vars, Result) when $A =< C, C =< $Z ->
    subst_var([C| Rest], Vars, Result, []);
subst([$%, C| Rest], Vars, Result) when $a =< C, C =< $z ->
    subst_var([C| Rest], Vars, Result, []);
subst([$%, C| Rest], Vars, Result) when  C == $_ ->
    subst_var([C| Rest], Vars, Result, []);
subst([C| Rest], Vars, Result) ->
    subst(Rest, Vars, [C| Result]);
subst([], _Vars, Result) ->
    lists:reverse(Result).

subst_var([$%| Rest], Vars, Result, VarAcc) ->
    Key = lists:reverse(VarAcc),
    case lists:keysearch(Key, 1, Vars) of
        {value, {Key, Value}} ->
            subst(Rest, Vars, lists:reverse(Value, Result));
        false ->
            subst(Rest, Vars, [$%| VarAcc ++ [$%| Result]])
    end;
subst_var([C| Rest], Vars, Result, VarAcc) ->
    subst_var(Rest, Vars, Result, [C| VarAcc]);
subst_var([], Vars, Result, VarAcc) ->
    subst([], Vars, [VarAcc ++ [$%| Result]]).


gather_info() ->
    L1 = length([I||{I, X} <- code:all_loaded(), X =/= preloaded]),
    L2 = length(processes()),
    L3 = length(registered()),
    {
      {all_loaded_mod_cnt, L1},
      {processes_cnt, L2},
      {registered_process_cnt, L3}
    }.

make_scripts() ->
    Cwd = file:get_cwd(),
    S = [
         "#!/bin/sh\nerl",
         %%" -init-debug",
         " -boot", Cwd, "/see",
         " -environment `printenv` -load $1\n"
        ],

    file:write_file("mysee", S),
    os:cmd("chmod a+x see"),
    init:stop(),
    true.

%% simple implemention of quicksort
qsort([]) -> [];
qsort([Pivot|T]) ->
    qsort([X || X <- T, X < Pivot])
        ++ [Pivot] ++
        qsort([X || X <- T, X >= Pivot]).

build_time() ->
    {{Y, M, D}, {H, Min, S}} = calendar:now_to_universal_time(now()),
    lists:flatten(io_lib:format(
                    "~4..0w~2..0w~2..0w~2..0w~2..0w~2..0w",
                    [Y, M, D, H, Min, S])).


loop(X) ->
    receive
        {From, {new_child, M, F, A}} ->
            spawn_link(M, F, A);
        {'EXIT', FromPid, Reason} ->
            io:format("require to exit ~p~n", [{FromPid, Reason}]);
        Any ->
            io:format("Received:~p~n",[Any]),
            loop(X)
    end.
