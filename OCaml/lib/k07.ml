open Question

module K07 : Question = struct
  let show_texts () =
    print_endline "Hello World!";
    print_endline "ようこそ";
    print_endline "OCamlの世界へ！"

  let question_1 () =
    let rec loop = function
      | 0 -> ()
      | _ ->
        show_texts ();
        print_endline "メッセージを表示しますか？（０：終了する　１：表示する）＞";
        loop (read_int());
    in
    print_endline "メッセージを表示しますか？（０：終了する　１：表示する）＞";
    loop (read_int())

  let get_numbers count =
    let rec loop acc no count' =
      match count' with
      | 0 -> acc
      | _ ->
        Printf.printf "%dつ目の値を入力してください。＞" (no + 1);
        loop (read_int() :: acc) (no + 1) (count' - 1)
    in
    loop [] 0 count

  let question_2 () =
    let numbers = get_numbers 3 in
    let count = List.length numbers in
    let max_value = List.fold_right (fun x acc -> max x acc) numbers (List.nth numbers 0) in
    Printf.printf "%dつの中で最大値は%d\n" count max_value

  type age_tier = Error | Free | Half | TenPercentOff | Normal

  let get_type = function
    | x when x <= 0 -> Error
    | x when x < 3 || x >= 70 -> Free
    | x when x >= 3 && x <= 15 -> Half
    | x when x >= 60 && x < 70 -> TenPercentOff
    | _ -> Normal

  let question_3 () =
    print_string "年齢を入力して下さい。＞";
    print_endline (match get_type (read_int()) with
                    | Error -> "不適切な値が入力されました。"
                    | Free -> "入場料金無料です。"
                    | Half -> "子供料金で半額です。"
                    | TenPercentOff -> "シニア割引で１割引きです。"
                    | _ -> "通常料金です。")

  let question_4 () = 
    ()
end