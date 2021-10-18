defmodule K09 do
  defp question_1 do
    ages = K06.get_ages(3)
    IO.puts(String.duplicate("-", 90))
    count = length(ages)
    sum = Enum.sum(ages)
    Enum.with_index(ages, fn elem, index ->
      IO.puts("#{index + 1}人目：#{elem}歳")
    end)
    IO.puts("平均年齢：#{sum / count}歳")
  end

  defp question_2 do
    numbers = [8, 3, 12, 7, 9]
    IO.write("元々の配列：")
    Enum.each(numbers, fn x -> IO.write("#{x} ") end)
    IO.write("\n逆順での表示：")
    Enum.each(Enum.reverse(numbers), fn x -> IO.write("#{x} ") end)
  end

  defp question_3 do
    IO.puts("")
    student_scores = [[52, 71, 61, 47], [6, 84, 81, 20], [73, 98, 94, 95]]
    IO.puts("\t|\t科目A\t科目B\t科目C\t科目D")
    IO.puts(String.duplicate("-", 66))
    Enum.with_index(student_scores, fn elem, index ->
      IO.write("学生#{index + 1}\t|\t")
      Enum.each(elem, fn x -> IO.write("#{x}\t") end)
      IO.puts("")
    end)
  end

  defp question_4 do
    IO.puts("")
    student_scores = [[52, 71, 61, 47], [6, 84, 81, 20], [73, 98, 94, 95]]
    with_sum = Enum.map(student_scores, fn scores ->
      sum = Enum.sum(scores)
      scores ++ [sum]
    end)
    IO.puts("\t|\t科目A\t科目B\t科目C\t科目D\t|\t合計点")
    IO.puts(String.duplicate("-", 66))
    Enum.with_index(with_sum, fn elem, index ->
      IO.write("学生#{index + 1}\t|\t")
      last = List.last(elem)
      Enum.each(elem, fn score ->
        if score == last do
          IO.write("|\t#{score}\t")
        else
          IO.write("#{score}\t")
        end
      end)
      IO.puts("")
    end)
    average = transform(with_sum, [0, 0, 0, 0, 0])
    last_average = List.last(average)
    IO.write("平均点\t|\t")
    Enum.each(average, fn x ->
      if x == last_average do
        IO.write("|\t#{x / length(student_scores)}\t")
      else
        IO.write("#{x / length(student_scores)}\t")
      end
    end)
  end

  defp question_5() do
    input = input_numbers(1, 0, [])
    IO.puts("----並び替え後----")
    Enum.each(Enum.sort(input), fn x -> IO.write("#{x} ") end)
  end

  defp transform([], acc), do: acc
  defp transform([student | xs], acc) do
    new_acc = Enum.with_index(acc, fn elem, index ->
      elem + Enum.at(student, index)
    end)
    transform(xs, new_acc)
  end

  defp input_numbers(n, choice, acc) when choice < 0 or n == 100, do: acc
  defp input_numbers(n, _, acc) do
    number = IO.gets("#{n}件目の入力：") |> String.trim() |> String.to_integer()
    input_numbers(n + 1, number, [number | acc])
  end

  @spec execute(any) :: :noop | :ok
  def execute(num) do
    case num do
      1 -> question_1()
      2 -> question_2()
      3 -> question_3()
      4 -> question_4()
      5 -> question_5()
      _ -> :noop
    end
  end
end
