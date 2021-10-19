namespace HelloWorld.Lib

open System

type K06() =
    interface IQuestion with
        member this.Question1() =
            let ages = this.GetAges 5
            let count = List.length ages
            let totalAges = List.sum ages
            printfn $"{count}人の平均年齢は{float32(totalAges) / float32(count)}"
            
        member this.Question2() =
            let upperPyramid = this.MakeUpperPyramid 8
                                |> String.concat "\n"
            printfn $"{upperPyramid}"
            printfn("")
            let lowerPyramid = this.MakeLowerPyramid 8
                                |> String.concat "\n"
            printfn $"{lowerPyramid}"
            printfn("")
            let specialPyramid = this.MakeSpecialPyramid 8
                                  |> String.concat "\n"
            printfn $"{specialPyramid}"
            printfn("")
            
        member this.Question3() =
            let combinations = this.CountCombinations 370 |> List.map (fun (x, y, z) -> sprintf $"10円の硬貨{z}枚 50円の硬貨{y}枚 100円の硬貨{x}枚\n")
            let str = String.concat "\n" combinations
            printfn $"{str}"
            printfn $"\n以上{List.length combinations}通りを発見しました。"
            
        member this.Question4() =
            printf "\t|\t"
            let rec printOneToTen num arr =
                match num with
                | 0 -> arr
                | _ -> printOneToTen (num - 1) (num :: arr)
            let numbers = printOneToTen 9 [] |> List.map (fun x -> x.ToString()) |> String.concat "\t"
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
                let innerList = List.map (fun y -> y.ToString()) x |> String.concat "\t"
                sprintf $"{i + 1}\t|\t{innerList}") |> String.concat "\n"
            printfn $"{result}"
        
    member public this.GetAges n =
        let rec inputAge no amount acc =
            match amount with
            | 0 -> acc
            | _ ->
                printf $"{no + 1}人目の年齢を入力して下さい："
                inputAge (no + 1) (amount - 1) ((Console.ReadLine() |> Int32.Parse) :: acc)
        inputAge 0 n []
        
    member private this.MakeUpperPyramid levels =
        let rec make current levels' acc =
            match levels' with
            | 0 -> acc
            | _ -> make (current + 1) (levels' - 1) ((String.init (current + 1) (fun x -> "*")) :: acc)
        make 0 levels [] |> List.rev
        
    member private this.MakeLowerPyramid levels =
        let rec make levels' acc =
            match levels' with
            | 0 -> acc
            | _ -> make (levels' - 1) ((String.init levels' (fun x -> "*")) :: acc)
        make levels [] |> List.rev
        
    member private this.MakeSpecialPyramid levels =
        let rec make amountOfStars amountOfSpaces acc =
            match amountOfStars with
            | 0 -> acc
            | _ ->
                make (amountOfStars - 1) (amountOfSpaces + 1) (((String.init amountOfSpaces (fun _ -> " ")) + (String.init amountOfStars (fun _ -> "*"))) :: acc)
        make levels 0 []
        
    member private this.CountCombinations amount =
        let countTens remains = remains / 10
        let rec countFifties amount remains arr =
            match amount with
            | x when x < 0 -> arr
            | _ -> countFifties (amount - 1) remains ((amount, (countTens (remains - (50 * amount)))) :: arr)
        let rec countHundreds amount remains arr =
            match amount with
            | x when x < 0 -> arr
            | _ ->
                let remains' = remains - (100 * amount)
                let arr' = countFifties (remains' / 50) remains' [] |> List.map (fun (x, y) -> (amount, x, y))
                countHundreds (amount - 1) remains (arr' @ arr)
        countHundreds (amount / 100) amount []
                