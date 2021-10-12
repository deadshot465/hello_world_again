-module(event).
-compile(export_all).
-record(state, {server :: pid(), name = "" :: string(), to_go = 0 :: [integer()]}).

-spec loop(#state{server::pid(), name::string(), to_go::integer()}) -> {_, 'ok' | string()}.
loop(State = #state{server = Server, to_go = [T | Next]}) ->
    receive
        { Server, Ref, cancel } ->
            Server ! { Ref, ok }
    after T * 1000 ->
        if Next =:= [] ->
            Server ! { done, State#state.name };
           Next =/= [] ->
            loop(State#state{to_go = Next})
        end
    end.

cancel(Pid) ->
    Ref = erlang:monitor(process, Pid),
    Pid ! {self(), Ref, cancel},
    receive
        { Ref, ok } ->
            erlang:demonitor(Ref, [flush]),
            ok;
        { 'DOWN', Ref, process, Pid, _Reason } ->
            ok
    end.

%% Because Erlang is limited to about 49 days (49*24*60*60*1000) in
%% milliseconds, the following function is used
normalize(N) ->
    Limit = 49 * 24 * 60 * 60,
    [N rem Limit | lists:duplicate(N div Limit, Limit)].

start(EventName, Delay) ->
    spawn(?MODULE, init, [self(), EventName, Delay]).

start_link(EventName, Delay) ->
    spawn_link(?MODULE, init, [self(), EventName, Delay]).

init(Server, EventName, DateTime) ->
    loop(#state{ server = Server, name = EventName, to_go = time_to_go(DateTime) }).

time_to_go(TimeOut = {{_, _, _}, {_, _, _}}) ->
    Now = calendar:local_time(),
    ToGo = calendar:datetime_to_gregorian_seconds(TimeOut) - calendar:datetime_to_gregorian_seconds(Now),
    Secs = if ToGo > 0 -> ToGo;
              ToGo =< 0 -> 0
           end,
    normalize(Secs).