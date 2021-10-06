module HelloWorld.Lib.Extra.Rpn

open System

let private read s =
    Double.Parse s
    
let private inner_rpn stack op =
    match (op, stack) with
    | "+", n1 :: n2 :: tl -> n2 + n1 :: tl
    | "-", n1 :: n2 :: tl -> n2 - n1 :: tl
    | "*", n1 :: n2 :: tl -> n2 * n1 :: tl
    | "/", n1 :: n2 :: tl -> n2 / n1 :: tl
    | "^", n1 :: n2 :: tl -> Math.Pow(n2, n1) :: tl
    | "ln", n1 :: tl -> Math.Log(n1) :: tl
    | "log10", n1 :: tl -> Math.Log10(n1) :: tl
    | "sum", l -> [List.sum l]
    | "prod", l -> [List.fold (*) 1.0 l]
    | x, l -> read x :: l

let rpn (s: string) =
    try
        let res :: tl = List.fold inner_rpn [] (List.ofArray (s.Split(" ")))
        if (tl <> []) then
            failwith "Incorrect input"
        else
            res
    with
        | :? MatchFailureException as ex ->
            Console.Error.WriteLine ex.Message
            0.0