%% Feel free to use, reuse and abuse the code in this file.

%% @doc Cookie handler.
-module(toppage_handler).

-export([init/3]).
-export([handle/2]).
-export([terminate/3]).

init(_Transport, Req, []) ->
    {ok, Req, undefined}.

handle(Req, State) ->
    {ok, Req2} = cowboy_req:reply(200, [
                                        {<<"content-type">>, <<"text/plain">>}
                                       ], <<"Hello world!">>, Req),
    {ok, Req2, State}.

terminate(_Reason, _Req, _State) ->
    ok.


lta(L) when is_list(L) ->
    list_to_atom(L).
