defmodule K02 do
  defp question_1 do
    seisuu = 3
    jissuu = 2.6
    moji = 'A'
    IO.puts("変数seisuuの値は#{seisuu}")
    IO.puts("変数jissuuの値は#{jissuu}")
    IO.puts("変数mojiの値は#{moji}")
  end

  defp question_2 do
    number_1 = IO.gets("一つ目の整数は？") |> String.trim() |> String.to_integer()
    number_2 = IO.gets("二つ目の整数は？") |> String.trim() |> String.to_integer()
    IO.puts("#{number_1}÷#{number_2}=#{number_1 / number_2}...#{rem(number_1, number_2)}")
  end

  defp question_3 do
    price_A = IO.gets("一つ目の商品の値段は？") |> String.trim() |> String.to_integer()
    amount_A = IO.gets("個数は？") |> String.trim() |> String.to_integer()
    price_B = IO.gets("二つ目の商品の値段は？") |> String.trim() |> String.to_integer()
    amount_B = IO.gets("個数は？") |> String.trim() |> String.to_integer()

    total = (price_A * amount_A + price_B * amount_B) * 1.08
    IO.puts("お支払いは税込み￥#{total}です。")
  end

  defp question_4 do
    golem = Golem.new
    IO.puts("ゴーレム　（HP：#{golem.hp}　防御力：#{golem.defense}）")
    IO.puts("HP：#{golem.hp}")
    damage = IO.gets("今回の攻撃の値を入力してください＞") |> String.trim() |> String.to_integer()

    final_damage = if damage - golem.defense > 0 do
      damage - golem.defense
    else
      0
    end

    IO.puts("ダメージは#{final_damage}です。")
    golem = Golem.new(golem.hp - final_damage, golem.defense, golem.attack)
    IO.puts("残りのHPは#{golem.hp}です。")
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
