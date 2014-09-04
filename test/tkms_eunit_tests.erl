-module(tkms_eunit_tests).
-compile(export_all).
-include_lib("eunit/include/eunit.hrl").

-define(REBAR_SCRIPT, "../rebar").
-define(TMP_DIR, "tmp_eunit/").

%% tc_1(_) ->
%%     io:format("i'm tc_1"),
%%     case os:getenv("PATH") of
%%         false -> false;
%%         [] -> empty;
%%         Path ->
%%             Path
%%     end.


assert_rebar_runs() ->
    ?assert(string:str(os:cmd(filename:nativename("./" ++ ?TMP_DIR ++ "rebar")),
                       "No command to run specified!") =/= 0).
