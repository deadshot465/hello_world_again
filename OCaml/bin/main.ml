open Lib.Executable

module K01 = Executable(Lib.K01.K01)
module K02 = Executable(Lib.K02.K02)
module K03 = Executable(Lib.K03.K03)
module K04 = Executable(Lib.K04.K04)
module K05 = Executable(Lib.K05.K05)
module K06 = Executable(Lib.K06.K06)
module K07 = Executable(Lib.K07.K07)
module K08 = Executable(Lib.K08.K08)
module K09 = Executable(Lib.K09.K09)

let executables = [
  K01.execute; K02.execute; K03.execute; K04.execute;
  K05.execute; K06.execute; K07.execute; K08.execute;
  K09.execute
]

let show_selections chapter =
  let assignments = if chapter = 9 then [1; 2; 3; 4; 5] else [1; 2; 3; 4] in
  if chapter < 10 then
    assignments
    |> List.iter (fun x -> print_endline ("\t" ^ (string_of_int x) ^ ") K0" ^ (string_of_int chapter) ^ "_" ^ (string_of_int x)))
  else
    assignments
    |> List.iter (fun x -> print_endline ("\t" ^ (string_of_int x) ^ ") K" ^ (string_of_int chapter) ^ "_" ^ (string_of_int x)))

let () =
  print_endline "実行したいプログラムを選択してください。";
  executables
  |> List.iteri (fun i _ -> if i < 10 then
                    print_string ((string_of_int (i + 1)) ^ ") K0" ^ (string_of_int (i + 1)) ^ "\t\t") else
                    print_string ((string_of_int (i + 1)) ^ ") K" ^ (string_of_int (i + 1)) ^ "\t\t"));
  print_endline "101) Kex_2";
  print_endline "103) Band Supervisor";
  print_newline();
  let choice = read_int() in
  match choice with
  | 101 -> Kex_2.Kex_2.run ()
  | 103 -> Musicians.Band_supervisor.BandSupervisor.start_band 3
  | _ -> (
      show_selections choice;
      let choice_2 = read_int() in
      match List.nth_opt executables (choice - 1) with
        None -> print_endline "選択された課題はございません。"
      | Some(exec) -> if choice = 9 && choice_2 = 5 then Lib.K09.question_5 () else exec choice_2
    )