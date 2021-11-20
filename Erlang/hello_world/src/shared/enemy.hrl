-record(enemy, {level, hp, defense, attack, hit, flee, name}).
-export([make_enemy/1]).

-spec calculate_golem_attack(number()) -> number().
calculate_golem_attack(Lv) ->
    Lv * 10 + 40.

-spec golem_hit() -> 75.
golem_hit() -> 75.

-spec golem_flee() -> 20.
golem_flee() -> 20.

-spec goblin_hit() -> 85.
goblin_hit() -> 85.

-spec goblin_flee() -> 40.
goblin_flee() -> 40.

-spec slime_hit() -> 95.
slime_hit() -> 95.

-spec slime_flee() -> 30.
slime_flee() -> 30.

make_enemy(0) ->
    Level = rand:uniform(5),
    #enemy{level = Level, hp = Level * 50 + 100, attack = calculate_golem_attack(Level), defense = Level * 10 + 40, hit = golem_hit(), flee = golem_flee(), name = "ゴーレム"};
make_enemy(1) ->
    Level = rand:uniform(7),
    #enemy{level = Level, hp = Level * 30 + 75, attack = Level * 5 + 20, defense = Level * 5 + 20, hit = goblin_hit(), flee = goblin_flee(), name = "ゴブリン"};
make_enemy(2) ->
    Level = rand:uniform(9),
    #enemy{level = Level, hp = Level * 10 + 50, attack = Level * 2 + 10, defense = Level * 2 + 10, hit = slime_hit(), flee = slime_flee(), name = "スライム"};
make_enemy(_) ->
    make_enemy(0).