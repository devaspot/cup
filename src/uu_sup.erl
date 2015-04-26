-module(uu_sup).
-behaviour(supervisor).
-export([start_link/0, init/1]).
-compile(export_all).

start_link() -> supervisor:start_link({local, ?MODULE}, ?MODULE, []).
cron(Key) -> {Key,{cron,start_link,[Key]},permanent,2000,worker,[cron]}.

init([]) ->

    wf:info(?MODULE,"~nUnitedUkraine.org WebSocket Server~n",[]),

    {ok, _} = cowboy:start_http(http, 100, [{port, wf:config(n2o,port)}],
                                           [{env, [{dispatch, dispatch_rules()}]}]),

    kvs:join(),
    [ ets:insert(globals,X) || X <- uu_people:all() ],
    [ ets:insert(globals,X) || X <- uu_timeline:all() ],
    {ok, {{one_for_one, 5, 10}, []}}.

mime() -> [{mimetypes,cow_mimetypes,all}].

dispatch_rules() ->
    cowboy_router:compile(
        [{'_', [
            {"/static/[...]", n2o_dynalo, {dir, "priv/static", mime()}},
            {"/n2o/[...]", n2o_dynalo, {dir, "deps/n2o/priv", mime()}},
            {"/ws/[...]", bullet_handler, [{handler, n2o_bullet}]},
            {'_', n2o_cowboy, []}
    ]}]).
