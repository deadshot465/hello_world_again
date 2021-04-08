defmodule K01 do
  defp question_1 do
    IO.puts("Hello World!　ようこそElixir言語の世界へ！")
  end

  defp question_2 do
    IO.puts("Hello World!")
    IO.puts("ようこそ")
    IO.puts("Elixir言語の世界へ！")
  end

  defp question_3 do
    IO.puts("整数：#{12345}")
    IO.puts("実数：#{123.456789}")
    IO.puts("文字：#{'A'}")
    IO.puts("文字列：#{"ABCdef"}")
  end

  defp question_4 do
    IO.puts("              ##")
    IO.puts("             #  #")
    IO.puts("             #  #")
    IO.puts("            #    #")
    IO.puts("           #      #")
    IO.puts("         ##        ##")
    IO.puts("       ##            ##")
    IO.puts("    ###                ###")
    IO.puts(" ###       ##    ##       ###")
    IO.puts("##        #  #  #  #        ##")
    IO.puts("##         ##    ##         ##")
    IO.puts(" ##     #            #     ##")
    IO.puts("  ###     ##########     ###")
    IO.puts("     ###              ###")
    IO.puts("        ##############")
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
