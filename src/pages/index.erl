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
       case string:tokens(F,".") of [D,A,L,"txt"] -> X=string:tokens(D,"/"),
                                                 article({lists:last(X),A,L});
                                           _  -> [] end
    end || F <- filelib:wildcard(lists:concat(["priv/static/",Name,"/*"])) ]).

article({Date,Author,Language}) ->
    case uu_people:lookup({Author,wf:atom([Language])}) of
    {_,#user{name=FullName}} ->
    wf:render([#br{},#br{},#link{body= iolist_to_binary([Date," ",FullName," ",Language]),
                    href=lists:concat(["/article?date=",Date,"&author=",Author,"&locale=",Language])}]);
                    _ -> "" end.

event(init) ->
   wf:update(body, #label{body= <<"Україна"/utf8>>}  ),
   wf:info(?MODULE,"Init",[]);

event(_) -> ok.
