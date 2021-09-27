defmodule K08_Adventure do
  @spec select_attack(any) :: {:attack, number} | {:magic, number} | {:skill, number}
  def select_attack(1), do: {:attack, 65 + Enum.random(0..35)}
  def select_attack(2), do: {:skill, 50 + Enum.random(0..100)}
  def select_attack(3), do: {:magic, 33 + Enum.random(0..167)}
  def select_attack(_), do: select_attack(1)

  @spec damage_player(number, number) :: number
  def damage_player(golem_attack, player_hp) do
    IO.puts("ゴーレム：「ハハハハハ、情けないな！貴様は弱すぎる！」")
    IO.puts("ゴーレムがあなたを攻撃しました！攻撃値：#{golem_attack}")
    new_player_hp = if player_hp - golem_attack <= 0 do
      0
    else
      player_hp - golem_attack
    end
    new_player_hp
  end

  @spec battle_loop(integer(), Golem.t(), integer()) ::
          {:continue, integer()} | {:end, String.t()}
  def battle_loop(golem_level, golem, player_hp) do
    if golem.hp <= 0 do
      IO.puts("ゴーレムLv.#{golem_level}を倒した！")
      {:continue, player_hp}
    else
      IO.puts("ゴーレムLv.#{golem_level}残りHP：#{golem.hp}")
      choice = IO.gets("武器を選択してください（１．攻撃　２．特技　３．魔法）＞")
      |> String.trim() |> String.to_integer()

      base_damage = case select_attack(choice) do
        {:attack, dmg} -> dmg
        {:skill, dmg} -> dmg
        {:magic, dmg} -> dmg
      end

      actual_damage = if base_damage - golem.defense <= 0 do
        0
      else
        base_damage - golem.defense
      end

      IO.puts("ダメージは#{actual_damage}です。")
      if actual_damage <= 0 do
        new_player_hp = damage_player(golem.attack, player_hp)
        if new_player_hp <= 0 do
          {:end, "あなたはゴーレムに負けました！"}
        else
          IO.puts("あなたの残りHPは：#{new_player_hp}")
          battle_loop(golem_level, Golem.new(golem.hp, golem.defense, golem.attack), new_player_hp)
        end
      else
        new_golem_hp = if golem.hp - actual_damage <= 0 do
          0
        else
          golem.hp - actual_damage
        end
        battle_loop(golem_level, Golem.new(new_golem_hp, golem.defense, golem.attack), player_hp)
      end
    end
  end

  @spec engage_battle(integer()) :: {:continue, integer()} | {:end, String.t()}
  def engage_battle(player_hp) do
    golem_level = Enum.random(1..10)
    golem = Golem.new(golem_level * 50 + 100, golem_level * 10 + 40, golem_level * 10 + 30)
    IO.puts("ゴーレムLv.#{golem_level}が現れた！")
    battle_loop(golem_level, golem, player_hp)
  end

  @spec game_loop(integer()) :: String.t()
  def game_loop(0), do: "ゲームオーバー！"
  def game_loop(player_hp) do
    IO.puts("あなたのHP：#{player_hp}")
    choice = IO.gets("奥に進みますか？（１：奥に進む　０．帰る）＞")
    |> String.trim()
    |> String.to_integer()
    if choice == 0 do
      "リレ〇ト！"
    else
      case engage_battle(player_hp) do
        {:end, msg} ->
          IO.puts(msg)
          game_loop(0)
        {:continue, hp} -> game_loop(hp)
      end
    end
  end
end
