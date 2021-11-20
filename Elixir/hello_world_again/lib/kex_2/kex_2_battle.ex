defmodule Kex2_Battle do
  @spec select_attack(any) ::
          {:attack, number, 110} | {:magic, number, 70} | {:skill, number, 100}
  def select_attack(1), do: {:attack, Enum.random(0..40) + 60, Constants.attack_hit}
  def select_attack(2), do: {:skill, Enum.random(0..100) + 30, Constants.skill_hit}
  def select_attack(3), do: {:magic, Enum.random(0..180) + 20, Constants.magic_hit}
  def select_attack(_), do: select_attack(1)

  @spec check_hit_or_miss(any) :: boolean
  def check_hit_or_miss(hit), do: Enum.random(0..100) < hit

  def damage_enemy(attack_method, enemy) do
    {_, dmg, hit} = attack_method
    hit_or_miss = check_hit_or_miss(hit)
    if hit_or_miss do
      actual_damage = if dmg - enemy.defense < 0 do
        0
      else
        dmg - enemy.defense
      end
      IO.puts("#{actual_damage}のダメージ！")
      new_enemy_hp = if enemy.hp - actual_damage < 0 do
        0
      else
        enemy.hp - actual_damage
      end
      Enemy.new(enemy.level, enemy.name, new_enemy_hp, enemy.defense, enemy.attack, enemy.flee, enemy.hit)
    else
      IO.puts("攻撃を外した！")
      enemy
    end
  end

  def damage_player(enemy, player) do
    hit_or_miss = check_hit_or_miss(enemy.hit)
    if hit_or_miss do
      injury = if enemy.attack - player.defense < 0 do
        0
      else
        enemy.attack - player.defense
      end
      IO.puts("#{injury}のダメージ！")
      new_player_hp = if player.hp - injury < 0 do
        0
      else
        player.hp - injury
      end
      Player.new(new_player_hp, player.defense)
    else
      IO.puts("攻撃を外した！")
      player
    end
  end

  def battle_loop(enemy, player) when enemy.hp <= 0 do
    IO.puts("#{enemy.name}Lv.#{enemy.level}を倒した！")
    {:continue, player}
  end

  def battle_loop(enemy, player) when player.hp <= 0 do
    IO.puts("あなたは#{enemy.name}に負けました！")
    {:end, "ゲームオーバー！"}
  end

  def battle_loop(enemy, player) do
    IO.puts("#{enemy.name} 残りHP：#{enemy.hp}")
    choice = IO.gets("武器を選択してください（１．攻撃　２．特技　３．魔法）＞")
    |> String.trim()
    |> String.to_integer()
    attack_method = select_attack(choice)
    new_enemy = damage_enemy(attack_method, enemy)
    IO.puts("#{enemy.name}の攻撃！")
    new_player = damage_player(enemy, player)
    if new_player.hp > 0 do
      IO.puts("プレイヤー残りHP：#{new_player.hp}")
      battle_loop(new_enemy, new_player)
    else
      battle_loop(new_enemy, new_player)
    end
  end

  def engage_battle(enemy, player) do
    IO.puts("#{enemy.name}Lv.#{enemy.level}が現れた！")
    battle_loop(enemy, player)
  end

  def game_loop(player, kills, choice) when choice == 0 or player.hp <= 0 do
    "リ〇ミト！\n戦闘回数：#{kills}回　残りHP：#{player.hp}"
  end
  def game_loop(player, kills, _) do
    IO.puts("\n現HP：#{player.hp}")
    choice = IO.gets("奥に進みますか？（１：奥に進む　０．帰る）＞")
    |> String.trim()
    |> String.to_integer()
    case choice do
      0 ->
        game_loop(player, kills, choice)
      _ ->
        ordinal = Enum.random(0..2)
        {_, enemy} = Enemy.make_enemy(ordinal)
        case engage_battle(enemy, player) do
          {:end, s} ->
            IO.puts(s)
            game_loop(Player.new(0, player.defense), kills, 0)
          {:continue, p} ->
            game_loop(p, kills + 1, 1)
        end
    end
  end
end
