-module(k06).

-export([execute/1]).

-spec question_1() -> 'ok'.
question_1() ->
    Ages = get_ages(),
    Count = length(Ages),
    AverageAge = lists:sum(Ages) / Count,
    io:format("~B人の平均年齢は~fです。", [Count, AverageAge]).

-spec get_ages() -> [integer()].
get_ages() -> input_age(0, 5, []).

-spec input_age(non_neg_integer(), integer(), [integer()]) -> [integer()].
input_age(_, 0, Acc) -> Acc;
input_age(No, Amount, Acc) ->
    {ok, [Age]} = io:fread(integer_to_list(No + 1) ++ "人目の年齢を入力して下さい：", "~d"),
    input_age(No + 1, Amount - 1, [Age|Acc]).

-spec question_2() -> 'ok'.
question_2() ->
    io:format(make_upper_pyramid(8)),
    io:format("~n~n"),
    io:format(make_lower_pyramid(8)),
    io:format("~n~n"),
    io:format(make_special_pyramid(8)).

-spec build_upper_pyramid(non_neg_integer(), integer(), [[any()]]) -> [[any()]].
build_upper_pyramid(_, 0, Acc) -> Acc;
build_upper_pyramid(Current, Levels, Acc) ->
    build_upper_pyramid(Current + 1, Levels - 1, [lists:flatten(lists:duplicate(Current + 1, "*"))|Acc]).

-spec make_upper_pyramid(8) -> [any()].
make_upper_pyramid(Levels) ->
    lists:flatten(lists:join("\n", lists:reverse(build_upper_pyramid(0, Levels, [])))).

-spec build_lower_pyramid(integer(), [[any()]]) -> [[any()]].
build_lower_pyramid(0, Acc) -> Acc;
build_lower_pyramid(Levels, Acc) ->
    build_lower_pyramid(Levels - 1, [lists:flatten(lists:duplicate(Levels, "*"))|Acc]).

-spec make_lower_pyramid(8) -> [any()].
make_lower_pyramid(Levels) ->
    lists:flatten(lists:join("\n", lists:reverse(build_lower_pyramid(Levels, [])))).

-spec build_special_pyramid(integer(), non_neg_integer(), [[any()]]) -> [[any()]].
build_special_pyramid(0, _, Acc) -> Acc;
build_special_pyramid(Stars, Spaces, Acc) ->
    Line = lists:flatten(lists:duplicate(Spaces, " ")) ++ lists:flatten(lists:duplicate(Stars, "*")),
    build_special_pyramid(Stars - 1, Spaces + 1, [Line|Acc]).

-spec make_special_pyramid(8) -> [any()].
make_special_pyramid(Levels) ->
    lists:flatten(lists:join("\n", build_special_pyramid(Levels, 0, []))).

-spec count_tens(integer()) -> integer().
count_tens(Remains) -> Remains div 10.

-spec count_fifties(integer(), integer(), [{integer(), integer()}]) -> [{integer(), integer()}].
count_fifties(Amount, _, Arr) when Amount < 0 -> Arr;
count_fifties(Amount, Remains, Arr) ->
    count_fifties(Amount - 1, Remains, [{Amount, count_tens(Remains - (50 * Amount))}|Arr]).

-spec count_hundreds(integer(), 370, [{integer(), _, _}]) -> [{integer(), _, _}].
count_hundreds(Amount, _, Arr) when Amount < 0 -> Arr;
count_hundreds(Amount, Remains, Arr) ->
    Remaining = Remains - (100 * Amount),
    NewArr = lists:map(fun({X, Y}) -> {Amount, X, Y} end, count_fifties(Remaining div 50, Remaining, [])),
    count_hundreds(Amount - 1, Remains, NewArr ++ Arr).

-spec count_combinations(370) -> [{integer(), _, _}].
count_combinations(Amount) -> count_hundreds(Amount div 100, Amount, []).

-spec question_3() -> 'ok'.
question_3() ->
    Combinations = count_combinations(370),
    CombinationText = lists:map(fun({X, Y, Z}) ->
        ("10円の硬貨" ++ integer_to_list(Z) ++ "枚 50円の硬貨" ++ integer_to_list(Y) ++ "枚 100円の硬貨" ++ integer_to_list(X) ++ "枚\n") end,
        Combinations),
    Output = lists:flatten(lists:join("\n", CombinationText)),
    io:format("~ts~n~n", [Output]),
    Count = length(Combinations),
    io:format("以上~B通りを発見しました。~n", [Count]).

-spec question_4() -> 'ok'.
question_4() ->
    io:format("\t|\t"),
    OneToTen = lists:flatten(lists:join("\t", lists:map(fun(X) -> integer_to_list(X) end, print_one_to_ten(9, [])))),
    io:format("~s~n", [OneToTen]),
    Line = lists:flatten(lists:duplicate(90, "-")),
    io:format("~s~n", [Line]),
    Calculations = calculate(9, []),
    Ordinals = lists:seq(1, length(Calculations)),
    Zipped = lists:zip(Ordinals, Calculations),
    Text = lists:map(fun({I, Arr}) ->
        InnerList = lists:map(fun(X) -> integer_to_list(X) end, Arr),
        String = lists:flatten(lists:join("\t", InnerList)),
        integer_to_list(I) ++ "\t|\t" ++ String
    end, Zipped),
    Output = lists:flatten(lists:join("\n", Text)),
    io:format("~s~n", [Output]).

-spec print_one_to_ten(integer(), [integer()]) -> [integer()].
print_one_to_ten(0, Arr) -> Arr;
print_one_to_ten(Num, Arr) -> print_one_to_ten(Num - 1, [Num|Arr]).

-spec multiply(integer(), integer(), [integer()]) -> [integer()].
multiply(_, 0, Arr) -> Arr;
multiply(I, J, Arr) -> multiply(I, J - 1, [I * J|Arr]).

-spec calculate(integer(), [[integer()]]) -> [[integer()]].
calculate(0, Arr) -> Arr;
calculate(I, Arr) -> calculate(I - 1, [multiply(I, 9, [])|Arr]).

-spec execute(_) -> 'ok'.
execute(1) -> question_1();
execute(2) -> question_2();
execute(3) -> question_3();
execute(4) -> question_4();
execute(_) -> 'ok'.