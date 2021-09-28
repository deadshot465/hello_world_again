module K08_Adventure = struct
  type golem = { hp: int; defense: int; attack: int }
  type attack_method = Attack of int | Skill of int | Magic of int
  type progress_result
    = End of string
    | Continue of int

  let select_attack choice =
    match choice with
    | 1 -> Attack (65 + Random.int 36)
    | 2 -> Skill (50 + Random.int 101)
    | 3 -> Magic (33 + Random.int 168)
    | _ -> Attack (65 + Random.int 36)

  let rec battle_loop golem_level golem player_hp =
    match golem.hp with
    | 0 ->
      Printf.printf "ゴーレムLv.%dを倒した！\n" (golem_level + 1);
      Continue player_hp
    | _ ->
      Printf.printf "ゴーレムLv.%d残りHP：%d\n" (golem_level + 1) golem.hp;
      print_string "武器を選択してください（１．攻撃　２．特技　３．魔法）＞";
      let base_damage = match select_attack (read_int()) with
                        | Attack damage -> damage
                        | Skill damage -> damage
                        | Magic damage -> damage in
      let actual_damage = if base_damage - golem.defense <= 0 then 0 else base_damage - golem.defense in
      Printf.printf "ダメージは%dです。\n" actual_damage;
      match actual_damage with
      | x when x <= 0 ->
        print_endline "ゴーレム：「ハハハハハ、情けないな！貴様は弱すぎる！」";
        Printf.printf "ゴーレムがあなたを攻撃しました！攻撃値：%d\n" golem.attack;
        let new_player_hp = player_hp - golem.attack in
        (match new_player_hp with
          | y when y <= 0 -> End "あなたはゴーレムに負けました！"
          | _ ->
            Printf.printf "あなたの残りHPは：%d\n" new_player_hp;
            battle_loop golem_level { hp = golem.hp; defense = golem.defense; attack = golem.attack } new_player_hp)
      | _ ->
        let new_golem_hp = if golem.hp - actual_damage <= 0 then 0 else golem.hp - actual_damage in
        battle_loop golem_level { hp = new_golem_hp; defense = golem.defense; attack = golem.attack } player_hp

  let engage_battle player_hp =
    let golem_level = Random.int 10 in
    let golem = { hp = golem_level * 50 + 100; attack = golem_level * 10 + 30; defense = golem_level * 10 + 40 } in
    Printf.printf "ゴーレムLv.%dが現れた！\n" (golem_level + 1);
    battle_loop golem_level golem player_hp

  let rec game_loop player_hp =
    match player_hp with
    | 0 -> "ゲームオーバー！"
    | _ ->
      Printf.printf "あなたのHP：%d\n" player_hp;
      print_endline "奥に進みますか？（１：奥に進む　０．帰る）＞";
      match read_int() with
      | 0 -> "リレ〇ト！"
      | _ ->
        (match engage_battle player_hp with
          | End msg ->
              print_endline msg;
              game_loop 0
          | Continue player_hp' -> game_loop player_hp')
end