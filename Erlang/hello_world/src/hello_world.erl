-module(hello_world).

-export([main/0]).

main() ->
    Modules = [k01, k02, k03, k04, k05, k06],
    Ordinals = lists:seq(1, length(Modules)),
    Zipped = lists:zip(Ordinals, Modules),
    io:format("実行したいプログラムを選択してください。~n"),
    lists:foreach(fun({I, _}) ->
        Prefix = if I < 10 -> "K0";
                    true -> "K"
                 end,
        io:format("~B) ~s~B\t\t", [I, Prefix, I])
        end, Zipped),
    io:format("~n"),
    {ok, [Choice]} = io:fread("", "~d"),
    show_selections(Choice),
    {ok, [Choice2]} = io:fread("", "~d"),
    Module = lists:nth(Choice, Modules),
    apply(Module, execute, [Choice2]).

-spec show_selections(_) -> 'ok'.
show_selections(Chapter) ->
    Prefix = if Chapter < 10 -> "K0";
                true -> "K"
             end,
    Ordinals = [1, 2, 3, 4],
    lists:foreach(fun(X) -> io:format("\t~B) ~s~B_~B", [X, Prefix, Chapter, X]) end, Ordinals).