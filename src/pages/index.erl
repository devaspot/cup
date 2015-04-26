-module(index).
-compile(export_all).
-include_lib("n2o/include/wf.hrl").
-include("uu.hrl").

main() -> #dtl{file=index,app=uu,bindings=[{news,fetch(news)},
                                           {body,body()},
                                           {interviews,fetch(interviews)}]}.

body() ->
   {_,#user{name=FullName,city=City,profession=Profession,photo=Photo}} =
                        uu_people:lookup({"dima-gavrysh",en}),
   [ #image{src=Photo},#h2{body=FullName},#panel{body=Profession} ].


fetch(Name) ->
    List = lists:flatten([ begin
       case string:tokens(F,".") of
         [D,A,L,"txt"] -> update_file([D,A,L]);
                    _  -> [] end
    end || F <- filelib:wildcard(lists:concat(["priv/static/",Name,"/*.txt"])) ]).

update_file([D,A,L]) ->
    X=string:tokens(D,"/"),
    Language = wf:atom([L]),
    File = lists:concat([string:join(tl(X),"/"),".",A,".",L,".htm"]),
    Article = article:generate(A,lists:last(X),Language),
    Render = wf:render(Article),
    file:write_file(lists:concat([hd(X),"/",File]),Render),
    io:format("HTM updated: ~p~n",[lists:concat([hd(X),"/",File])]),
    article_link({lists:last(X),A,Language,File}).

article_link({Date,Author,Language,File}) ->
    case uu_people:lookup({Author,Language}) of
         {_,#user{name=FullName}} ->
               wf:render([#br{},#br{},
                     #link{body= iolist_to_binary([Date," ",FullName," ",wf:to_list(Language)]),
                           href=File}]);
         _ -> [] end.

event(init) ->
   wf:update(body, #label{body= <<"Україна"/utf8>>}  ),
   wf:info(?MODULE,"Init",[]);

event(_) -> ok.
