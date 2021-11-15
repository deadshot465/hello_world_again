open Shared.Constants
open Shared.Player

module Kex_2 = struct
  let run () =
    Random.self_init ();
    print_endline "冒険が今始まる！";
    let player: Player.player = { player_hp = Constants.player_initial_hp; player_defense = Constants.player_initial_defense } in
    let result = Kex_2_battle.Kex_2_Battle.game_loop player in
    print_endline result
end