namespace HelloWorld.Lib

open System

type GolemK02 = {
    mutable Hp: int
    Defense: int
    Attack: int
}

type K02() =
    interface IQuestion with
        member this.Question1() =
            let seisuu = 3
            let jissuu = 2.6
            let moji = 'A'
            printfn $"変数seisuuの値は{seisuu}"
            printfn $"変数jissuuの値は{jissuu}"
            printfn $"変数mojiの値は{moji}"
            
        member this.Question2() =
            printf "一つ目の整数は？"
            let number1 = Console.ReadLine() |> Int32.Parse
            printf "二つ目の整数は？"
            let number2 = Console.ReadLine() |> Int32.Parse
            printfn $"{number1}÷{number2}={number1 / number2}...{number1 % number2}"
        
        member this.Question3() =
            printf "一つ目の商品の値段は？"
            let priceA = Console.ReadLine() |> Int32.Parse
            printf "個数は？"
            let amountA = Console.ReadLine() |> Int32.Parse
            printf "二つ目の商品の値段は？"
            let priceB = Console.ReadLine() |> Int32.Parse
            printf "個数は？"
            let amountB = Console.ReadLine() |> Int32.Parse
            let total = float32(priceA * amountA + priceB * amountB) * 1.1f
            printfn $"お支払いは税込み￥{total}"
        
        member this.Question4() =
            let mutable golem = { GolemK02.Hp = 300; GolemK02.Defense = 80; GolemK02.Attack = 50 }
            printfn $"ゴーレム　（HP：{golem.Hp}　防御力：{golem.Defense}）"
            printfn $"HP：{golem.Hp}"
            printf "今回の攻撃の値を入力してください＞"
            let damage = Console.ReadLine() |> Int32.Parse
            let finalDamage = if damage - golem.Defense > 0 then
                                damage - golem.Defense else 0
            printfn $"ダメージは{finalDamage}です。"
            golem.Hp <- golem.Hp - finalDamage
            printfn $"残りのHPは{golem.Hp}です。"