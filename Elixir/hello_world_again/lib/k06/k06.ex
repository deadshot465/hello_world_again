defmodule K06 do
  @spec input_age(integer(), non_neg_integer(), list(integer())) :: list(integer())
  def input_age(no, amount, acc) do
    case amount do
      0 -> acc
      _ ->
        input_age(no + 1, amount - 1, [IO.gets("#{no + 1}人目の年齢を入力して下さい：")
        |> String.trim()
        |> String.to_integer() | acc])
    end
  end

  @spec get_ages(non_neg_integer) :: [integer]
  def get_ages(n) do
    input_age(0, n, [])
  end
  def question_1 do
    ages = get_ages(5)
    count = Enum.count(ages)
    total_ages = List.foldl(ages, 0, fn (elem, acc) -> elem + acc end)
    IO.puts("#{count}人の平均年齢は#{total_ages / count}です。")
  end

  @spec upper_pyramid_make(integer(), non_neg_integer(), list(String.t())) :: list(String.t())
  def upper_pyramid_make(current, levels, acc) do
    case levels do
      0 ->
        acc
      _ ->
        upper_pyramid_make(current + 1, levels - 1, [String.duplicate("*", current + 1) | acc])
    end
  end

  @spec make_upper_pyramid(non_neg_integer()) :: list(String.t())
  def make_upper_pyramid(levels) do
    upper_pyramid_make(0, levels, []) |> Enum.reverse()
  end

  @spec lower_pyramid_make(non_neg_integer(), list(String.t())) :: list(String.t())
  def lower_pyramid_make(levels, acc) do
    case levels do
      0 ->
        acc
      _ ->
        lower_pyramid_make(levels - 1, [String.duplicate("*", levels) | acc])
    end
  end

  @spec make_lower_pyramid(non_neg_integer()) :: list(String.t())
  def make_lower_pyramid(levels) do
    lower_pyramid_make(levels, []) |> Enum.reverse()
  end

  @spec special_pyramid_make(non_neg_integer(), non_neg_integer(), list(String.t())) :: list(String.t())
  def special_pyramid_make(amount_of_stars, amount_of_spaces, acc) do
    case amount_of_stars do
      0 ->
        acc
      _ ->
        special_pyramid_make(amount_of_stars - 1, amount_of_spaces + 1, [(String.duplicate(" ", amount_of_spaces) <> String.duplicate("*", amount_of_stars)) | acc])
    end
  end

  @spec make_special_pyramid(non_neg_integer()) :: [String.t()]
  def make_special_pyramid(levels) do
    special_pyramid_make(levels, 0, [])
  end

  def question_2 do
    make_upper_pyramid(8) |> Enum.join("\n") |> IO.puts()
    IO.puts("")
    make_lower_pyramid(8) |> Enum.join("\n") |> IO.puts()
    IO.puts("")
    make_special_pyramid(8) |> Enum.join("\n") |> IO.puts()
  end

  @spec count_tens(integer) :: integer
  def count_tens(remains) do
    div(remains, 10)
  end

  @spec count_fifties(integer(), integer(), list(tuple())) :: list(tuple())
  def count_fifties(amount, remains, arr) do
    cond do
      amount < 0 -> arr
      true -> count_fifties(amount - 1, remains, [{amount, count_tens(remains - (50 * amount))} | arr])
    end
  end

  @spec count_hundreds(integer(), integer(), [tuple()]) :: [tuple()]
  def count_hundreds(amount, remains, arr) do
    cond do
      amount < 0 -> arr
      true ->
        inner_remains = remains - (100 * amount)
        inner_arr = count_fifties(div(inner_remains, 50), inner_remains, []) |> Enum.map(fn {x, y} -> {amount, x, y} end)
        count_hundreds(amount - 1, remains, inner_arr ++ arr)
    end
  end

  @spec count_combinations(integer) :: [tuple]
  def count_combinations(amount) do
    count_hundreds(div(amount, 100), amount, [])
  end

  def question_3 do
    combinations = count_combinations(370) |> Enum.map(fn {x, y, z} -> "10円の硬貨#{z}枚 50円の硬貨#{y}枚 100円の硬貨#{x}枚\n" end)
    Enum.join(combinations, "\n") |> IO.puts()
    IO.puts("\n以上#{Enum.count(combinations)}通りを発見しました。\n")
  end

  @spec print_one_to_ten(non_neg_integer, [integer()]) :: [integer()]
  def print_one_to_ten(num, arr) do
    case num do
      0 ->
        arr
      _ ->
        print_one_to_ten(num - 1, [num | arr])
    end
  end

  @spec multiplications(integer(), non_neg_integer(), [integer()]) :: [integer()]
  def multiplications(i, j, arr) do
    case j do
      0 ->
        arr
      _ ->
        multiplications(i, j - 1, [i * j | arr])
    end
  end

  @spec calculations(non_neg_integer(), [[integer()]]) :: [[integer()]]
  def calculations(i, arr) do
    case i do
      0 ->
        arr
      _ ->
        calculations(i - 1, [multiplications(i, 9, []) | arr])
    end
  end

  def question_4 do
    IO.write("\t|\t")
    print_one_to_ten(9, [])
    |> Enum.map(fn x -> "#{x}" end)
    |> Enum.join("\t")
    |> IO.puts()

    IO.puts(String.duplicate("-", 90))

    calculations(9, [])
    |> Enum.with_index()
    |> Enum.map(fn {x, i} ->
      inner_list = Enum.map(x, fn y -> "#{y}" end) |> Enum.join("\t")
      "#{i + 1}\t|\t#{inner_list}"
    end)
    |> Enum.join("\n")
    |> IO.puts()
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
