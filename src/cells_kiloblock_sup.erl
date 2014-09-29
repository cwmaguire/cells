-module(cells_kiloblock_sup).
-behaviour(supervisor).

-export([start_link/0]).
-export([init/1]).
-export([start_cells/0]).

start_link() ->
    supervisor:start_link(cells_sup, []).

init(_Args) ->
    {ok, {{simple_one_for_one, 1, 60},
          [cells_cell,
           {cells_cell, start_link, []},
           permanent,
           1000,
           worker,
           [cells_cell]
          ]}}.

start_cells() ->
    _0to9 = lists:seq(0,9),
    Coords = [{X, Y, Z} || X <- _0to9, Y <- _0to9, Z <- _0to9],
    [{Coord, cell()} || Coord <- Coords].

cell() ->
    cells_cell:start_link(random_properties()).

random_properties() ->
    [{type, grass},
     {is_light, false}].
