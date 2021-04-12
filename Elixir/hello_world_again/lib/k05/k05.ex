defmodule K05 do
  defp q1_loop(salary, age) do
    cond do
      salary < 50.0 ->
        q1_loop(salary * 1.035, age + 1)
      true ->
        IO.puts("#{age}歳で月給#{salary}万円")
    end
  end

  defp question_1 do
    salary = 19.0
    age = 22
    q1_loop(salary, age)
  end

  defp q2_loop(choice) do
    cond do
      choice != 1 ->
        IO.puts("起きろ～")
        new_choice = IO.gets("1．起きた　2．あと5分…　3．Zzzz…\t入力：")
        |> String.trim()
        |> String.to_integer()
        q2_loop(new_choice)
      true -> IO.puts("よし、学校へ行こう！")
    end
  end

  defp question_2 do
    q2_loop(0)
  end

  defp q3_loop(choice) do
    cond do
      choice != 1 ->
        IO.puts("起きろ～")
        new_choice = IO.gets("1．起きた　2．あと5分…　3．Zzzz…\t入力：")
        |> String.trim()
        |> String.to_integer()
        q3_loop(new_choice)
      true ->
        IO.puts("よし、学校へ行こう！")
        q3_loop(0)
    end
  end

  defp question_3 do
    q3_loop(0)
  end

  defp input_damage(choice) do
    case choice do
      1 -> 60 + Enum.random(0..40)
      2 -> 30 + Enum.random(0..100)
      3 -> 20 + Enum.random(0..180)
      _ ->
        input_damage(IO.gets("攻撃手段を選択してください（1．攻撃　2．特技　3．魔法）＞") |> String.trim() |> String.to_integer())
    end
  end

  defp q4_loop(golem, player_hp) do
    cond do
      golem.hp == 0 && player_hp != 0 ->
        IO.puts("ゴーレムを倒しました！")
      golem.hp != 0 && player_hp == 0 ->
        IO.puts("あなたはゴーレムに負けました！ゲームオーバー！")
      true ->
        IO.puts("ゴーレム残りHP：#{golem.hp}")
        damage = input_damage(0)
        IO.puts("基礎攻撃力は#{damage}です。")
        damage = if damage - golem.defense <= 0 do
          0
        else
          damage - golem.defense
        end

        case damage do
          0 ->
            IO.puts("ゴーレム：「ハハハハハ、情けないな！貴様は弱すぎる！」")
            IO.puts("ゴーレムがあなたを攻撃しました！攻撃値：#{golem.attack}")
            remaining_hp = if player_hp - golem.attack < 0 do
              0
            else
              player_hp - golem.attack
            end
            IO.puts("あなたの残りHPは：#{remaining_hp}")
            q4_loop(golem, remaining_hp)
          _ ->
            IO.puts("ダメージは#{damage}です。")
            golem_remaining_hp = if golem.hp - damage < 0 do
              0
            else
              golem.hp - damage
            end
            IO.puts("残りのHPは#{golem_remaining_hp}です。")
            q4_loop(Golem.new(golem_remaining_hp), player_hp)
        end
    end
  end

  defp question_4 do
    golem = Golem.new(300 + Enum.random(0..200))
    player_hp = 200 + Enum.random(0..100)
    IO.puts("ゴーレム　（HP：#{golem.hp}　防御力：#{golem.defense}）")
    q4_loop(golem, player_hp)
  end

  @spec execute(integer()) :: :noop | :ok
  def execute(num) do
    case num do
      1 -> question_1()
      2 -> question_2()
      3 -> question_3()
      4 -> question_4()
      _ -> :noop
    end
  end
end
