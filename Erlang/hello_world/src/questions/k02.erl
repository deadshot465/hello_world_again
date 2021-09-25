-module(k02).

-export([question_1/0, question_2/0, question_3/0, question_4/0]).

-spec question_1() -> 'ok'.
question_1() ->
    Seisuu = 3,
    Jissuu = 2.6,
    Moji = "A",
    io:format("変数Seisuuの値は~B~n", [Seisuu]),
    io:format("変数Jissuuの値は~f~n", [Jissuu]),
    io:format("変数Mojiの値は~s~n", [Moji]).

-spec question_2() -> 'ok'.
question_2() ->
    {ok, [Num1]} = io:fread("一つ目の整数は？", "~d"),
    {ok, [Num2]} = io:fread("二つ目の整数は？", "~d"),
    io:format("~B÷~B=~B...~B~n", [Num1, Num2, Num1 div Num2, Num1 rem Num2]).

-spec question_3() -> 'ok'.
question_3() ->
    {ok, [PriceA]} = io:fread("一つ目の商品の値段は？", "~d"),
    {ok, [AmountA]} = io:fread("個数は？", "~d"),
    {ok, [PriceB]} = io:fread("二つ目の商品の値段は？", "~d"),
    {ok, [AmountB]} = io:fread("個数は？", "~d"),
    TotalPriceA = float(PriceA) * float(AmountA),
    TotalPriceB = float(PriceB) * float(AmountB),
    TotalPrice = TotalPriceA + TotalPriceB,
    io:format("お支払いは税込み￥~f~n", [TotalPrice * 1.1]).

-spec question_4() -> 'ok'.
question_4() ->
    Golem = {golem, {hp, 300}, {defense, 80}, {attack, 50}},
    {golem, {hp, Hp}, {defense, Defense}, {attack, Attack}} = Golem,
    io:format("ゴーレム　（HP：~B　防御力：~B）~n", [Hp, Defense]),
    io:format("HP：~B~n", [Hp]),
    {ok, [Damage]} = io:fread("今回の攻撃の値を入力してください＞", "~d"),
    FinalDamage = if Damage - Defense > 0 -> Damage - Defense;
                     true -> 0
                  end,
    io:format("ダメージは~Bです。~n", [FinalDamage]),
    NewGolem = {golem, {hp, Hp - FinalDamage}, {defense, Defense}, {attack, Attack}},
    {golem, {hp, NewHp}, _, _} = NewGolem,
    io:format("残りのHPは~Bです。~n", [NewHp]).