module Rpn = struct

  let read_number = float_of_string

  let inner_rpn stack op =
    match (op, stack) with
    | ("+", x :: y :: xs) -> (y +. x) :: xs
    | ("-", x :: y :: xs) -> (y -. x) :: xs
    | ("*", x :: y :: xs) -> (y *. x) :: xs
    | ("/", x :: y :: xs) -> (y /. x) :: xs
    | ("^", x :: y :: xs) -> (Float.pow y x) :: xs
    | ("ln", x :: xs) -> (Float.log x) :: xs
    | ("log10", x :: xs) -> (Float.log10 x) :: xs
    | ("sum", xs) -> [List.fold_left (+.) 0.0 xs]
    | ("prod", xs) -> [List.fold_left ( *. ) 1.0 xs]
    | (x, xs) -> (read_number x) :: xs

  let rpn s =
    let res = List.fold_left inner_rpn [] (String.split_on_char ' ' s) in
    match res with
    | [] -> failwith "Bad Input"
    | _ :: xs when xs <> [] -> failwith "Bad Input"
    | x :: _ -> x
end