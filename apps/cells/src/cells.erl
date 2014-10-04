-module(cells).
-behaviour(gen_server).

-export([start_link/0]).
-export([init/1]).
-export([handle_call/3]).
-export([handle_cast/2]).
-export([handle_info/2]).
-export([code_change/3]).
-export([terminate/2]).

start_link() ->
    gen_server:start_link({local, cells}, cells, _Args = [], _Init = []).

init(_Args) ->
    {ok, _State = []}.

handle_call({echo, Msg}, _From, State) ->
    {reply, Msg, State};

handle_call(_, _From, State) ->
    {reply, ok, State}.

handle_cast(_, State) ->
    {noreply, State}.

handle_info(_, State) ->
    {noreply, State}.

code_change(_OldVsn, State, _Extra) ->
    {ok, State}.

terminate(normal, State) ->
    {ok, State}.
