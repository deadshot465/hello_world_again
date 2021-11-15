open Question

module K02 : Question = struct
  let question_1 () =
    let seisuu = 3 in
    let jissuu = 2.6 in
    let moji = 'A' in
    print_endline ("変数seisuuの値は" ^ (string_of_int seisuu));
    print_endline ("変数jissuuの値は" ^ (string_of_float jissuu));
    print_endline ("変数mojiの値は" ^ (String.make 1 moji))

  let question_2 () =
    print_string "一つ目の整数は？";
    let number_1 = read_int() in
    print_string "二つ目の整数は？";
    let number_2 = read_int() in
    Printf.printf "%d÷%d=%d...%d" number_1 number_2 (number_1 / number_2) (number_1 mod number_2)

  let question_3 () =
    print_string "一つ目の商品の値段は？";
    let price_A = read_int() in
    print_string "個数は？";
    let amount_A = read_int() in
    print_string "二つ目の商品の値段は？";
    let price_B = read_int() in
    print_string "個数は？";
    let amount_B = read_int() in
    let total = float_of_int (price_A * amount_A + price_B * amount_B) |> ( *. ) 1.08 in
    print_endline ("お支払いは税込み￥" ^ (string_of_float total))

  type golem = { hp: int; defense: int; attack: int }

  let question_4 () =
    let golem = { hp = 300; defense = 80; attack = 50 } in
    Printf.printf "ゴーレム　（HP：%d　防御力：%d）\n" golem.hp golem.defense;
    print_endline ("HP：" ^ (string_of_int golem.hp));
    print_string "今回の攻撃の値を入力してください＞";
    let damage = read_int() in
    let final_damage = if damage - golem.defense > 0 then
        damage - golem.defense
      else
        0
    in
    Printf.printf "ダメージは%dです。" final_damage;
    let golem = { hp = golem.hp - final_damage; defense = 80; attack = 50 } in
    Printf.printf "残りのHPは%dです。" golem.hp
end