-module(k04).

-export([execute/1]).

-spec question_1() -> 'ok'.
question_1() ->
    {ok, [Age]} = io:fread("年齢を入力してください。＞", "~d"),
    io:format(if Age < 3 orelse Age >= 70 -> "入場料金無料です。~n";
                 true -> "通常料金です。~n"
    end).

-spec question_2() -> 'ok'.
question_2() ->
    {ok, [Gender]} = io:fread("性別を選択してください。（０：男性　１：女性）＞", "~d"),
    io:format(case Gender of
                0 -> "あら、格好良いですね。~n";
                1 -> "あら、モデルさんみたいですね。~n";
                _ -> "そんな選択肢はありません。~n"
    end).

-spec question_3() -> 'ok'.
question_3() ->
    {ok, [Age]} = io:fread("年齢を入力してください。＞", "~d"),
    io:format(case Age of
                X when X < 3 orelse X >= 70 -> "入場料金無料です。~n";
                X when X >= 3, X =< 15 -> "子供料金で半額です。~n";
                X when X >= 60, X < 70 -> "シニア割引で一割引きです。";
                _ -> "通常料金です。~n"
    end).

-spec question_4() -> 'ok'.
question_4() ->
    io:format("＊＊＊おみくじプログラム＊＊＊~n"),
    {ok, [Choice]} = io:fread("おみくじを引きますか　（はい：１　いいえ：０）＞", "~d"),
    if Choice >= 1 ->
        Oracle = rand:uniform(5) - 1,
        io:format(case Oracle of
                    0 -> "大吉　とってもいいことがありそう！！~n";
                    1 -> "中吉　きっといいことあるんじゃないかな~n";
                    2 -> "小吉　少しぐらいはいいことあるかもね~n";
                    3 -> "凶　今日はおとなしくておいた方がいいかも~n";
                    4 -> "大凶　これじゃやばくない？早く家に帰った方がいいかも~n";
                    _ -> ""
        end);
        true -> io:format("")
    end.

-spec execute(_) -> 'ok'.
execute(1) -> question_1();
execute(2) -> question_2();
execute(3) -> question_3();
execute(4) -> question_4();
execute(_) -> 'ok'.