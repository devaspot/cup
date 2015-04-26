-module(uu).
-export([active/1]).
-compile(export_all).

% Active File System Update

active(["deps"|_]) -> ok;
active(File) ->
    Last   = lists:last(File),
    Tokens = string:tokens(Last,"."),
    case {Last,lists:last(Tokens)} of
         {_,"txt"} when length(Tokens) == 4 ->
                   [D,A,L]=Tokens--["txt"],
                   index:update_file([string:join((File--[Last])++[D],"/"),A,L]),
                   wf:info(?MODULE,"Active Interview: ~p~n",[Last]),
                   active:otp(File);
         {_,"txt"} when length(Tokens) == 2 ->
                   FileName = string:join(File,"/"),
                   wf:info(?MODULE,"Active Timeline: ~p~n",[FileName]),
                   active:otp(File);
         {_,_} ->  wf:info(?MODULE,"Active Ignore: ~p~n",[File]),
                   ok end.

online()       -> ets:select(gproc,fun2ms_all()).
online_count() -> ets:select_count(gproc,fun2ms_count()).
fun2ms_all()   -> ets:fun2ms(fun({{{_,_,broadcast},_},D,E}) -> {D,E} end).
fun2ms_count() -> ets:fun2ms(fun({{{_,_,broadcast},_},D,E}) -> true end).

log_modules() -> [uu,uu_timeline,index,article,n2o_websocket].
main(A) -> mad_repl:main(A,[]).
main() -> [].
event(_) -> ok.

timeline(Lang) -> [ X || {{_,L},_}=X <- uu_timeline:all(), L == Lang ].

