-module(uu_routes).
-include_lib("n2o/include/wf.hrl").
-compile(export_all).

finish(State, Ctx) -> {ok, State, Ctx}.
init(State, Ctx) ->
    Path = wf:path(Ctx#cx.req),
    Locale = wf:qc(<<"locale">>,Ctx),
    %wf:info(?MODULE,"Headers Dump: ~p",[wf:headers(Ctx#cx.req)]),
    Module = route_prefix(Path),
    Lang = case Locale of
           undefined -> case binary:match(Path,[<<"EN">>,<<"RU">>]) of
                nomatch -> ua; {Pos,Len} -> binary:part(Path, Pos, Len) end;
           Else -> Else end,
    wf:info(?MODULE,"Locale: ~p",[Lang]),
    {ok, State, Ctx#cx{path=Path,module=Module,lang=lang(Lang)}}.

lang(<<"EN">>) -> en;
lang(<<"UA">>) -> ua;
lang(<<"RU">>) -> ru;
lang(________) -> ua.

route_prefix(<<"/ws/",P/binary>>) -> route(P);
route_prefix(<<"/",P/binary>>) -> route(P);
route_prefix(P) -> route(P).

route(<<"static/app/index.htm">>)     -> index;
route(<<"static/app/i18n/",_,_,"/index.htm">>)     -> index;
route(<<>>) -> index;
route(<<"index">>) -> index;
route(<<"article">>) -> article;
route(_)    -> static_file.
