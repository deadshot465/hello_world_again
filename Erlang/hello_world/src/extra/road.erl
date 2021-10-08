-module(road).
-compile(export_all).

-spec main() -> [{atom(), integer()}].
main() ->
    File = "road.txt",
    {ok, Binary} = file:read_file(File),
    optimal_path(parse_map(Binary)).

%% Transform a string into a readable map of triples
-spec parse_map(binary() | string()) -> [{integer(), integer(), integer()}].
parse_map(Binary) when is_binary(Binary) ->
    parse_map(binary_to_list(Binary));
parse_map(String) when is_list(String) ->
    Values = [list_to_integer(X) || X <- string:tokens(String, "\r\n\t ")],
    group_vals(Values, []).

-spec group_vals([integer()], [{integer(), integer(), integer()}]) -> [{integer(), integer(), integer()}].
group_vals([], Acc) ->
    lists:reverse(Acc);
group_vals([A, B, X | Rest], Acc) ->
    group_vals(Rest, [{A, B, X} | Acc]).

%% actual problem solving
%% change triples of the form {A,B,X}
%% where A,B,X are distances and a,b,x are possible paths
%% to the form {DistanceSum, PathList}.
-spec shortest_steps({integer(), integer(), integer()}, {{integer(), [{atom(), integer()}]}, {integer(), [{atom(), integer()}]}}) -> {{integer(), [{atom(), integer()}]}, {integer(), [{atom(), integer()}]}}.
shortest_steps({A, B, X}, {{DistA, PathA}, {DistB, PathB}}) ->
    OptA1 = {DistA + A, [{a, A} | PathA]},
    OptA2 = {DistB + B + X, [{x, X}, {b, B} | PathB]},
    OptB1 = {DistB + B, [{b, B} | PathB]},
    OptB2 = {DistA + A + X, [{x, X}, {a, A} | PathA]},
    {erlang:min(OptA1, OptA2), erlang:min(OptB1, OptB2)}.

%% Picks the best of all paths, woo!
-spec optimal_path([{integer(), integer(), integer()}]) -> [{atom(), integer()}].
optimal_path(Map) ->
    {A, B} = lists:foldl(fun shortest_steps/2, {{0, []}, {0, []}}, Map),
    {_Dist, Path} = if hd(element(2, A)) =/= {x, 0} -> A;
                       hd(element(2, B)) =/= {x, 0} -> B
    end,
    lists:reverse(Path).