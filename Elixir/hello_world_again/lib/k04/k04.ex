defmodule K04 do
  defp question_1 do
    age = IO.gets("年齢を入力してください。＞") |> String.trim() |> String.to_integer()
    if age < 3 || age >= 70 do
      IO.puts("入場料金無料です。")
    else
      IO.puts("通常料金です。")
    end
  end

  defp question_2 do
    gender = IO.gets("性別を選択してください。（０：男性　１：女性）＞")
    |> String.trim()
    |> String.to_integer()

    case gender do
      0 -> IO.puts("あら、格好良いですね。")
      1 -> IO.puts("あら、モデルさんみたいですね。")
      _ -> IO.puts("そんな選択肢はありません。")
    end
  end

  defp question_3 do
    age = IO.gets("年齢を入力してください。＞") |> String.trim() |> String.to_integer()

    cond do
      age < 3 || age >= 70 -> IO.puts("入場料金無料です。")
      age >= 3 && age <= 15 -> IO.puts("子供料金で半額です。")
      age >= 60 && age < 70 -> IO.puts("シニア割引で一割引きです。")
      true -> IO.puts("通常料金です。")
    end
  end

  defp question_4 do
    IO.puts("＊＊＊おみくじプログラム＊＊＊")
    choice = IO.gets("おみくじを引きますか　（はい：１　いいえ：０）＞")
    |> String.trim()
    |> String.to_integer()

    if choice >= 1 do
      case Enum.random(0..4) do
        0 -> IO.puts("大吉　とってもいいことがありそう！！")
        1 -> IO.puts("中吉　きっといいことあるんじゃないかな")
        2 -> IO.puts("小吉　少しぐらいはいいことあるかもね")
        3 -> IO.puts("凶　今日はおとなしくておいた方がいいかも")
        4 -> IO.puts("大凶　これじゃやばくない？早く家に帰った方がいいかも")
        _ -> IO.puts("")
      end
    end
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
