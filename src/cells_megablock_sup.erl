-module(cells_megablock_sup).
-behaviour(supervisor).

-export([start_link/0]).
-export([init/1]).
-export([start_kiloblocks/0]).

start_link() ->
    supervisor:start_link(cells_megablock_sup, []).

init(_Args) ->
    io:format("Megablock supervisor starting"),
    {ok, {{simple_one_for_one, 1, 60},
          [kiloblock_sup,
           {kiloblock_sup, start_link, []},
           permanent,
           infinity,
           supervisor,
           [kiloblock_sup]
          ]}}.

start_kiloblocks() ->
    _0to9 = lists:seq(0,9),
    Coords = [{X, Y, Z} || X <- _0to9, Y <- _0to9, Z <- _0to9],
    [{Coord, kiloblock()} || Coord <- Coords].

kiloblock() ->
    supervisor:start_child(cells_kiloblock_sup, []).
