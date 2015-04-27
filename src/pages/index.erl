-module(index).
-compile(export_all).
-include_lib("n2o/include/wf.hrl").
-include("uu.hrl").

lang() -> string:to_lower(wf:to_list([wf:lang()])).
main() -> #dtl{file=index,
               app=uu,
               bindings=[{news,fetch(news,lang(),fun update_file/1)},
                         {body,body()},
                         {interviews,fetch(interviews,lang(),fun update_file/1)}]}.

body() -> {_,#user{name=FullName,city=City,profession=Profession,photo=Photo}}
          = uu_people:lookup({"dima-gavrysh",wf:to_atom([lang()])}),
        [ #image{src=Photo},#h2{body=FullName},#panel{body=Profession} ].

fetch(Name, Lang, UpdateFile) ->
    List = lists:flatten([ begin
       case string:tokens(F,".") of
         [D,A,L,"txt"] when L == Lang -> UpdateFile([D,A,L]);
                    _  -> [] end end
     || F <- filelib:wildcard(lists:concat(["priv/static/",Name,"/*.txt"])) ]).

update_file([D,A,L]) ->
    Language = wf:atom([L]),
    X=string:tokens(D,"/"),
    Date = lists:last(X),
    JSON = lists:concat(["json/",L,"/",Date,".",A,".json"]),
    HTML = lists:concat(["static/interviews/",L,"/",Date,".",A,".htm"]),
    Text = lists:concat(["static/interviews/",Date,".",A,".",L,".txt"]),

    {ok,Bin} = file:read_file(hd(X)++"/"++Text),
    Render = wf:render(#dtl{} = article:generate(A,Date,Language)),

    file:write_file(lists:concat([hd(X),"/",HTML]),Render),
    file:write_file(lists:concat([hd(X),"/",JSON]),
         iolist_to_binary(
         n2o_json:encode(
         interview:to_json(
                   #interview{id=string:join([Date,A,L],"."),
                              date=Date,
                              text=Bin,
                              author=A})))),

    io:format("JSON: ~p~n",[JSON]),
    io:format("HTML: ~p~n",[HTML]),
    io:format("Text: ~p~n",[Text]),
    io:format("HTM updated: ~p~n",[lists:concat([hd(X),"/",HTML])]),
    article_link({lists:last(X),A,Language,HTML}).

article_link({Date,Author,Language,File}) ->
    case uu_people:lookup({Author,Language}) of
         {_,#user{name=FullName}} ->
               wf:render([#br{},#br{},
                     #link{body= iolist_to_binary([Date," ",FullName," ",wf:to_list(Language)]),
                           href=File}]);
         _ -> [] end.

event(init) -> wf:info(?MODULE,"Init",[]);
event(_) -> ok.
