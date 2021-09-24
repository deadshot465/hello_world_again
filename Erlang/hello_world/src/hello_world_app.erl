%%%-------------------------------------------------------------------
%% @doc hello_world public API
%% @end
%%%-------------------------------------------------------------------

-module(hello_world_app).

-behaviour(application).

-export([start/2, stop/1]).

start(_StartType, _StartArgs) ->
    io:format("Hi, there! ~s~n", [string:strip(io:get_line("Hello, what's your name? > "))]),
    hello_world_sup:start_link().

stop(_State) ->
    ok.

%% internal functions
