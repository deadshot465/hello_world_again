module BandSupervisor = struct
  let add_band_member role skill_level mvar =
    let open Lwt.Let_syntax in
    let fire_mvar = Lwt_mvar.create_empty () in
    let%bind musician = Musician.Musician.create role skill_level fire_mvar in
    let rec loop r s m w =
      let%bind _ = Lwt_unix.sleep 0.75 in
      let%bind play_result = Musician.Musician.play_sound m in
      if play_result then
        loop r s m w
      else
        Lwt_mvar.put w (role, skill_level)
    in
    Lwt.async (fun () -> loop role skill_level musician mvar);
    Lwt.return fire_mvar

  let start_band max_retries =
    Lwt_main.run (
      let open Base in
      let open Lwt.Let_syntax in
      let mvar = Lwt_mvar.create_empty () in
      let members = Hashtbl.create (module String) in
      let%bind singer = add_band_member "singer" Good mvar
      and      bass = add_band_member "bass" Good mvar
      and      drum = add_band_member "drum" Bad mvar
      and      guitar = add_band_member "guitar" Good mvar
      in
      Hashtbl.add_exn members ~key:"singer" ~data:singer;
      Hashtbl.add_exn members ~key:"bass" ~data:bass;
      Hashtbl.add_exn members ~key:"drum" ~data:drum;
      Hashtbl.add_exn members ~key:"guitar" ~data:guitar;

      let rec loop mbs m = function
        0 ->
          let%bind _ = Lwt_io.printl "The manager is mad and fire the whole band!" in
          Hashtbl.iter mbs ~f:(fun mail_box -> Lwt.async (fun () -> Lwt_mvar.put mail_box 0));
          let%bind _ = Lwt_unix.sleep 3.0 in
          Lwt.return ()
        | x ->
          let%bind (role, skill_level) = Lwt_mvar.take m in
          let%bind new_member = add_band_member role skill_level m in
          Hashtbl.remove mbs role;
          Hashtbl.add_exn mbs ~key:role ~data:new_member;
          loop mbs m (x - 1)
      in
      loop members mvar max_retries
    )
end