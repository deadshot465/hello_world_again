defmodule K08 do
  defp question_1 do
    numbers = get_numbers(3)
    count = Enum.count(numbers)
    IO.puts("どちらを調べますか？")
    choice = IO.gets("（０：最大値　１：最小値）＞")
    |> String.trim() |> String.to_integer()
    result = if choice == 0 do
      Enum.max(numbers)
    else
      Enum.min(numbers)
    end
    text = if choice == 0 do
      "最大値"
    else
      "最小値"
    end
    IO.puts("#{count}つの中で#{text}は#{result}")
  end

  defp get_numbers_loop(acc, _, 0), do: acc
  defp get_numbers_loop(acc, no, count) do
    num = IO.gets("#{no + 1}つ目の値を入力してください。＞")
    |> String.trim()
    |> String.to_integer()
    get_numbers_loop([num|acc], no + 1, count - 1)
  end

  defp get_numbers(count) do
    get_numbers_loop([], 0, count)
  end

  defp question_2 do
    IO.puts("冒険が今始まる！")
    player_hp = 200 + Enum.random(0..100)
    IO.puts(K08_Adventure.game_loop(player_hp))
  end

  defp question_3 do
    :noop
  end

  defp question_4 do
    :noop
  end

  @spec execute(any) :: :noop | :ok
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
