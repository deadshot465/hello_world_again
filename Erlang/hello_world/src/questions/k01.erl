-module(k01).

-export([question_1/0, question_2/0, question_3/0, question_4/0]).

question_1() ->
    io:format("Hello World! ようこそErlang言語の世界へ！~n").

question_2() ->
    io:format("Hello World!~n"),
    io:format("ようこそ~n"),
    io:format("ようこそErlang言語の世界へ！~n").

question_3() ->
    io:format("整数：~B~n", [12345]),
    io:format("実数：~f~n", [123.456789]),
    io:format("文字：~s~n", ["A"]),
    io:format("文字列：~s~n", ["ABCdef"]).

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