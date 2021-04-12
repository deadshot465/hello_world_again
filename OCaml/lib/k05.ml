open Question

module K05 : Question = struct
  let question_1 () =
    let salary = 19.0 in
    let age = 22 in
    let rec loop salary' age' =
      match salary' with
      x when x < 50.0 -> loop (salary' *. 1.035) (age' + 1)
      | _ -> Printf.printf "%d歳で月給%f万円\n" age' salary'
    in loop salary age

  let question_2 () =
    let rec loop = function
      x when x <> 1 ->
        print_endline "起きろ～";
        print_string "1．起きた　2．あと5分…　3．Zzzz…\t入力：";
        let choice' = read_int() in
        loop choice'
      | _ -> print_endline "よし、学校へ行こう！"
    in loop 0

  let question_3 () =
    let rec loop = function
      x when x <> 1 ->
        print_endline "起きろ～";
        print_string "1．起きた　2．あと5分…　3．Zzzz…\t入力：";
        let choice' = read_int() in
        loop choice'
      | _ ->
        print_endline "よし、学校へ行こう！";
        loop 0
    in loop 0

  type golem = { hp: int; defense: int; attack: int }

  let rec input_damage = function
    1 -> 60 + (Random.int 40)
    | 2 -> 30 + (Random.int 100)
    | 3 -> 20 + (Random.int 180)
    | _ ->
      print_endline "攻撃手段を選択してください（1．攻撃　2．特技　3．魔法）＞";
      input_damage (read_int())

  let question_4 () =
    Random.self_init();
    let golem = { hp = 300 + (Random.int 200); defense = 80; attack = 50 } in
    let player_hp = 200 + (Random.int 100) in
    Printf.printf "ゴーレム　（HP：%d　防御力：%d）\n" golem.hp golem.defense;

    let rec loop golem' player_hp' =
      match (golem'.hp, player_hp') with
        (x, y) when x = 0 && y <> 0 ->
          print_endline "ゴーレムを倒しました！"
        | (x, y) when x <> 0 && y = 0 ->
          print_endline "あなたはゴーレムに負けました！ゲームオーバー！"
        | (x, y) ->
          Printf.printf "ゴーレム残りHP：%d\n" x;
          let damage = input_damage 0 in
          Printf.printf "基礎攻撃力は%dです。\n" damage;
          let damage = if damage - golem'.defense <= 0 then 0 else damage - golem'.defense in
          match damage with
            0 ->
              print_endline "ゴーレム：「ハハハハハ、情けないな！貴様は弱すぎる！」";
              Printf.printf "ゴーレムがあなたを攻撃しました！攻撃値：%d\n" golem'.attack;
              let y' = if y - golem'.attack < 0 then 0 else (y - golem'.attack) in
              Printf.printf "あなたの残りHPは：%d\n" y';
              loop golem' y'
            | _ ->
              Printf.printf "ダメージは%dです。\n" damage;
              let x' = if x - damage < 0 then 0 else x - damage in
              Printf.printf "残りのHPは%dです。\n" x';
              loop ({ hp = x'; defense = golem'.defense; attack = golem'.attack }) y
    in loop golem player_hp
end