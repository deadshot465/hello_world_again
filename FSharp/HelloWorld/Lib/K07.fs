namespace HelloWorld.Lib

open System

type AgeTier = Error | Free | Half | TenPercentOff | Normal

type K07() =
    interface IQuestion with
        member this.Question1() =
            let rec loop = function
                | 0 -> ()
                | _ ->
                    this.ShowTexts ()
                    printfn "メッセージを表示しますか？（０：終了する　１：表示する）＞"
                    let input = Console.ReadLine() |> Int32.Parse
                    loop input
            printfn "メッセージを表示しますか？（０：終了する　１：表示する）＞"
            loop (Console.ReadLine() |> Int32.Parse)
            
        member this.Question2() =
            let numbers = this.GetNumbers 3
            let count = List.length numbers
            let maxValue = List.max numbers
            printfn $"{count}つの中で最大値は{maxValue}"

        member this.Question3() =
            printfn "年齢を入力して下さい。＞"
            printfn (match this.GetAgeTier (Console.ReadLine() |> Int32.Parse) with
                               | Error -> "不適切な値が入力されました。"
                               | Free -> "入場料金無料です。"
                               | Half -> "子供料金で半額です。"
                               | TenPercentOff -> "シニア割引で１割引きです。"
                               | _ -> "通常料金です。")
            
        member this.Question4() = ()
    
    member public this.GetNumbers count =
        let rec loop acc no count' =
            match count' with
            | 0 -> acc
            | _ ->
                printfn $"{no + 1}つ目の値を入力してください。＞"
                let num = Console.ReadLine() |> Int32.Parse
                loop (num :: acc) (no + 1) (count' - 1)
        loop [] 0 count
        
    member private this.ShowTexts () =
        printfn "Hello World"
        printfn "ようこそ"
        printfn "F#の世界へ！"
        
    member private this.GetAgeTier = function
        | x when x < 0 -> Error
        | x when x < 3 || x >= 70 -> Free
        | x when x >= 3 && x <= 15 -> Half
        | x when x >= 60 && x < 70 -> TenPercentOff
        | _ -> Normal