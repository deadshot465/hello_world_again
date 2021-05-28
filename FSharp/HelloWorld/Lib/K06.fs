namespace HelloWorld.Lib

open System

type K06() =
    interface Question with
        member this.question_1() =
            let ages = this.get_ages()
            let count = List.length ages
            let total_ages = List.sum ages
            printfn $"{count}人の平均年齢は{float32(total_ages) / float32(count)}"
            
        member this.question_2() =
            let upper_pyramid = this.make_upper_pyramid 8
                                |> String.concat "\n"
            printfn $"{upper_pyramid}"
            printfn("")
            let lower_pyramid = this.make_lower_pyramid 8
                                |> String.concat "\n"
            printfn $"{lower_pyramid}"
            printfn("")
            let special_pyramid = this.make_special_pyramid 8
                                  |> String.concat "\n"
            printfn $"{special_pyramid}"
            printfn("")
            
        member this.question_3() =
            let combinations = this.count_combinations 370 |> List.map (fun (x, y, z) -> sprintf $"10円の硬貨{z}枚 50円の硬貨{y}枚 100円の硬貨{x}枚\n")
            let str = String.concat "\n" combinations
            printfn $"{str}"
            printfn $"\n以上{List.length combinations}通りを発見しました。"
            
        member this.question_4() =
            printf "\t|\t"
            let rec print_one_to_ten num arr =
                match num with
                | 0 -> arr
                | _ -> print_one_to_ten (num - 1) (num :: arr)
            let numbers = print_one_to_ten 9 [] |> List.map (fun x -> x.ToString()) |> String.concat "\t"
            printfn $"{numbers}"
            printfn "%s" (String.init 90 (fun _ -> "-"))
            let rec calculations i arr =
                let rec multiplications j arr =
                    match j with
                    | 0 -> arr
                    | _ -> multiplications (j - 1) (i * j :: arr)
                match i with
                | 0 -> arr
                | _ -> calculations (i - 1) (multiplications 9 [] :: arr)
            let result = calculations 9 [] |> List.mapi (fun i x ->
                let inner_list = List.map (fun y -> y.ToString()) x |> String.concat "\t"
                sprintf $"{i + 1}\t|\t{inner_list}") |> String.concat "\n"
            printfn $"{result}"
        
    member private this.get_ages () =
        let rec input_age no amount acc =
            match amount with
            | 0 -> acc
            | _ ->
                printf $"{no + 1}人目の年齢を入力して下さい："
                input_age (no + 1) (amount - 1) ((Console.ReadLine() |> Int32.Parse) :: acc)
        input_age 0 5 []
        
    member private this.make_upper_pyramid levels =
        let rec make current levels' acc =
            match levels' with
            | 0 -> acc
            | _ -> make (current + 1) (levels' - 1) ((String.init (current + 1) (fun x -> "*")) :: acc)
        make 0 levels [] |> List.rev
        
    member private this.make_lower_pyramid levels =
        let rec make levels' acc =
            match levels' with
            | 0 -> acc
            | _ -> make (levels' - 1) ((String.init levels' (fun x -> "*")) :: acc)
        make levels [] |> List.rev
        
    member private this.make_special_pyramid levels =
        let rec make amount_of_stars amount_of_spaces acc =
            match amount_of_stars with
            | 0 -> acc
            | _ ->
                make (amount_of_stars - 1) (amount_of_spaces + 1) (((String.init amount_of_spaces (fun _ -> " ")) + (String.init amount_of_stars (fun _ -> "*"))) :: acc)
        make levels 0 []
        
    member private this.count_combinations amount =
        let count_tens remains = remains / 10
        let rec count_fifties amount remains arr =
            match amount with
            | x when x < 0 -> arr
            | _ -> count_fifties (amount - 1) remains ((amount, (count_tens (remains - (50 * amount)))) :: arr)
        let rec count_hundreds amount remains arr =
            match amount with
            | x when x < 0 -> arr
            | _ ->
                let remains' = remains - (100 * amount)
                let arr' = count_fifties (remains' / 50) remains' [] |> List.map (fun (x, y) -> (amount, x, y))
                count_hundreds (amount - 1) remains (arr' @ arr)
        count_hundreds (amount / 100) amount []
                