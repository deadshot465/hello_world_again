-module(k07).

-export([execute/1, get_numbers/1]).

-spec question_1() -> 'ok'.
question_1() ->
    {ok, [Choice]} = io:fread("メッセージを表示しますか？（０：終了する　１：表示する）＞", "~d"),
    question_1_loop(Choice).

-spec show_texts() -> 'ok'.
show_texts() ->
    io:format("Hello World!~n"),
    io:format("ようこそ~n"),
    io:format("Erlangの世界へ！~n").

-spec question_1_loop(_) -> 'ok'.
question_1_loop(0) -> 'ok';
question_1_loop(_) ->
    show_texts(),
    {ok, [C]} = io:fread("メッセージを表示しますか？（０：終了する　１：表示する）＞", "~d"),
    question_1_loop(C).

-spec input_numbers([any()], non_neg_integer(), 0 | 1 | 2 | 3) -> [any()].
input_numbers(Acc, _, 0) -> Acc;
input_numbers(Acc, No, Count) ->
    {ok, [Value]} = io:fread(integer_to_list(No + 1) ++ "つ目の値を入力してください。＞", "~d"),
    input_numbers([Value|Acc], No + 1, Count - 1).

-spec get_numbers(3) -> [any()].
get_numbers(Count) ->
    input_numbers([], 0, Count).

-spec question_2() -> 'ok'.
question_2() ->
    Numbers = get_numbers(3),
    Count = length(Numbers),
    MaxValue = lists:max(Numbers),
    io:format("~Bつの中で最大値は~B", [Count, MaxValue]).

-spec get_age_tier(_) -> 'error' | 'free' | 'half' | 'normal' | 'ten_percent_off'.
get_age_tier(Age) ->
    case Age of
        N when N =< 0 -> error;
        N when N < 3 orelse N >= 70 -> free;
        N when N >= 3 andalso N =< 15 -> half;
        N when N >= 60 andalso N < 70 -> ten_percent_off;
        _ -> normal
    end.

-spec question_3() -> 'ok'.
question_3() ->
    {ok, [Age]} = io:fread("年齢を入力して下さい。＞", "~d"),
    io:format(case get_age_tier(Age) of
        error -> "不適切な値が入力されました。";
        free -> "入場料金無料です。";
        half -> "子供料金で半額です。";
        ten_percent_off -> "シニア割引で１割引きです。";
        _ -> "通常料金です。"
    end).

-spec question_4() -> 'ok'.
question_4() ->
    'ok'.

-spec execute(_) -> 'ok'.
execute(1) -> question_1();
execute(2) -> question_2();
execute(3) -> question_3();
execute(4) -> question_4();
execute(_) -> 'ok'.