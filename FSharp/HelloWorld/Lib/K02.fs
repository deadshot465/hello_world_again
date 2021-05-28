namespace HelloWorld.Lib

open System

type GolemK02 = {
    mutable hp: int
    defense: int
    attack: int
}

type K02() =
    interface Question with
        member this.question_1() =
            let seisuu = 3
            let jissuu = 2.6
            let moji = 'A'
            printfn $"変数seisuuの値は{seisuu}"
            printfn $"変数jissuuの値は{jissuu}"
            printfn $"変数mojiの値は{moji}"
            
        member this.question_2() =
            printf "一つ目の整数は？"
            let number_1 = Console.ReadLine() |> Int32.Parse
            printf "二つ目の整数は？"
            let number_2 = Console.ReadLine() |> Int32.Parse
            printfn $"{number_1}÷{number_2}={number_1 / number_2}...{number_1 % number_2}"
        
        member this.question_3() =
            printf "一つ目の商品の値段は？"
            let price_a = Console.ReadLine() |> Int32.Parse
            printf "個数は？"
            let amount_a = Console.ReadLine() |> Int32.Parse
            printf "二つ目の商品の値段は？"
            let price_b = Console.ReadLine() |> Int32.Parse
            printf "個数は？"
            let amount_b = Console.ReadLine() |> Int32.Parse
            let total = float32(price_a * amount_a + price_b * amount_b) * 1.1f
            printfn $"お支払いは税込み￥{total}"
        
        member this.question_4() =
            let mutable golem = { GolemK02.hp = 300; GolemK02.defense = 80; GolemK02.attack = 50 }
            printfn $"ゴーレム　（HP：{golem.hp}　防御力：{golem.defense}）"
            printfn $"HP：{golem.hp}"
            printf "今回の攻撃の値を入力してください＞"
            let damage = Console.ReadLine() |> Int32.Parse
            let final_damage = if damage - golem.defense > 0 then
                                damage - golem.defense else 0
            printfn $"ダメージは{final_damage}です。"
            golem.hp <- golem.hp - final_damage
            printfn $"残りのHPは{golem.hp}です。"