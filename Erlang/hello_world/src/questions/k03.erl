-module(k03).

-export([question_1/0, question_2/0, question_3/0, question_4/0]).

question_1() ->
    {ok, [Age]} = io:fread("年齢を入力してください。＞", "~d"),
    io:format(if Age < 20 -> "未成年なので購入できません。~n";
                 true -> ""
              end).

question_2() ->
    {ok, [Height]} = io:fread("身長を入力してください。＞", "~f"),
    HeightInMeter = Height * 0.01,
    {ok, [Weight]} = io:fread("体重を入力してください。＞", "~f"),
    Standard = HeightInMeter * HeightInMeter * 22.0,
    io:format("あなたの標準体重は~fです。~n", [Standard]),
    io:format(case Weight of
                X when X > Standard, ((X - Standard) / Standard) * 100.0 > 14.0 -> "太り気味です。~n";
                X when X < Standard, ((X - Standard) / Standard) * 100.0 < -14.0 -> "痩せ気味です。~n";
                _ -> "普通ですね。~n"
    end).

question_3() ->
    Number = rand:uniform(100) - 1,
    io:format("０から９９の範囲の数値が決定されました。~n"),
    {ok, [Guess]} = io:fread("決められた数値を予想し、この数値よりも大きな値を入力してください＞", "~d"),
    io:format("決められた数値は~Bです。", [Number]),
    io:format(if Guess > Number -> "正解です。~n";
                 true -> "不正解です。~n"
    end).

question_4() ->
    Number = rand:uniform(100) - 1,
    io:format("０から９９の範囲の数値が決定されました。~n"),
    {ok, [Guess]} = io:fread("決められた数値を予想し、この数値よりも大きな値を入力してください＞", "~d"),
    io:format("決められた数値は~Bです。", [Number]),
    io:format(case Guess of
                X when X < 0 orelse X > 99 -> "反則です！~n";
                X when X > Number, X - Number =< 10 -> "大正解です！~n";
                X when X < Number, Number - X =< 10 -> "惜しい！~n";
                X when X =:= Number -> "お見事！~n";
                _ -> (if Guess > Number -> "正解です。~n";
                         true -> "不正解です。~n"
                      end)
    end).