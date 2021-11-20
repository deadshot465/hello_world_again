-module(kex_2_battle).
-export([game_loop/3]).
-include("../../shared/enemy.hrl").
-include("../../shared/player.hrl").

-spec attack_hit() -> 110.
attack_hit() -> 110.

-spec skill_hit() -> 100.
skill_hit() -> 100.

-spec magic_hit() -> 70.
magic_hit() -> 70.

-spec select_attack(_) -> {'attack', pos_integer(), 110} | {'magic', pos_integer(), 70} | {'skill', pos_integer(), 100}.
select_attack(1) -> {attack, rand:uniform(40) + 60, attack_hit()};
select_attack(2) -> {skill, rand:uniform(100) + 30, skill_hit()};
select_attack(3) -> {magic, rand:uniform(180) + 20, magic_hit()};
select_attack(_) -> select_attack(1).

-spec check_hit_or_miss(_) -> boolean().
check_hit_or_miss(Hit) -> rand:uniform(100) < Hit.

-spec damage_enemy({_, _, _}, #enemy{}) -> #enemy{}.
damage_enemy(AttackMethod, Enemy = #enemy{}) ->
    {_, Dmg, Hit} = AttackMethod,
    HitOrMiss = check_hit_or_miss(Hit),
    if HitOrMiss -> 
        ActualDamage = (if Dmg - Enemy#enemy.defense < 0 -> 0;
                           true -> Dmg - Enemy#enemy.defense
                        end),
        io:format("~Bのダメージ！~n", [ActualDamage]),
        NewEnemyHp = (if Enemy#enemy.hp - ActualDamage < 0 -> 0;
                         true -> Enemy#enemy.hp - ActualDamage
                      end),
        Enemy#enemy{ hp = NewEnemyHp };
       true ->
        io:format("攻撃を外した！~n"),
        Enemy
    end.

-spec damage_player(#enemy{}, #player{}) -> #player{}.
damage_player(Enemy = #enemy{}, Player = #player{}) ->
    HitOrMiss = check_hit_or_miss(Enemy#enemy.hit),
    if HitOrMiss ->
        Injury = (if Enemy#enemy.attack - Player#player.defense < 0 -> 0;
                     true -> Enemy#enemy.attack - Player#player.defense
                  end),
        io:format("~Bのダメージ！~n", [Injury]),
        NewPlayerHp = (if Player#player.hp - Injury < 0 -> 0;
                          true -> Player#player.hp - Injury
                       end),
        Player#player{ hp = NewPlayerHp };
       true ->
        io:format("攻撃を外した！~n"),
        Player
    end.

battle_loop(_ = #enemy{ hp = Hp, name = Name, level = Level }, Player) when Hp =< 0 ->
    io:format("~tsLv.~Bを倒した！~n", [Name, Level]),
    {continue, Player};
battle_loop(Enemy, _ = #player{ hp = Hp }) when Hp =< 0 ->
    io:format("あなたは~tsに負けました！~n", [Enemy#enemy.name]),
    {'end', "ゲームオーバー！"};
battle_loop(Enemy = #enemy{}, Player = #player{}) ->
    io:format("~ts 残りHP：~B~n", [Enemy#enemy.name, Enemy#enemy.hp]),
    {ok, [Choice]} = io:fread("武器を選択してください（１．攻撃　２．特技　３．魔法）＞", "~d"),
    AttackMethod = select_attack(Choice),
    NewEnemy = damage_enemy(AttackMethod, Enemy),
    io:format("~tsの攻撃！~n", [Enemy#enemy.name]),
    NewPlayer = damage_player(Enemy, Player),
    if NewPlayer#player.hp > 0 ->
        io:format("プレイヤー残りHP：~B~n", [NewPlayer#player.hp]),
        battle_loop(NewEnemy, NewPlayer);
       true -> battle_loop(NewEnemy, NewPlayer)
    end.

engage_battle(Enemy = #enemy{}, Player) ->
    io:format("~tsLv.~Bが現れた！~n", [Enemy#enemy.name, Enemy#enemy.level]),
    battle_loop(Enemy, Player).

-spec game_loop(#player{}, integer(), _) -> nonempty_string().
game_loop(Player = #player{}, Kills, Choice) when Choice =:= 0 ->
    "リ〇ミト！\n戦闘回数：" ++ integer_to_list(Kills) ++ "回　残りHP：" ++ integer_to_list(Player#player.hp);
game_loop(Player = #player{ hp = Hp }, Kills, _) when Hp =< 0 -> game_loop(Player, Kills, 0);
game_loop(Player = #player{}, Kills, _) ->
    io:format("~n現HP：~B~n", [Player#player.hp]),
    {ok, [Choice]} = io:fread("奥に進みますか？（１：奥に進む　０．帰る）＞", "~d"),
    case Choice of
        0 -> game_loop(Player, Kills, Choice);
        _ ->
            Ordinal = rand:uniform(3) - 1,
            Enemy = make_enemy(Ordinal),
            Result = engage_battle(Enemy, Player),
            case Result of
                {'end', Message} ->
                    io:format("~ts", [Message]),
                    game_loop(Player#player{ hp = 0 }, Kills, 0);
                {continue, NewPlayer} ->
                    game_loop(NewPlayer, Kills + 1, 1)
            end
    end.