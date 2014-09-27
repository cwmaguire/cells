-module(cells_sup).
-behaviour(supervisor).

-export([start_link/0]).
-export([init/1]).

start_link() ->
    supervisor:start_link(cells_sup, []).

init(_Args) ->
    {ok, {{one_for_one, 1, 60},
          [{cells, {cells, start_link, []},
            permanent, brutal_kill, worker, [cells]}]}}.
