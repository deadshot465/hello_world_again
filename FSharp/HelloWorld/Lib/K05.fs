namespace HelloWorld.Lib

open System

type Golem = {
    mutable hp: int
    defense: int
    attack: int
}

type K05() =
    interface Question with
        member this.question_1() =
            let salary = 19.0f
            let age = 22
            let rec loop salary' age' =
                match salary' with
                | x when x < 50.0f -> loop (salary' * 1.035f) (age' + 1)
                | _ -> printfn $"{age'}歳で月給{salary'}万円"
            loop salary age
            
        member this.question_2() =
            let rec loop = function
                | x when x <> 1 ->
                    printfn "起きろ～"
                    printf "1．起きた　2．あと5分…　3．Zzzz…\t入力："
                    let choice = Console.ReadLine() |> Int32.Parse
                    loop choice
                | _ -> printfn "よし、学校へ行こう！"
            loop 0
                
        member this.question_3() =
            let rec loop = function
                | x when x <> 1 ->
                    printfn "起きろ～"
                    printf "1．起きた　2．あと5分…　3．Zzzz…\t入力："
                    let choice = Console.ReadLine() |> Int32.Parse
                    loop choice
                | _ ->
                    printfn "よし、学校へ行こう！"
                    loop 0
            loop 0
      
        member this.question_4() =
            let rng = Random()
            let golem = { Golem.hp = 300 + rng.Next(200); Golem.defense = 80; Golem.attack = 50 }
            let player_hp = 200 + rng.Next(100)
            printfn $"ゴーレム　（HP：{golem.hp}　防御力：{golem.defense}）"
            
            let rec loop golem' player_hp' =
                match (golem'.hp, player_hp') with
                | x, y when x = 0 && y <> 0 -> printfn "ゴーレムを倒しました！"
                | x, y when x <> 0 && y = 0 -> printfn "あなたはゴーレムに負けました！ゲームオーバー！"
                | x, y ->
                    printfn $"ゴーレム残りHP：{x}"
                    let damage = this.input_damage rng 0
                    printfn $"基礎攻撃力は{damage}です。"
                    let damage = if damage - golem'.defense <= 0 then 0 else damage - golem'.defense
                    match damage with
                    | 0 ->
                        printfn "ゴーレム：「ハハハハハ、情けないな！貴様は弱すぎる！」"
                        printfn $"ゴーレムがあなたを攻撃しました！攻撃値：{golem'.attack}"
                        let y' = if y - golem'.attack < 0 then 0 else (y - golem'.attack)
                        printfn $"あなたの残りHPは：{y'}"
                        loop golem' y'
                    | _ ->
                        printfn $"ダメージは{damage}です。"
                        let x' = if x - damage < 0 then 0 else x - damage
                        printfn $"残りのHPは{x'}です。"
                        loop { Golem.hp = x'; Golem.defense = golem'.defense; Golem.attack = golem'.attack } y
            loop golem player_hp
        
    member private this.input_damage (rng: Random) = function
            | 1 -> 60 + rng.Next(40)
            | 2 -> 30 + rng.Next(100)
            | 3 -> 20 + rng.Next(180)
            | _ ->
                printfn "攻撃手段を選択してください（1．攻撃　2．特技　3．魔法）＞"
                this.input_damage rng (Console.ReadLine() |> Int32.Parse) 
            