-module(k08).

-export([execute/1]).

-spec question_1() -> 'ok'.
question_1() ->
    Numbers = k07:get_numbers(3),
    Count = length(Numbers),
    io:format("どちらを調べますか？"),
    {ok, [Choice]} = io:fread("（０：最大値　１：最小値）＞", "~d"),
    Result = if Choice =:= 0 -> lists:max(Numbers);
                true -> lists:min(Numbers)
    end,
    if Choice =:= 0 ->
        io:format("~Bつの中で最大値は~B~n", [Count, Result]);
       true ->
        io:format("~Bつの中で最小値は~B~n", [Count, Result])
    end.

-spec question_2() -> 'ok'.
question_2() ->
    io:format("冒険が今始まる！~n"),
    PlayerHp = 200 + rand:uniform(101),
    Result = k08_adventure:game_loop(PlayerHp),
    io:format("~ts", [Result]).

-spec question_3() -> 'ok'.
question_3() ->
    'ok'.

-spec question_4() -> 'ok'.
question_4() ->
    'ok'.

-spec execute(_) -> 'ok'.
execute(1) -> question_1();
execute(2) -> question_2();
execute(3) -> question_3();
execute(4) -> question_4();
execute(_) -> 'ok'.