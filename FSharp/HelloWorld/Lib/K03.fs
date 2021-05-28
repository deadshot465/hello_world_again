namespace HelloWorld.Lib

open System

type K03() =
    interface Question with
        member this.question_1() =
            printf "年齢を入力してください。＞"
            let age = Console.ReadLine() |> Int32.Parse
            if age < 20 then
                printfn "未成年なので購入できません。"
        
        member this.question_2() =
            printf "身長を入力してください。＞"
            let mutable height = Console.ReadLine() |> Single.Parse
            height <- height * 0.01f
            printf "体重を入力してください。＞"
            let weight = Console.ReadLine() |> Single.Parse
            let standard = height * height * 22.0f
            printfn $"あなたの標準体重は{standard}です。"
            match weight with
            | x when x > standard && (x - standard) / standard * 100.0f > 14.0f -> printfn "太り気味です。"
            | x when x < standard && (x - standard) / standard * 100.0f < -14.0f -> printfn "痩せ気味です。"
            | _ -> printfn "普通ですね。"
        
        member this.question_3() =
            let rng = Random()
            let random_number = rng.Next(0, 100)
            printfn "０から９９の範囲の数値が決定されました。"
            printf "決められた数値を予想し、この数値よりも大きな値を入力してください＞"
            let guess = Console.ReadLine() |> Int32.Parse
            printfn $"決められた数値は{random_number}です。"
            printfn (if guess > random_number then "正解です" else "不正解です。")
        
        member this.question_4() =
            let rng = Random()
            let random_number = rng.Next(0, 100)
            printfn "０から９９の範囲の数値が決定されました。"
            printf "決められた数値を予想し、この数値よりも大きな値を入力してください＞"
            let guess = Console.ReadLine() |> Int32.Parse
            printfn $"決められた数値は{random_number}です。"
            printfn (match guess with
                     | x when x < 0 || x > 99 -> "反則です！"
                     | x when x > random_number && (x - random_number) <= 10 -> "大正解です！"
                     | x when x < random_number && (random_number - x) <= 10 -> "惜しい！"
                     | x when x = random_number -> "お見事！"
                     | _ -> if guess > random_number then "正解です" else "不正解です。")