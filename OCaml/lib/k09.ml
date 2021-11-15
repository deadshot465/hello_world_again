open Question

module K09 : Question = struct
  let get_ages n =
    let rec input_age no amount acc =
      match amount with
        0 -> acc
      | _ ->
        Printf.printf "%d人目の年齢を入力して下さい：" (no + 1);
        input_age (no + 1) (amount - 1) (read_int() :: acc)
    in input_age 0 n []

  let question_1 () =
    let ages = get_ages 3 in
    print_endline (String.make 90 '-');
    let count = List.length ages |> float_of_int in
    let total = List.fold_left (+) 0 ages |> float_of_int in
    List.iteri (fun i age -> Printf.printf "%d人目：%d歳\n" (i + 1) age) ages;
    Printf.printf "平均年齢：%f歳\n" (total /. count)

  let question_2 () =
    let numbers = [8; 3; 12; 7; 9] in
    print_string "元々の配列：";
    List.iter (fun i -> Printf.printf "%d " i) numbers;
    print_newline ();
    print_string "逆順での表示：";
    List.iter (fun i -> Printf.printf "%d " i) (List.rev numbers)

  let question_3 () =
    print_newline ();
    let student_scores = [[52; 71; 61; 47]; [6; 84; 81; 20]; [73; 98; 94; 95]] in
    print_endline "\t|\t科目A\t科目B\t科目C\t科目D";
    print_endline (String.make 65 '-');
    List.iteri (fun i student ->
        Printf.printf "学生%d\t|\t" i;
        List.iter (fun score -> Printf.printf "%d\t" score) student;
        print_newline ()) student_scores

  let transform xs acc =
    List.fold_left (fun acc' student -> List.mapi (fun i score -> score + (List.nth student i)) acc') acc xs

  let question_4 () =
    print_newline ();
    let student_scores = [[52; 71; 61; 47]; [6; 84; 81; 20]; [73; 98; 94; 95]] in
    let with_sum = List.map (fun scores -> List.append scores [List.fold_left (+) 0 scores]) student_scores in
    print_endline "\t|\t科目A\t科目B\t科目C\t科目D\t|\t合計点";
    print_endline (String.make 65 '-');
    List.iteri (fun i student ->
        Printf.printf "学生%d\t|\t" i;
        let last_score = List.nth student ((List.length student) - 1) in
        List.iter (fun score -> if score = last_score then Printf.printf "|\t%d\t" score
                    else Printf.printf "%d\t" score) student;
        print_newline ()) with_sum;
    let average = transform with_sum [0; 0; 0; 0; 0] |> List.map float_of_int in
    let last_average = List.nth average ((List.length average) - 1) in
    print_string "平均点\t|\t";
    List.iter (fun score -> if score = last_average then Printf.printf "|\t%f\t" (score /. 3.0)
                else Printf.printf "%f\t" (score /. 3.0)) average
end

let rec input_numbers n choice acc =
  match choice with
  | x when x < 0 -> acc
  | _ when n = 100 -> acc
  | _ ->
    Printf.printf "%d件目の入力：" n;
    let number = read_int () in
    input_numbers (n + 1) number (number :: acc)

let question_5 () =
  let input = input_numbers 1 0 [] in
  print_endline "----並び替え後----";
  List.iter (fun i -> Printf.printf "%d " i) (List.sort compare input)