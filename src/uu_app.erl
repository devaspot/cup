-module(uu_app).
-behaviour(application).
-compile(export_all).
-export([start/2, stop/1]).

start(_StartType, _StartArgs) -> uu_sup:start_link().
stop(_State) -> ok.
