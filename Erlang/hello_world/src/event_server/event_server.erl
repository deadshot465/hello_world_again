-module(event_server).
-compile(export_all).
-record(state, {events, clients}).
-record(event, {name = "", description = "", pid, timeout = {{1970, 1, 1}, {0, 0, 0}}}).

loop(State = #state{}) ->
    receive
        { Pid, MsgRef, { subscribe, Client } } ->
            Ref = erlang:monitor(process, Client),
            NewClients = orddict:store(Ref, Client, State#state.clients),
            Pid ! { MsgRef, ok },
            loop(State#state{clients = NewClients});
        { Pid, MsgRef, { add, Name, Description, TimeOut } } ->
            case valid_datetime(TimeOut) of
                true ->
                    EventPid = event:start_link(Name, TimeOut),
                    NewEvents = orddict:store(Name, #event{name = Name, description = Description, pid = EventPid, timeout = TimeOut}, State#state.events),
                    Pid ! { MsgRef, ok },
                    loop(State#state{events = NewEvents});
                false ->
                    Pid ! {MsgRef, {error, bad_timeout}},
                    loop(State)
            end;
        { Pid, MsgRef, { cancel, Name } } ->
            Events = case orddict:find(Name, State#state.events) of
                        { ok, E } ->
                            event:cancel(E#event.pid),
                            orddict:erase(Name, State#state.events);
                        error ->
                            State#state.events
                    end,
            Pid ! { MsgRef, ok },
            loop(State#state{ events = Events });
        { done, Name } ->
            case orddict:find(Name, State#state.events) of
                {ok, E} ->
                    send_to_clients({done, E#event.name, E#event.description}, State#state.clients),
                    NewEvents = orddict:erase(Name, State#state.events),
                    loop(State#state{events = NewEvents});
                error ->
                    loop(State)
            end;
        shutdown ->
            exit(shutdown);
        { 'DOWN', Ref, process, _Pid, _Reason } ->
            loop(State#state{clients = orddict:erase(Ref, State#state.clients)});
        code_change ->
            ?MODULE:loop(State);
        Unknown ->
            io:format("Unknown message: ~p~n", [Unknown]),
            loop(State)
    end.

-spec start() -> pid().
start() ->
    register(?MODULE, Pid = spawn(?MODULE, init, [])),
    Pid.

-spec start_link() -> pid().
start_link() ->
    register(?MODULE, Pid = spawn_link(?MODULE, init, [])),
    Pid.

-spec init() -> no_return().
init() ->
    loop(#state{ events = orddict:new(), clients = orddict:new() }).

-spec terminate() -> 'shutdown'.
terminate() ->
    ?MODULE ! shutdown.

-spec valid_datetime(_) -> boolean().
valid_datetime({Date, Time}) ->
    try
        calendar:valid_date(Date) andalso valid_time(Time)
    catch
        error:function_clause -> false
    end;
valid_datetime(_) -> false.

-spec valid_time({_, _, _}) -> boolean().
valid_time({H, M, S}) -> valid_time(H, M, S).

-spec valid_time(_, _, _) -> boolean().
valid_time(H, M, S) when H >= 0, H < 24,
                         M >= 0, M < 60,
                         S >= 0, S < 60 -> true;
valid_time(_, _, _) -> false.

-spec send_to_clients(_, [{_, _}]) -> [{_, _}].
send_to_clients(Msg, ClientDict) ->
    orddict:map(fun(_Ref, Pid) -> Pid ! Msg end, ClientDict).

-spec subscribe(_) -> {'error', _} | {'ok', reference()}.
subscribe(Pid) ->
    Ref = erlang:monitor(process, whereis(?MODULE)),
    ?MODULE ! {self(), Ref, {subscribe, Pid}},
    receive
        { Ref, ok } ->
            { ok, Ref };
        { 'DOWN', Ref, process, _Pid, Reason } ->
            { error, Reason }
    after 5000 ->
        { error, timeout }
    end.

add_event(Name, Description, TimeOut) ->
    Ref = make_ref(),
    ?MODULE ! {self(), Ref, {add, Name, Description, TimeOut}},
    receive
        { Ref, Msg } ->
            Msg
    after 5000 ->
        { error, timeout }
    end.

-spec cancel(_) -> 'ok' | {'error', 'timeout'}.
cancel(Name) ->
    Ref = make_ref(),
    ?MODULE ! {self(), Ref, {cancel, Name}},
    receive
        { Ref, ok } -> ok
    after 5000 ->
        { error, timeout }
    end.

-spec listen(number()) -> [{'done', _, _}].
listen(Delay) ->
    receive
        M = { done, _Name, _Description } ->
            [M | listen(0)]
    after Delay * 1000 ->
        []
    end.