module Road = struct
  type route = {
    destination: int;
    path: (char * int) list
  }

  type routing_result = {
    a: route;
    b: route
  }

  let parse_map s =
    List.filter (fun s -> String.length s > 0 && s <> "") s
    |> List.map int_of_string

  let rec group_values acc = function
    | [] -> List.rev acc
    | a :: b :: x :: xs -> group_values ((a, b, x) :: acc) xs
    | _ -> List.rev acc

  let shortest_steps acc elem =
    let a, b, x = elem in
    let opt_a1 = { destination = acc.a.destination + a; path = ('a', a) :: acc.a.path  } in
    let opt_a2 = { destination = acc.b.destination + b + x; path = ('x', x) :: ('b', b) :: acc.b.path  } in
    let opt_b1 = { destination = acc.b.destination + b; path = ('b', b) :: acc.b.path  } in
    let opt_b2 = { destination = acc.a.destination + a + x; path = ('x', x) :: ('a', a) :: acc.a.path  } in
    { a = min opt_a1 opt_a2; b = min opt_b1 opt_b2 }

  let optimal_path values =
    let initial_result = { a = { destination = 0; path = [] }; b = { destination = 0; path = [] } } in
    let routing_result = List.fold_left shortest_steps initial_result values in
    let route = if (List.hd routing_result.a.path <> ('x', 0)) then routing_result.a
                else if (List.hd routing_result.b.path <> ('x', 0)) then routing_result.b
                else { destination = 0; path = [] } in
    List.rev route.path

  let run =
    let ic = open_in "../../../road.txt" in
    let rec loop acc =
      try
        let line = input_line ic in
        loop (line :: acc)
      with End_of_file ->
        close_in_noerr ic;
        List.rev acc
    in
    loop []
    |> List.map String.trim
    |> parse_map
    |> group_values []
    |> optimal_path
end