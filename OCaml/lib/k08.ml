open Question

module K08 : Question = struct
  let get_numbers count =
    let rec loop acc no count' =
      match count' with
      | 0 -> acc
      | _ ->
        Printf.printf "%dつ目の値を入力してください。＞" (no + 1);
        loop (read_int() :: acc) (no + 1) (count' - 1)
    in
    loop [] 0 count

  let question_1 () =
    let numbers = get_numbers 3 in
    let count = List.length numbers in
    print_endline "どちらを調べますか？";
    print_string "（０：最大値　１：最小値）＞";
    match read_int() with
      | 0 ->
        let max_value = List.fold_right (fun x acc -> max x acc) numbers (List.nth numbers 0) in
        Printf.printf "%dつの中で最大値は%d\n" count max_value
      | _ ->
        let min_value = List.fold_right (fun x acc -> min x acc) numbers (List.nth numbers 0) in
        Printf.printf "%dつの中で最小値は%d\n" count min_value
  
  let question_2 () =
    Random.self_init ();
    print_endline "冒険が今始まる！";
    let player_hp = 200 + (Random.int 101) in
    print_endline (K08_adventure.K08_Adventure.game_loop player_hp)

  let question_3 () =
    ()

  let question_4 () = 
    ()
end