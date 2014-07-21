-module (simple_web_server).
-export ([start/0]).

start() ->
  Port = 8080,
  ok = application:start(crypto),
  ok = application:start(ranch),
  ok = application:start(cowboy),
  N_acceptors = 10,
  Dispatch = cowboy_router:compile(
                {'_', [{'_', simple_web_server, []}]}
               ),

  cowboy:start_http(my_simple_web_server,
                    N_acceptors,
                    [{port, Port}],
                    [{env, [{dispatch, Dispatch}]}]
                   ).

read_file(Path) ->
  File = ["."|binary_to_list(Path)],
  case file:read_file(File) of
    {ok, Bin} -> Bin;
    _ -> ["<pre>cannot read:", File, "</pre>"]
  end.

init({tcp, http}, Req, _Opts) ->
    {ok, Req, undefined}.

handle(Req, State) ->
  {Path, Req1} = cowbody_req:path(Req),
  Response = read_file(Path),
  {ok, Req2} = cowboy_req:reply(200, [], Response, Req1),
  {ok, Req2, State}.

terminate(_Reason, _Req, _State) ->
  ok.

