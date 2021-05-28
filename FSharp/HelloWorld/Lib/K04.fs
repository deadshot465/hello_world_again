namespace HelloWorld.Lib

open System

type K04() =
    interface Question with
        member this.question_1() =
            printf "年齢を入力してください。＞"
            let age = Console.ReadLine() |> Int32.Parse
            if age < 3 || age >= 70 then
                printfn "入場料金無料です。"
            else
                printfn "通常料金です。"
            
        member this.question_2() =
            printf "性別を選択してください。（０：男性　１：女性）＞"
            match (Console.ReadLine() |> Int32.Parse) with
            | 0 -> printfn "あら、格好良いですね。"
            | 1 -> printfn "あら、モデルさんみたいですね。"
            | _ -> printfn "そんな選択肢はありません。"
            
        member this.question_3() =
            printf "年齢を入力してください。＞"
            let age = Console.ReadLine() |> Int32.Parse
            match age with
            | x when x < 3 || x >= 70 -> printfn "入場料金無料です。"
            | x when x >= 3 && x <= 15 -> printfn "子供料金で半額です。"
            | x when x >= 60 && x < 70 -> printfn "シニア割引で一割引きです。"
            | _ -> printfn "通常料金です。"
            
        member this.question_4() =
            let rng = Random()
            printfn "＊＊＊おみくじプログラム＊＊＊"
            printf "おみくじを引きますか　（はい：１　いいえ：０）＞"
            let choice = Console.ReadLine() |> Int32.Parse
            if choice >= 1 then
                printfn (match rng.Next(5) with
                         | 0 -> "大吉　とってもいいことがありそう！！"
                         | 1 -> "中吉　きっといいことあるんじゃないかな"
                         | 2 -> "小吉　少しぐらいはいいことあるかもね"
                         | 3 -> "凶　今日はおとなしくておいた方がいいかも"
                         | 4 -> "大凶　これじゃやばくない？早く家に帰った方がいいかも"
                         | _ -> "")