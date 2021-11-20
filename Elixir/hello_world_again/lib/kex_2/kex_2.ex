defmodule Kex_2 do
  @spec run_kex_2 :: :ok
  def run_kex_2 do
    IO.puts("冒険が今始まる！")
    player = Player.new(Constants.player_initial_hp, Constants.player_initial_defense)
    IO.puts(Kex2_Battle.game_loop(player, 0, 1))
  end
end
