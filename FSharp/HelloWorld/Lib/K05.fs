namespace HelloWorld.Lib

open System

type Golem = {
    mutable Hp: int
    Defense: int
    Attack: int
}

type K05() =
    interface IQuestion with
        member this.Question1() =
            let salary = 19.0f
            let age = 22
            let rec loop salary' age' =
                match salary' with
                | x when x < 50.0f -> loop (salary' * 1.035f) (age' + 1)
                | _ -> printfn $"{age'}歳で月給{salary'}万円"
            loop salary age
            
        member this.Question2() =
            let rec loop = function
                | x when x <> 1 ->
                    printfn "起きろ～"
                    printf "1．起きた　2．あと5分…　3．Zzzz…\t入力："
                    let choice = Console.ReadLine() |> Int32.Parse
                    loop choice
                | _ -> printfn "よし、学校へ行こう！"
            loop 0
                
        member this.Question3() =
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
      
        member this.Question4() =
            let rng = Random()
            let golem = { Golem.Hp = 300 + rng.Next(200); Golem.Defense = 80; Golem.Attack = 50 }
            let playerHp = 200 + rng.Next(100)
            printfn $"ゴーレム　（HP：{golem.Hp}　防御力：{golem.Defense}）"
            
            let rec loop golem' playerHp' =
                match (golem'.Hp, playerHp') with
                | x, y when x = 0 && y <> 0 -> printfn "ゴーレムを倒しました！"
                | x, y when x <> 0 && y = 0 -> printfn "あなたはゴーレムに負けました！ゲームオーバー！"
                | x, y ->
                    printfn $"ゴーレム残りHP：{x}"
                    let damage = this.InputDamage rng 0
                    printfn $"基礎攻撃力は{damage}です。"
                    let damage = if damage - golem'.Defense <= 0 then 0 else damage - golem'.Defense
                    match damage with
                    | 0 ->
                        printfn "ゴーレム：「ハハハハハ、情けないな！貴様は弱すぎる！」"
                        printfn $"ゴーレムがあなたを攻撃しました！攻撃値：{golem'.Attack}"
                        let y' = if y - golem'.Attack < 0 then 0 else (y - golem'.Attack)
                        printfn $"あなたの残りHPは：{y'}"
                        loop golem' y'
                    | _ ->
                        printfn $"ダメージは{damage}です。"
                        let x' = if x - damage < 0 then 0 else x - damage
                        printfn $"残りのHPは{x'}です。"
                        loop { Golem.Hp = x'; Golem.Defense = golem'.Defense; Golem.Attack = golem'.Attack } y
            loop golem playerHp
        
    member private this.InputDamage (rng: Random) = function
            | 1 -> 60 + rng.Next(40)
            | 2 -> 30 + rng.Next(100)
            | 3 -> 20 + rng.Next(180)
            | _ ->
                printfn "攻撃手段を選択してください（1．攻撃　2．特技　3．魔法）＞"
                this.InputDamage rng (Console.ReadLine() |> Int32.Parse) 
            