open Lib.Executable

module K01 = Executable(Lib.K01.K01)
module K02 = Executable(Lib.K02.K02)
module K03 = Executable(Lib.K03.K03)
module K04 = Executable(Lib.K04.K04)
module K05 = Executable(Lib.K05.K05)
module K06 = Executable(Lib.K06.K06)

let executables = [
  K01.execute; K02.execute; K03.execute; K04.execute;
  K05.execute; K06.execute
]

let show_selections chapter =
  if chapter < 10 then
    [1; 2; 3; 4]
    |> List.iter (fun x -> print_endline ("\t" ^ (string_of_int x) ^ ") K0" ^ (string_of_int chapter) ^ "_" ^ (string_of_int x)))
  else
    [1; 2; 3; 4]
    |> List.iter (fun x -> print_endline ("\t" ^ (string_of_int x) ^ ") K" ^ (string_of_int chapter) ^ "_" ^ (string_of_int x)))

let () =
    print_endline "実行したいプログラムを選択してください。";
    executables
    |> List.iteri (fun i _ -> if i < 10 then
      print_string ((string_of_int (i + 1)) ^ ") K0" ^ (string_of_int (i + 1)) ^ "\t\t") else
        print_string ((string_of_int (i + 1)) ^ ") K" ^ (string_of_int (i + 1)) ^ "\t\t"));
    print_newline();
    let choice = read_int() in
    show_selections choice;
    let choice_2 = read_int() in
    match List.nth_opt executables (choice - 1) with
    None -> print_endline "選択された課題はございません。"
    | Some(exec) -> exec choice_2