open Shared.Constants
open Shared.Enemy
open Shared.Player

module Kex_2_Battle = struct
  type attack_method
    = Attack of int * int
    | Skill of int * int
    | Magic of int * int

  type progress_result
    = End of string
    | Continue of Player.player

  let rec select_attack = function
    | 1 -> Attack ((Random.int 41) + 60, Constants.attack_hit)
    | 2 -> Skill ((Random.int 101) + 30, Constants.skill_hit)
    | 3 -> Magic ((Random.int 181) + 20, Constants.magic_hit)
    | _ -> select_attack 1

  let check_hit_or_miss hit = Random.int 101 < hit

  let extract_enemy_data enemy =
    match enemy with
    | Enemy.Golem e -> e
    | Enemy.Goblin e -> e
    | Enemy.Slime e -> e

  let damage_enemy attack_method (enemy: Enemy.enemy): Enemy.enemy =
    let (dmg, hit) = match attack_method with
      | Attack (d, h) -> (d, h)
      | Skill (d, h) -> (d, h)
      | Magic (d, h) -> (d, h) in
    let hit_or_miss = check_hit_or_miss (hit - enemy.enemy_flee) in
    if hit_or_miss then
      let actual_damage = if dmg - enemy.enemy_defense < 0 then 0 else enemy.enemy_defense in
      Printf.printf "%dのダメージ！\n" actual_damage;
      let new_enemy_hp = if (enemy.enemy_hp - actual_damage) < 0 then 0 else enemy.enemy_hp - actual_damage in
      { enemy_level = enemy.enemy_level;
        enemy_hp = new_enemy_hp;
        enemy_defense = enemy.enemy_defense;
        enemy_attack = enemy.enemy_attack;
        enemy_hit = enemy.enemy_hit;
        enemy_flee = enemy.enemy_flee;
        enemy_name = enemy.enemy_name;
      }
    else begin
      print_endline "攻撃を外した！";
      enemy
    end
  
  let damage_player (enemy: Enemy.enemy) (player: Player.player): Player.player =
    let hit_or_miss = check_hit_or_miss enemy.enemy_hit in
    if hit_or_miss then
      let injury = if enemy.enemy_attack - player.player_defense < 0 then 0 else enemy.enemy_attack - player.player_defense in
      Printf.printf "%dのダメージ！\n" injury;
      let new_player_hp = if player.player_hp - injury < 0 then 0 else player.player_hp - injury in
      { player_hp = new_player_hp;
        player_defense = player.player_defense
      }
    else begin
      print_endline "攻撃を外した！";
      player
    end

  let rec battle_loop (enemy: Enemy.enemy) player =
    if enemy.enemy_hp <= 0 then
      (Printf.printf "%sLv.%dを倒した！\n" enemy.enemy_name (enemy.enemy_level + 1);
      Continue player)
    else begin
      match player.player_hp with
      | x when x <= 0 ->
        (Printf.printf "あなたは%sに負けました！\n" enemy.enemy_name;
        End "ゲームオーバー！")
      | _ ->
        Printf.printf "%s 残りHP：%d\n" enemy.enemy_name enemy.enemy_hp;
        print_string "武器を選択してください（１．攻撃　２．特技　３．魔法）＞";
        let choice = read_int () in
        let attack_method = select_attack choice in
        let new_enemy = damage_enemy attack_method enemy in
        Printf.printf "%sの攻撃！\n" enemy.enemy_name;
        let new_player = damage_player enemy player in
        if new_player.player_hp > 0 then
          (Printf.printf "プレイヤー残りHP：%d\n" new_player.player_hp;
          battle_loop new_enemy new_player)
        else begin
          battle_loop new_enemy new_player
        end
    end

  let engage_battle (enemy: Enemy.enemy) player =
    Printf.printf "%sLv.%dが現れた！\n" enemy.enemy_name (enemy.enemy_level + 1);
    battle_loop enemy player

  let game_loop player =
    let rec inner_loop (player': Player.player) kills choice =
      match choice with
      | 0 -> Printf.sprintf "リ〇ミト！\n戦闘回数：%d回　残りHP：%d" kills player'.player_hp
      | _ when player'.player_hp <= 0 -> inner_loop player' kills 0
      | _ -> (
        Printf.printf "\n現HP：%d\n" player'.player_hp;
        print_string "奥に進みますか？（１：奥に進む　０．帰る）＞";
        let choice' = read_int () in
        match choice' with
        | 0 -> inner_loop player' kills choice'
        | _ -> (
          let ordinal = Random.int 3 in
          let enemy = Enemy.make_enemy ordinal in
          let result = engage_battle (extract_enemy_data enemy) player' in
          match result with
          | End s -> (
            print_endline s;
            inner_loop { player_hp = 0; player_defense = player'.player_defense } kills 0
          )
          | Continue p -> inner_loop p (kills + 1) 1
        )
      )
    in
    inner_loop player 0 1
end