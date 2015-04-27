-module(uu).
-export([active/1]).
-include("uu.hrl").
-compile(export_all).

languages() -> [en,ua,ru].

% Active File System Update

active(["deps",_,"priv"|_]) -> ok;
active(["priv","static","timeline"|_]) -> ok;
active(File) ->
    Last   = lists:last(File),
    Tokens = string:tokens(Last,"."),
    case {Last,lists:last(Tokens)} of
         {".#"++_,_} -> ok;
         {_,"json"}  -> ok;
         {_,"htm"}   -> ok;
         {_,"txt"} when length(Tokens) == 4 ->
                        [D,A,L]=Tokens--["txt"],
                        index:update_file([string:join((File--[Last])++[D],"/"),A,L]),
                        wf:info(?MODULE,"Active Interview: ~p~n",[Last]),
                        active:otp(File);
         {_,"txt"} when length(Tokens) == 2 ->
                        FileName = string:join(File,"/"),
                        wf:info(?MODULE,"Active Timeline: ~p~n",[FileName]),
                        active:otp(File);
         {_,_}       -> active:otp(File) end.

% ls()         -- list all interviews
% timeline(ua) -- show timeline event in UA locale

ls()       -> lists:flatten([ls(L)||L<-uu:languages()]).
time()     -> lists:flatten([time(L)||L<-uu:languages()]).
ls(Lang)   -> index:fetch(interviews,wf:to_list(Lang),fun([A,B,C]) -> {lists:last(string:tokens(A,"/")),B,C} end).
time(Lang) ->
  [{ lists:concat([Y,"-",M,"-",D]),
     case unicode:characters_to_binary(
          binary:part(Text,{0,erlang:min(size(Text),
          case Lang of en -> 30; _ -> 55 end)})) of
          {incomplete,B,_} -> B;
                         E -> E end }
  || {{{Y,M,D},L},Text} <- uu_timeline:all(), L == Lang ].

log_modules()  -> [uu,uu_timeline,index,article,interview,uu_sup].
main(A)        -> mad_repl:main(A,[]).
main()         -> [].
event(_)       -> ok.
online()       -> ets:select(gproc,fun2ms_all()).
online_count() -> ets:select_count(gproc,fun2ms_count()).
fun2ms_all()   -> ets:fun2ms(fun({{{_,_,broadcast},_},D,E}) -> {D,E} end).
fun2ms_count() -> ets:fun2ms(fun({{{_,_,broadcast},_},D,E}) -> true end).
