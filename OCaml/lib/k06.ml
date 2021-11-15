open Question

module K06 : Question = struct
  let get_ages n =
    let rec input_age no amount acc =
      match amount with
        0 -> acc
      | _ ->
        Printf.printf "%d人目の年齢を入力して下さい：" (no + 1);
        input_age (no + 1) (amount - 1) (read_int() :: acc)
    in input_age 0 n []

  let question_1 () =
    let ages = get_ages 5 in
    let count = List.length ages in
    let total_ages = List.fold_left (fun acc elem -> acc + elem) 0 ages in
    Printf.printf "%d人の平均年齢は%fです。" count ((float_of_int total_ages) /. (float_of_int count))

  let make_upper_pyramid levels =
    let rec make current levels' acc =
      match levels' with
        0 -> acc
      | _ -> make (current + 1) (levels' - 1) (String.make (current + 1) '*' :: acc)
    in make 0 levels [] |> List.rev

  let make_lower_pyramid levels =
    let rec make levels' acc =
      match levels' with
        0 -> acc
      | _ -> make (levels' - 1) (String.make levels' '*' :: acc)
    in make levels [] |> List.rev

  let make_special_pyramid levels =
    let rec make amount_of_stars amount_of_spaces acc =
      match amount_of_stars with
        0 -> acc
      | _ -> make (amount_of_stars - 1) (amount_of_spaces + 1) (((String.make amount_of_spaces ' ') ^ (String.make amount_of_stars '*')) :: acc)
    in make levels 0 []

  let question_2 () =
    make_upper_pyramid 8
    |> String.concat "\n"
    |> print_endline;

    print_newline ();

    make_lower_pyramid 8
    |> String.concat "\n"
    |> print_endline;

    print_newline ();

    make_special_pyramid 8
    |> String.concat "\n"
    |> print_endline

  let count_combinations amount =
    let count_tens remains = remains / 10 in
    let rec count_fifties amount remains arr =
      match amount with
        x when x < 0 -> arr
      | _ -> count_fifties (amount - 1) remains ((amount, (count_tens (remains - (50 * amount)))) :: arr)
    in
    let rec count_hundreds amount remains arr =
      match amount with
        x when x < 0 -> arr
      | _ ->
        let remains' = remains - (100 * amount) in
        let arr' = count_fifties (remains' / 50) remains' []
                   |> List.map (fun (x, y) -> (amount, x, y)) in
        count_hundreds (amount - 1) remains (arr' @ arr)
    in
    count_hundreds (amount / 100) amount []

  let question_3 () =
    let combinations = count_combinations 370
                       |> List.map (fun (x, y, z) -> Printf.sprintf "10円の硬貨%d枚 50円の硬貨%d枚 100円の硬貨%d枚\n" z y x) in
    String.concat "\n" combinations |> print_endline;
    Printf.printf "\n以上%d通りを発見しました。\n" (List.length combinations)

  let question_4 () =
    print_string "\t|\t";
    let rec print_one_to_ten num arr =
      match num with
        0 -> arr
      | _ -> print_one_to_ten (num - 1) (num :: arr)
    in

    print_one_to_ten 9 []
    |> List.map (fun x -> string_of_int x)
    |> String.concat "\t"
    |> print_endline;

    print_endline (String.make 90 '-');

    let rec calculations i arr =
      let rec multiplications j arr =
        match j with
          0 -> arr
        | _ -> multiplications (j - 1) (i * j :: arr)
      in
      match i with
        0 -> arr
      | _ -> calculations (i - 1) (multiplications 9 [] :: arr)
    in

    calculations 9 []
    |> List.mapi (fun i x ->
        let inner_list = List.map (fun y -> string_of_int y) x
                         |> String.concat "\t" in
        Printf.sprintf "%d\t|\t%s" (i + 1) inner_list)
    |> String.concat "\n"
    |> print_endline
end