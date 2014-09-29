-module(cells_mob).
-behaviour(gen_server).

-export([start_link/1]).
-export([init/1]).
-export([handle_call/3]).
-export([handle_cast/2]).
-export([handle_info/2]).
-export([code_change/3]).
-export([terminate/2]).

-record(state, {tick_interval_ms = 1000 :: integer(),
                properties = [] :: list()}).

start_link(Properties) ->
    gen_server:start_link(cells_mob, _Args = Properties, _Init = []).

init(Properties) ->
    tick ! self(),
    {ok, _State = #state{properties = Properties}}.

handle_call({get, Key}, _From, #state{properties = Properties} = State) ->
    Value = proplists:lookup(Key, Properties),
    {reply, Value, State};

handle_call(_, _From, State) ->
    {reply, ok, State}.

handle_cast(_, State) ->
    {noreply, State}.

handle_info(tick, #state{tick_interval_ms = TickIntervalMillis,
                         properties = Properties0} = State) ->
    Properties1 = update(Properties0),
    timer:send_after(TickIntervalMillis, tick),
    {noreply, State#state{properties = Properties1}};

handle_info(_, State) ->
    {noreply, State}.

code_change(_OldVsn, State, _Extra) ->
    {ok, State}.

terminate(normal, State) ->
    {ok, State}.

update(_Properties) ->
    do_nothing.

