-module(cells_sup).
-behaviour(supervisor).

-export([start_link/0]).
-export([init/1]).
-export([start_megablocks/0]).

start_link() ->
    supervisor:start_link(cells_sup, []).

init(_Args) ->
    {ok, {{simple_one_for_one, 1, 60},
          [cells_megablock_sup,
           {cells_megablock_sup, start_link, []},
           permanent,
           infinity,
           supervisor,
           [cells_megablock_sup]
          ]}}.

start_megablocks() ->
    supervisor:start_child(cells_megablock_sup, []).
