-module(trade_fsm).
-behaviour(gen_statem).
-record(state, {name = "", other, ownitems = [], otheritems = [], monitor, from}).
-export([start/1, start_link/1, trade/2, accept_trade/1, make_offer/2,
        retract_offer/2, ready/1, cancel/1]).
-export([init/1]).

start(Name) ->
    gen_statem:start(?MODULE, [Name], []).

start_link(Name) ->
    gen_statem:start_link(?MODULE, [Name], []).

%% Ask for a begin session. Returns when/if the other accepts.
trade(OwnPid, OtherPid) ->
    gen_statem:call(OwnPid, {negotiate, OtherPid}, 30000).

%% Accept someone's trade offer.
accept_trade(OwnPid) ->
    gen_statem:call(OwnPid, accept_negotiate).

%% Send an item on the table to be traded.
make_offer(OwnPid, Item) ->
    gen_statem:cast(OwnPid, {make_offer, Item}).

%% Cancel trade offer.
retract_offer(OwnPid, Item) ->
    gen_statem:cast(OwnPid, {retract_offer, Item}).

%% Mention that you're ready for a trade.
%% When the other player also declares being ready, the trade is done.
ready(OwnPid) ->
    gen_statem:call(OwnPid, ready, infinity).

%% Cancel the transaction.
cancel(OwnPid) ->
    gen_statem:call(OwnPid, cancel).

%% Ask the other FSM's Pid for a trade session.
ask_negotiate(OtherPid, OwnPid) ->
    gen_statem:cast(OtherPid, {ask_negotiate, OwnPid}).

%% Forward the client message accepting the transaction.
accept_negotiate(OtherPid, OwnPid) ->
    gen_statem:cast(OtherPid, {accept_negotiate, OwnPid}).

%% Forward a client's offer
do_offer(OtherPid, Item) ->
    gen_statem:cast(OtherPid, {do_offer, Item}).

%% Forward a client's offer cancellation.
undo_offer(OtherPid, Item) ->
    gen_statem:cast(OtherPid, {undo_offer, Item}).

%% Ask the other side if he's ready to trade.
are_you_ready(OtherPid) ->
    gen_statem:cast(OtherPid, are_you_ready).

%% Reply that the side is not ready to trade
%% i.e. is not in 'wait' state.
not_yet(OtherPid) ->
    gen_statem:cast(OtherPid, not_yet).

%% Tells the other fsm that the user is currently waiting
%% for the ready state. State should transition to 'ready'
am_ready(OtherPid) ->
    gen_statem:cast(OtherPid, 'ready!').

%% Acknowledge that the fsm is in a ready state.
ack_trans(OtherPid) ->
    gen_statem:cast(OtherPid, ack).

%% Ask if ready to commit.
ask_commit(OtherPid) ->
    gen_statem:call(OtherPid, ask_commit).

do_commit(OtherPid) ->
    gen_statem:call(OtherPid, do_commit).

notify_cancel(OtherPid) ->
    gen_statem:cast(OtherPid, cancel).

init(Name) ->
    {ok, idle, #state{name = Name}}.

%% Send players a notice. This could be messages to their clients
%% but for our purposes, outputting to the shell is enough.
notice(#state{name = Name}, Str, Args) ->
    io:format("~s: " ++ Str ++ "~n", [Name | Args]).

%% Unexpected allows to log unexpected messages
unexpected(Msg, State) ->
    io:format("~p received unknown event ~p while in state ~p~n", [self(), Msg, State]).

idle({ask_negotiate, OtherPid}, S = #state{}) ->
    Ref = monitor(process, OtherPid),
    notice(S, "~p asked for a trade negotiation.", [OtherPid]),
    {next_state, idle_wait, S#state{other = OtherPid, monitor = Ref}};
idle(Event, Data) ->
    unexpected(Event, idle),
    {next_state, idle, Data}.

idle({negotiate, OtherPid}, From, S = #state{}) ->
    ask_negotiate(OtherPid, self()),
    notice(S, "asking user ~p for a trade", [OtherPid]),
    Ref = monitor(process, OtherPid),
    {next_state, idle_wait, S#state{other = OtherPid, monitor = Ref, from = From}};
idle(Event, _From, Data) ->
    unexpected(Event, idle),
    {next_state, idle, Data}.

idle_wait({ask_negotiate, OtherPid}, S = #state{other = OtherPid}) ->
    gen_statem:reply(S#state.from, ok),
    notice(S, "starting negotiation", []),
    {next_state, negotiate, S};
%% The other side has accepted our offer. Move to negotiate state
idle_wait({accept_negotiate, OtherPid}, S = #state{other = OtherPid}) ->
    gen_statem:reply(S#state.from, ok),
    notice(S, "starting negotiation", []),
    {next_state, negotiate, S};
idle_wait(Event, Data) ->
    unexpected(Event, idle_wait),
    {next_state, idle_wait, Data}.

idle_wait(accept_negotiate, _From, S=#state{other = OtherPid}) ->
    accept_negotiate(OtherPid, self()),
    notice(S, "accepting negotiation", []),
    {reply, ok, negotiate, S};
idle_wait(Event, _From, Data) ->
    unexpected(Event, idle_wait),
    {next_state, idle_wait, Data}.

%% Adds an item to an item list
add(Item, Items) ->
    [Item | Items].

%% Remove an item from an item list
remove(Item, Items) ->
    Items -- [Item].

negotiate({make_offer, Item}, S = #state{ownitems = OwnItems}) ->
    do_offer(S#state.other, Item),
    notice(S, "offering ~p", [Item]),
    {next_state, negotiate, S#state{ownitems = add(Item, OwnItems)}};
%% Own side retracting an item offer
negotiate({retract_offer, Item}, S = #state{ownitems = OwnItems}) ->
    undo_offer(S#state.other, Item),
    notice(S, "cancelling offer on ~p", [Item]),
    {next_state, negotiate, S#state{ownitems = remove(Item, OwnItems)}};
%% Other side offering an item
negotiate({do_offer, Item}, S = #state{otheritems = OtherItems}) ->
    notice(S, "other player offering ~p", [Item]),
    {next_state, negotiate, S#state{otheritems = add(Item, OtherItems)}};
%% other side retracting an item offer
negotiate({undo_offer, Item}, S = #state{otheritems = OtherItems}) ->
    notice(S, "other player cancelling offer on ~p", [Item]),
    {next_state, negotiate, S#state{otheritems = remove(Item, OtherItems)}};
negotiate(are_you_ready, S = #state{other = OtherPid}) ->
    io:format("Other user ready to trade.~n"),
    notice(S, "Other user ready to transfer goods:~n", [S#state.otheritems, S#state.ownitems]),
    not_yet(OtherPid),
    {next_state, negotiate, S};
negotiate(Event, Data) ->
    unexpected(Event, negotiate),
    {next_state, negotiate, Data}.

negotiate(ready, From, S = #state{other = OtherPid}) ->
    are_you_ready(OtherPid),
    notice(S, "asking if ready, waiting", []),
    {next_state, wait, S#state{from = From}};
negotiate(Event, _From, S) ->
    unexpected(Event, negotiate),
    {next_state, negotiate, S}.