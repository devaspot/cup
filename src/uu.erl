-module(uu).
-compile(export_all).

online()       -> ets:select(gproc,fun2ms_all()).
online_count() -> ets:select_count(gproc,fun2ms_count()).
fun2ms_all()   -> ets:fun2ms(fun({{{_,_,broadcast},_},D,E}) -> {D,E} end).
fun2ms_count() -> ets:fun2ms(fun({{{_,_,broadcast},_},D,E}) -> true end).

log_modules() -> [uu,uu_timeline,index,article,n2o_websocket].
main(A) -> mad_repl:main(A,[]).

main() -> [].

event(_) -> ok.

timeline(Lang) -> [ X || {{_,L},_}=X <- uu_timeline:all(), L == Lang ].

