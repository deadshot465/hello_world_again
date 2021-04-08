defmodule K03 do
  defp question_1 do
    age = IO.gets("年齢を入力してください。＞") |> String.trim() |> String.to_integer()
    if age < 20 do
      IO.puts("未成年なので購入できません。")
    end
  end

  defp question_2 do
    height = IO.gets("身長を入力してください。＞")
    |> String.trim()
    |> String.to_float()
    height = height / 100.0

    weight = IO.gets("体重を入力してください。＞")
    |> String.trim()
    |> String.to_float()

    standard = height * height * 22.0
    IO.puts("あなたの標準体重は#{standard}です。")

    cond do
      weight > standard && (weight - standard) / standard * 100.0 > 14.0 ->
        IO.puts("太り気味です。")
      weight < standard && (weight - standard) / standard * 100.0 < -14.0 ->
        IO.puts("痩せ気味です。")
      true -> IO.puts("普通ですね。")
    end
  end

  defp question_3 do
    random_number = Enum.random(0..99)
    IO.puts("０から９９の範囲の数値が決定されました。")
    guess = IO.gets("決められた数値を予想し、この数値よりも大きな値を入力してください＞")
    |> String.trim()
    |> String.to_integer()

    IO.puts("決められた数値は#{random_number}です。")
    IO.puts(if guess > random_number do
      "正解です。"
    else
      "不正解です。"
    end)
  end

  defp question_4 do
    random_number = Enum.random(0..99)
    IO.puts("０から９９の範囲の数値が決定されました。")
    guess = IO.gets("決められた数値を予想し、この数値よりも大きな値を入力してください＞")
    |> String.trim()
    |> String.to_integer()

    IO.puts("決められた数値は#{random_number}です。")
    IO.puts(cond do
      guess < 0 || guess > 99 -> "反則です！"
      guess > random_number && guess - random_number <= 10 -> "大正解です！"
      guess < random_number && random_number - guess <= 10 -> "惜しい！"
      guess == random_number -> "お見事！"
      true -> if guess > random_number do
        "正解です。"
      else
        "不正解です。"
      end
    end)
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
