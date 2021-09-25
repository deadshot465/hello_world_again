-module(k01).

-export([execute/1]).

-spec question_1() -> 'ok'.
question_1() ->
    io:format("Hello World! ようこそErlang言語の世界へ！~n").

-spec question_2() -> 'ok'.
question_2() ->
    io:format("Hello World!~n"),
    io:format("ようこそ~n"),
    io:format("ようこそErlang言語の世界へ！~n").

-spec question_3() -> 'ok'.
question_3() ->
    io:format("整数：~B~n", [12345]),
    io:format("実数：~f~n", [123.456789]),
    io:format("文字：~s~n", ["A"]),
    io:format("文字列：~s~n", ["ABCdef"]).

-spec question_4() -> 'ok'.
question_4() ->
    io:format("~n"),
    io:format("              ##~n"),
    io:format("             #  #~n"),
    io:format("             #  #~n"),
    io:format("            #    #~n"),
    io:format("           #      #~n"),
    io:format("         ##        ##~n"),
    io:format("       ##            ##~n"),
    io:format("    ###                ###~n"),
    io:format(" ###       ##    ##       ###~n"),
    io:format("##        #  #  #  #        ##~n"),
    io:format("##         ##    ##         ##~n"),
    io:format(" ##     #            #     ##~n"),
    io:format("  ###     ##########     ###~n"),
    io:format("     ###              ###~n"),
    io:format("        ##############~n").

-spec execute(_) -> 'ok'.
execute(1) -> question_1();
execute(2) -> question_2();
execute(3) -> question_3();
execute(4) -> question_4();
execute(_) -> 'ok'.
