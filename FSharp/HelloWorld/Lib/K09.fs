namespace HelloWorld.Lib

open System
open HelloWorld.Lib

type K09() =
    interface IQuestion with
        member this.Question1() =
            let ages = K06().GetAges 3
            Console.WriteLine (String.replicate 90 "-")
            let count = float(List.length ages)
            let total = float(List.sum ages)
            List.iteri (fun i age -> printfn $"{i + 1}人目：{age}歳") ages
            printfn $"平均年齢：{total / count}歳"
        
        member this.Question2() =
            let numbers = [8; 3; 12; 7; 9]
            printf "元々の配列："
            List.iter (fun i -> printf $"{i} ") numbers
            printfn ""
            printf "逆順での表示："
            List.iter (fun i -> printf $"{i} ") (List.rev numbers)
            
        member this.Question3() =
            printfn ""
            let studentScores = [[52; 71; 61; 47]; [6; 84; 81; 20]; [73; 98; 94; 95]]
            printfn "\t|\t科目A\t科目B\t科目C\t科目D"
            Console.WriteLine (String.replicate 65 "-")
            List.iteri (fun i student ->
                printf $"学生{i + 1}\t|\t"
                List.iter (fun score -> printf $"{score}\t") student
                printfn "") studentScores
      
        member this.Question4() =
            printfn ""
            let studentScores = [[52; 71; 61; 47]; [6; 84; 81; 20]; [73; 98; 94; 95]]
            let withSum = List.map (fun scores -> List.append scores [List.sum scores]) studentScores
            printfn "\t|\t科目A\t科目B\t科目C\t科目D\t|\t合計点"
            Console.WriteLine (String.replicate 65 "-")
            List.iteri (fun i student ->
                printf $"学生{i + 1}\t|\t"
                let lastScore = List.last student
                List.iter (fun score -> if score = lastScore then printf $"|\t{score}\t" else printf $"{score}\t") student
                printfn "") withSum
            let average = this.Transform withSum [0; 0; 0; 0; 0] |> List.map float
            let lastAverage = List.last average
            printf "平均点\t|\t"
            List.iter (fun score -> if score = lastAverage then printf $"|\t{score / 3.0}\t" else printf $"{score / 3.0}\t") average
    
    member private this.InputNumbers n choice acc =
        match choice with
        | x when x < 0 -> acc
        | _ when n = 100 -> acc
        | _ ->
            printf $"{n}件目の入力："
            let number = Console.ReadLine() |> Int32.Parse
            this.InputNumbers (n + 1) number (number :: acc)
    
    member public this.Question5() =
        let input = this.InputNumbers 1 0 []
        printfn "----並び替え後----"
        List.iter (fun i -> printf $"{i} ") (List.sort input)
            
    member private this.Transform xs acc =
        List.fold (fun acc' student -> List.mapi (fun i score -> score + (List.item i student)) acc') acc xs