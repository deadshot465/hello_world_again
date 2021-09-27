-module(k08_adventure).

-export([game_loop/1]).

-spec select_attack(_) -> {'attack', pos_integer()} | {'magic', pos_integer()} | {'skill', pos_integer()}.
select_attack(1) -> {attack, rand:uniform(36) + 65};
select_attack(2) -> {skill, rand:uniform(101) + 50};
select_attack(3) -> {magic, rand:uniform(168) + 33};
select_attack(_) -> select_attack(1).

-spec damage_player(number(), number()) -> number().
damage_player(Attack, PlayerHp) ->
    io:format("ゴーレム：「ハハハハハ、情けないな！貴様は弱すぎる！」~n"),
    io:format("ゴーレムがあなたを攻撃しました！攻撃値：~B~n", [Attack]),
    PlayerHp - Attack.

-spec battle_loop(_, {'golem', {'hp', _}, {'defense', _}, {'attack', _}}, _) -> {'continue', _} | {'end', [1..1114111, ...]}.
battle_loop(GolemLevel, Golem, PlayerHp) ->
    {golem, {hp, Hp}, {defense, Defense}, {attack, Attack}} = Golem,
    if Hp =:= 0 ->
        io:format("ゴーレムLv.~Bを倒した！~n", [GolemLevel]),
        {continue, PlayerHp};
    
       true ->
        io:format("ゴーレムLv.~B残りHP：~B~n", [GolemLevel, Hp]),
        
        {ok, [Weapon]} = io:fread("武器を選択してください（１．攻撃　２．特技　３．魔法）＞", "~d"),
        BaseDamage = (case select_attack(Weapon) of
            {attack, Dmg} -> Dmg;
            {skill, Dmg} -> Dmg;
            {magic, Dmg} -> Dmg
        end),
        ActualDamage = if BaseDamage - Defense =< 0 -> 0;
                          true -> BaseDamage - Defense
        end,

        io:format("ダメージは~Bです。~n", [ActualDamage]),

        if ActualDamage =< 0 ->
            NewPlayerHp = damage_player(Attack, PlayerHp),
            if NewPlayerHp =< 0 ->
                {'end', "あなたはゴーレムに負けました！"};
               true ->
                io:format("あなたの残りHPは：~B~n", [NewPlayerHp]),
                battle_loop(GolemLevel, {golem, {hp, Hp}, {defense, Defense}, {attack, Attack}}, NewPlayerHp)
            end;
           true ->
            NewGolemHp = if Hp - ActualDamage =< 0 -> 0;
                            true -> Hp - ActualDamage
            end,
            battle_loop(GolemLevel, {golem, {hp, NewGolemHp}, {defense, Defense}, {attack, Attack}}, PlayerHp)
        end
    end.

-spec engage_battle(number()) -> {'continue', _} | {'end', [1..1114111, ...]}.
engage_battle(PlayerHp) ->
    GolemLevel = rand:uniform(9) + 1,
    Golem = {golem, {hp, GolemLevel * 50 + 100}, {defense, GolemLevel * 10 + 40}, {attack, GolemLevel * 10 + 30}},
    io:format("ゴーレムLv.~Bが現れた！~n", [GolemLevel]),
    battle_loop(GolemLevel, Golem, PlayerHp).

game_loop(0) -> "ゲームオーバー！~n";
game_loop(PlayerHp) ->
    io:format("あなたのHP：~B~n", [PlayerHp]),
    {ok, [Choice]} = io:fread("奥に進みますか？（１：奥に進む　０．帰る）＞", "~d"),
    if Choice =:= 0 -> "リレ〇ト！~n";
       true -> case engage_battle(PlayerHp) of
        {continue, Hp} -> game_loop(Hp);
        {'end', Msg} -> Msg
       end
    end.
