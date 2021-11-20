defmodule HelloWorldApplication do
  use Application
  def start(_type, _args) do
    pid = EccLibrary.start_link()
    {:ok, pid}
    # children = [
    #   %{
    #     id: HelloWorldAgain,
    #     start: {HelloWorldAgain, :start_link, []},
    #     shutdown: :brutal_kill,
    #     restart: :temporary
    #   }
    # ]
    # Supervisor.start_link(children, strategy: :one_for_one)
  end
end

defmodule HelloWorldAgain do
  @moduledoc """
  Documentation for `HelloWorldAgain`.
  """
  @executables [
    &K01.execute/1,
    &K02.execute/1,
    &K03.execute/1,
    &K04.execute/1,
    &K05.execute/1,
    &K06.execute/1,
    &K07.execute/1,
    &K08.execute/1,
    &K09.execute/1
  ]

  def run do
    IO.puts("実行したいプログラムを選択してください。")

    Enum.with_index(@executables)
    |> Enum.each(fn { _func, index } ->
      if index < 10 do
        IO.write("#{index + 1}) K0#{index + 1}\t\t")
      end
    end)

    IO.puts("101) Kex_2")

    choice = IO.gets("")
    |> String.trim()
    |> String.to_integer()

    case choice do
      101 ->
        Kex_2.run_kex_2()
      _ ->
        choice = show_selections(choice)
        choice_2 = IO.gets("")
        |> String.trim()
        |> String.to_integer()
        Enum.at(@executables, choice - 1).(choice_2)
    end
  end

  defp show_selections(chapter) do
    [1, 2, 3, 4]
    |> Enum.each(fn x ->
      if x < 10 do
        IO.puts("\t#{x}) K0#{chapter}_#{x}")
      else
        IO.puts("\t#{x}) K#{chapter}_#{x}")
      end
    end)
    if chapter == 9 do
      IO.puts("\t5) K0#{chapter}_5")
    end
    chapter
  end
end
