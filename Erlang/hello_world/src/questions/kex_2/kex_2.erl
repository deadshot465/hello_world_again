-module(kex_2).
-export([run_kex2/0]).
-include("../../shared/player.hrl").

-spec player_initial_hp() -> 500.
player_initial_hp() -> 500.

-spec player_initial_defense() -> 30.
player_initial_defense() -> 30.

-spec run_kex2() -> 'ok'.
run_kex2() ->
    io:format("冒険が今始まる！~n"),
    Player = #player{ hp = player_initial_hp(), defense = player_initial_defense() },
    Result = kex_2_battle:game_loop(Player, 0, 1),
    io:format("~ts", [Result]).