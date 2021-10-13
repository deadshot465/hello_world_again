-module(ecc_library_gen_server).
-behaviour(gen_server).
-export([start_link/0, borrow_book/2, return_book/2, close_library/1]).
-export([init/1, handle_call/3, handle_cast/2, handle_info/2, terminate/2, code_change/3]).

%%% Client API
-spec start_link() -> 'ignore' | {'error', _} | {'ok', pid() | {pid(), reference()}}.
start_link() ->
    gen_server:start_link(?MODULE, [], []).

borrow_book(Pid, Name) ->
    gen_server:call(Pid, {borrow, Name}).

return_book(Pid, Book) ->
    gen_server:cast(Pid, {return, Book}).

close_library(Pid) ->
    gen_server:call(Pid, terminate).

%%% Server functions
-spec init([]) -> {'ok', []}.
init([]) ->
    {ok, []}.

handle_call({borrow, Name}, _From, Library) ->
    if Library =:= [] ->
        {reply, unicode:characters_to_list(["ECC ", Name], unicode), Library};
       Library =/= [] ->
        {reply, hd(Library), tl(Library)}
    end;

handle_call(terminate, _From, Library) ->
    {stop, normal, ok, Library}.

-spec handle_cast({'return', _}, _) -> {'noreply', nonempty_maybe_improper_list()}.
handle_cast({return, Book}, Library) ->
    {noreply, [Book | Library]}.

-spec handle_info(_, _) -> {'noreply', _}.
handle_info(Msg, Library) ->
    io:format("Unexpected message: ~p~n", [Msg]),
    {noreply, Library}.

-spec terminate('normal', [any()]) -> 'ok'.
terminate(normal, Library) ->
    [io:format("~p was burnt.~n", [Name]) || Name <- Library],
    ok.

-spec code_change(_, _, _) -> {'ok', _}.
code_change(_OldVsn, State, _Extra) ->
    {ok, State}.