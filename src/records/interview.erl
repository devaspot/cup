-module(interview).
-include_lib("n2o/include/wf.hrl").
-include("uu.hrl").
-compile(export_all).
-behaviour(rest).
-compile({parse_transform, rest}).
-export([init/0, populate/1, exists/1, get/0, get/1, post/1, delete/1]).
-rest_record(interview).

init()               -> ok.
populate(Users)      -> skip.
delete(Id)           -> ok.
exists(Id)           -> wf:info(?MODULE,"REST exists: ~p~n",[Id]),
                        filelib:is_file(name(Id)).
get()                -> [ ?MODULE:get(string:join([D,A,L],".")) || {D,A,L} <- uu:ls() ].
get(Id)              -> wf:info(?MODULE,"REST get: ~p~n",[Id]),
                        [D,A,L] = string:tokens(wf:to_list(Id),"."),
                        {ok,Bin} = file:read_file(name(Id)),
                        #interview{id=Id,text=Bin,author=A,date=D}.
name(Id)             -> [D,A,L] = string:tokens(wf:to_list(Id),"."),
                        lists:concat(["priv/static/interviews/",D,".",A,".",L,".txt"]).
post(#interview{} = User) -> ok;
post(Data)           -> post(from_json(Data, #interview{})).
