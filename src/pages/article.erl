-module(article).
-compile(export_all).
-include_lib("n2o/include/wf.hrl").
-include("uu.hrl").

main() ->
   Author = wf:to_list(wf:q(author)),
   Date  = wf:to_list(wf:q(date)),
   Language = wf:to_list(wf:q(locale)),
   generate(Author,Date,wf:atom([Language])).

generate(Author,Date,Language) ->
   %io:format("Article Generate: ~p~n",[{Author,Date,Language}]),
   [Name,Surname] = string:tokens(Author,"-"),
   {_,#user{name=FullName,city=City,profession=Profession,photo=Photo}} = uu_people:lookup({Author,Language}),
   {ok,Body} = file:read_file(lists:concat(["priv/static/interviews/",Date,".",Author,".",Language,".txt"])),
   #dtl{file=article,app=uu,bindings=[{body,markdown:conv_utf8(binary_to_list(Body))},
                                      {date,Date},
                                      {from,FullName},
                                      {to,Profession},
                                      {image,image(Author,Date)}]}.

image(Author,Date) -> [#br{},#image{src=lists:concat(["/static/people/",Author,"/image.jpg"]),width="100%"}].

event(init) ->
   wf:update(body, #label{body= <<"Україна"/utf8>>}  ),
   wf:info(?MODULE,"Init",[]);

event(_) -> ok.
