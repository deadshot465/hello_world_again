-module(k05).

-export([question_1/0, question_2/0, question_3/0, question_4/0]).

-spec question_1() -> 'ok'.
question_1() ->
    question_1_loop(19.0, 22).

-spec question_1_loop(_, _) -> 'ok'.
question_1_loop(Salary, Age) when Salary < 50.0 ->
    question_1_loop(Salary * 1.035, Age + 1);
question_1_loop(Salary, Age) ->
    io:format("~B歳で月給~f万円~n", [Age, Salary]).

-spec question_2() -> 'ok'.
question_2() ->
    question_2_loop(0).

-spec question_2_loop(_) -> 'ok'.
question_2_loop(X) when X =/= 1 ->
    io:format("起きろ～~n"),
    {ok, [Choice]} = io:fread("1．起きた　2．あと5分…　3．Zzzz…\t入力：", "~d"),
    question_2_loop(Choice);
question_2_loop(_) ->
    io:format("よし、学校へ行こう！").

-spec question_3() -> 'ok'.
question_3() ->
    question_3_loop(0).

question_3_loop(X) when X =/= 1 ->
    io:format("~n起きろ～~n"),
    {ok, [Choice]} = io:fread("1．起きた　2．あと5分…　3．Zzzz…\t入力：", "~d"),
    question_3_loop(Choice);
question_3_loop(_) ->
    io:format("よし、学校へ行こう！"),
    question_3_loop(0).

-spec question_4() -> 'ok'.
question_4() ->
    Golem = {golem, {hp, 300 + rand:uniform(200)}, {defense, 80}, {attack, 50}},
    PlayerHp = rand:uniform(100) + 200,
    {golem, {hp, Hp}, {defense, Defense}, _} = Golem,
    io:format("ゴーレム　（HP：~B　防御力：~B）~n", [Hp, Defense]),
    question_4_loop(Golem, PlayerHp).

-spec input_damage(_) -> pos_integer().
input_damage(1) -> rand:uniform(40) + 60;
input_damage(2) -> rand:uniform(100) + 30;
input_damage(3) -> rand:uniform(180) + 20;
input_damage(_) ->
    {ok, [Choice]} = io:fread("攻撃手段を選択してください（1．攻撃　2．特技　3．魔法）＞", "~d"),
    input_damage(Choice).

-spec question_4_loop({'golem', {'hp', integer()}, {'defense', 80}, {'attack', 50}}, pos_integer()) -> 'ok'.
question_4_loop(Golem, PlayerHp) ->
    {golem, {hp, Hp}, {defense, Defense}, {attack, Attack}} = Golem,
    case {Hp, PlayerHp} of
        {X, Y} when X =:= 0, Y =/= 0 -> io:format("ゴーレムを倒しました！~n");
        {X, Y} when X =/= 0, Y =:= 0 -> io:format("あなたはゴーレムに負けました！ゲームオーバー！~n");
        {X, Y} ->
            io:format("ゴーレム残りHP：~B~n", [X]),
            Damage = input_damage(0),
            io:format("基礎攻撃力は~Bです。~n", [Damage]),
            ActualDamage = (if Damage - Defense =< 0 -> 0;
                               true -> Damage - Defense
            end),
            if ActualDamage =:= 0 ->
                io:format("ゴーレム：「ハハハハハ、情けないな！貴様は弱すぎる！」~n"),
                io:format("ゴーレムがあなたを攻撃しました！攻撃値：~B~n", [Attack]),
                RemainingHp = (if Y - Attack < 0 -> 0;
                                  true -> Y - Attack
                end),
                io:format("あなたの残りHPは：~B~n", [RemainingHp]),
                question_4_loop(Golem, RemainingHp);
               true ->
                io:format("ダメージは~Bです。~n", [ActualDamage]),
                RemainingHp = (if X - ActualDamage < 0 -> 0;
                                  true -> X - ActualDamage
                end),
                io:format("残りのHPは~Bです。~n", [RemainingHp]),
                question_4_loop({golem, {hp, RemainingHp}, {defense, Defense}, {attack, Attack}}, Y)
            end
    end.