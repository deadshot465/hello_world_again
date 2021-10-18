-module(k09).

-export([execute/1]).

-spec question_1() -> 'ok'.
question_1() ->
    Ages = k06:get_ages(3),
    Line = lists:flatten(lists:duplicate(90, "-")),
    io:format("~s~n", [Line]),
    Count = length(Ages),
    Sum = lists:sum(Ages),
    Ordinals = lists:seq(1, Count),
    Zipped = lists:zip(Ordinals, Ages),
    lists:foreach(fun({N, X}) -> io:format("~B人目：~B歳~n", [N, X]) end, Zipped),
    io:format("平均年齢：~f歳~n", [Sum / Count]).

-spec question_2() -> 'ok'.
question_2() ->
    Numbers = [8, 3, 12, 7, 9],
    io:format("元々の配列："),
    lists:foreach(fun(X) -> io:format("~B ", [X]) end, Numbers),
    io:format("~n逆順での表示："),
    Reversed = lists:reverse(Numbers),
    lists:foreach(fun(X) -> io:format("~B ", [X]) end, Reversed).

-spec question_3() -> 'ok'.
question_3() ->
    io:format("~n"),
    StudentScores = [[52, 71, 61, 47], [6, 84, 81, 20], [73, 98, 94, 95]],
    io:format("\t|\t科目A\t科目B\t科目C\t科目D~n"),
    Line = lists:flatten(lists:duplicate(66, "-")),
    io:format("~s~n", [Line]),
    Ordinals = lists:seq(1, length(StudentScores)),
    Zipped = lists:zip(Ordinals, StudentScores),
    lists:foreach(fun({N, X}) ->
        io:format("学生~B\t|\t", [N]),
        lists:foreach(fun(Score) ->
            io:format("~B\t", [Score])
        end, X),
        io:format("~n")
    end, Zipped),
    'ok'.

-spec question_4() -> 'ok'.
question_4() ->
    io:format("~n"),
    StudentScores = [[52, 71, 61, 47], [6, 84, 81, 20], [73, 98, 94, 95]],
    WithSum = lists:map(fun(X) ->
        Sum = lists:sum(X),
        lists:append([X, [Sum]])
    end, StudentScores),
    Ordinals = lists:seq(1, length(StudentScores)),
    Zipped = lists:zip(Ordinals, WithSum),
    io:format("\t|\t科目A\t科目B\t科目C\t科目D\t|\t合計点~n"),
    Line = lists:flatten(lists:duplicate(66, "-")),
    io:format("~s~n", [Line]),
    lists:foreach(fun({N, X}) ->
        io:format("学生~B\t|\t", [N]),
        Last = lists:last(X),
        lists:foreach(fun(Score) ->
            if Score =:= Last -> io:format("|\t~B\t", [Score]);
               true -> io:format("~B\t", [Score])
            end
        end, X),
        io:format("~n")
    end, Zipped),
    Average = transform(WithSum, [0, 0, 0, 0, 0]),
    LastAverage = lists:last(Average),
    io:format("平均点\t|\t"),
    lists:foreach(fun(X) ->
        if X =:= LastAverage -> io:format("|\t~f\t", [X / length(StudentScores)]);
           true -> io:format("~f\t", [X / length(StudentScores)])
        end
    end, Average),
    'ok'.

-spec question_5() -> 'ok'.
question_5() ->
    Input = input_numbers(1, 0, []),
    io:format("----並び替え後----~n"),
    Sorted = lists:sort(Input),
    lists:foreach(fun(X) -> io:format("~B ", [X]) end, Sorted).

transform([], Acc) -> Acc;
transform([Student | XS], Acc) ->
    Ordinals = lists:seq(1, length(Acc)),
    Zipped = lists:zip(Ordinals, Acc),
    NewAcc = lists:map(fun({N, S}) ->
        S + lists:nth(N, Student)
    end, Zipped),
    transform(XS, NewAcc).

input_numbers(N, Choice, Acc) when Choice < 0 orelse N =:= 100 -> Acc;
input_numbers(N, _, Acc) ->
    {ok, [Number]} = io:fread(integer_to_list(N) ++ "件目の入力：", "~d"),
    input_numbers(N + 1, Number, [Number | Acc]).

-spec execute(_) -> 'ok'.
execute(1) -> question_1();
execute(2) -> question_2();
execute(3) -> question_3();
execute(4) -> question_4();
execute(5) -> question_5();
execute(_) -> 'ok'.