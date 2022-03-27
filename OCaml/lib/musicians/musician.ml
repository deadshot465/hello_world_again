module Musician = struct
  type t = {
    name: string;
    role: string;
    skill_level: Skill_level.skill_level;
    waiter: int Lwt_mvar.t
  }

  let first_names
    = [| "Valerie";
    "Arnold";
    "Carlos";
    "Dorothy";
    "Keesha";
    "Phoebe";
    "Ralphie";
    "Tim";
    "Wanda";
    "Janet";
    "Leo";
    "Yuhei";
    "Carson" |]

  let last_names
    = [| "Frizzle";
    "Perlstein";
    "Ramon";
    "Ann";
    "Franklin";
    "Terese";
    "Tennelli";
    "Jamal";
    "Li";
    "Perlstein";
    "Fujioka";
    "Ito";
    "Hage" |]

  let pick_name () =
    Random.self_init ();
    let first_name = Array.length first_names |> Random.int |> Array.get first_names in
    let last_name = Array.length last_names |> Random.int |> Array.get last_names in
    Printf.sprintf "%s %s" first_name last_name

  let create role skill_level waiter =
    let name = pick_name () in
    let musician = { name; role; skill_level; waiter } in
    let open Lwt.Let_syntax in
    let%bind _ = Lwt_io.printlf "Musician %s, playing the %s entered the room." name role in
    Lwt.return musician

  let play_sound musician =
    let open Lwt.Let_syntax in
    match Lwt_mvar.take_available musician.waiter with
      Some _ ->
      let%bind _ = Lwt_io.printlf "%s just got back to playing in the subway." musician.name in
      Lwt.return false
    | None ->
      (match musician.skill_level with
        Good ->
        let%bind _ = Lwt_io.printlf "%s produced sound!" musician.name in
        Lwt.return true
      | Bad ->
        let failed = Random.int 5 = 0 in
        if failed then
          let%bind _ = Lwt_io.printlf "%s played a false note. Uh oh." musician.name in
          let%bind _ = Lwt_io.printlf "%s sucks! kicked that member out of the band!" musician.name in
          Lwt.return false
        else
          Lwt.return true)
end