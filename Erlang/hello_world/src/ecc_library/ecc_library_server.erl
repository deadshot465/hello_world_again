-module(ecc_library_server).
-export([start/2, start_link/2, call/2, cast/2, reply/2]).

%%% Public API
-spec start(_, _) -> pid().
start(Module, InitialState) ->
    spawn(fun() -> init(Module, InitialState) end).

-spec start_link(_, _) -> pid().
start_link(Module, InitialState) ->
    spawn_link(fun() -> init(Module, InitialState) end).

-spec init(atom(), _) -> no_return().
init(Module, InitialState) ->
    loop(Module, Module:init(InitialState)).

-spec call(atom() | pid() | port() | {atom(), atom()}, _) -> any().
call(Pid, Msg) ->
    Ref = erlang:monitor(process, Pid),
    Pid ! {sync, self(), Ref, Msg},
    receive
        {Ref, Reply} ->
            erlang:demonitor(Ref, [flush]),
            Reply;
        { 'DOWN', Ref, process, Pid, Reason } ->
            erlang:error(Reason)
    after 5000 ->
        erlang:error(timeout)
    end.

-spec cast(atom() | pid() | port() | reference() | {atom(), atom()}, _) -> 'ok'.
cast(Pid, Msg) ->
    Pid ! {async, Msg},
    ok.

-spec reply({atom() | pid() | port() | reference() | {atom(), atom()}, _}, _) -> {_, _}.
reply({Pid, Ref}, Reply) ->
    Pid ! {Ref, Reply}.

-spec loop(atom(), _) -> no_return().
loop(Module, State) ->
    receive
        {async, Msg} ->
            loop(Module, Module:handle_cast(Msg, State));
        {sync, Pid, Ref, Msg} ->
            loop(Module, Module:handle_call(Msg, {Pid, Ref}, State))
    end.