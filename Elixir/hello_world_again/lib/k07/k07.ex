defmodule K07 do
  defp show_texts do
    IO.puts("Hello World!")
    IO.puts("ようこそ")
    IO.puts("Elixirの世界へ！")
  end

  defp question_1_loop(0), do: :ok
  defp question_1_loop(_) do
    show_texts()
    question_1_loop(IO.gets("メッセージを表示しますか？（０：終了する　１：表示する）＞") |> String.trim() |> String.to_integer())
  end

  defp question_1 do
    choice = IO.gets("メッセージを表示しますか？（０：終了する　１：表示する）＞")
    |> String.trim()
    |> String.to_integer()
    question_1_loop(choice)
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
    numbers = get_numbers(3)
    count = Enum.count(numbers)
    max_value = Enum.max(numbers)
    IO.puts("#{count}つの中で最大値は#{max_value}")
  end

  defp get_age_tier(age) do
    cond do
      age <= 0 -> :error
      age < 3 || age >= 70 -> :free
      age >= 3 && age <= 15 -> :half
      age >= 60 && age < 70 -> :ten_percent_off
      true -> :normal
    end
  end

  defp question_3 do
    age = IO.gets("年齢を入力して下さい。＞")
    |> String.trim()
    |> String.to_integer()
    IO.puts(case get_age_tier(age) do
      :error -> "不適切な値が入力されました。"
      :free -> "入場料金無料です。"
      :half -> "子供料金で半額です。"
      :ten_percent_off -> "シニア割引で１割引きです。"
      _ -> "通常料金です。"
    end)
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
