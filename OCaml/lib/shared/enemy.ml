open Constants

module Enemy = struct
  type enemy = { 
    enemy_level: int;
    enemy_hp: int;
    enemy_defense: int;
    enemy_attack: int;
    enemy_hit: int;
    enemy_flee: int;
    enemy_name: string;
  }

  type enemy_type = Golem of enemy | Goblin of enemy | Slime of enemy

  let calculate_golem_attack lv = lv * 10 + 40

  let rec make_enemy = function
    | 0 ->
      let level = Random.int Constants.max_golem_level in
      Golem { enemy_level = level;
        enemy_hp = level * 50 + 100;
        enemy_attack = calculate_golem_attack level;
        enemy_defense = level * 10 + 40;
        enemy_hit = Constants.golem_hit;
        enemy_flee = Constants.golem_flee;
        enemy_name = "ゴーレム"
      }
    | 1 ->
      let level = Random.int Constants.max_goblin_level in
      Goblin { enemy_level = level;
        enemy_hp = level * 30 + 75;
        enemy_attack = level * 5 + 20;
        enemy_defense = level * 5 + 20;
        enemy_hit = Constants.goblin_hit;
        enemy_flee = Constants.goblin_flee;
        enemy_name = "ゴブリン"
      }
    | 2 ->
      let level = Random.int Constants.max_slime_level in
      Slime { enemy_level = level;
        enemy_hp = level * 10 + 50;
        enemy_attack = level * 2 + 10;
        enemy_defense = level * 2 + 10;
        enemy_hit = Constants.slime_hit;
        enemy_flee = Constants.slime_flee;
        enemy_name = "スライム"
      }
    | _ -> make_enemy 0
end