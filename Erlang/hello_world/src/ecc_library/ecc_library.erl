-module(ecc_library).
-export([start_link/0, borrow_book/2, return_book/2, close_library/1]).
-export([handle_cast/2, handle_call/3, init/1]).

start_link() -> ecc_library_server:start_link(?MODULE, []).

init([]) ->
    [].

borrow_book(Pid, Name) ->
    ecc_library_server:call(Pid, {borrow, Name}).

return_book(Pid, Name) ->
    ecc_library_server:cast(Pid, {return, Name}).

close_library(Pid) ->
    ecc_library_server:call(Pid, terminate).

handle_call({borrow, Name}, From, Library) ->
    if Library =:= [] ->
        ecc_library_server:reply(From, unicode:characters_to_list(["ECC ", Name], unicode)),
        Library;
       Library =/= [] ->
        ecc_library_server:reply(From, hd(Library)),
        tl(Library)
    end;

handle_call(terminate, From, Library) ->
    ecc_library_server:reply(From, ok),
    terminate(Library).
        
handle_cast({return, Book}, Library) ->
    [Book | Library].

terminate(Library) ->
    [io:format("~p was burnt.~n", [Name]) || Name <- Library],
    exit(normal).