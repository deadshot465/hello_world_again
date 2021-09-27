namespace HelloWorld.Lib

open System
open HelloWorld.Lib

type K08() =
    interface IQuestion with
        member this.Question1() =
            let numbers = K07().GetNumbers 3
            let count = List.length numbers
            Console.WriteLine "どちらを調べますか？"
            Console.WriteLine "（０：最大値　１：最小値）＞"
            let result, text = if (Console.ReadLine() |> Int32.Parse) = 0 then
                                    (List.max numbers, "最大値")
                                 else
                                    (List.min numbers, "最小値")
            Console.WriteLine $"{count}つの中で{text}は{result}"
        
        member this.Question2() =
            Console.WriteLine "冒険が今始まる！"
            let rng = Random()
            let playerHp = 200 + rng.Next(0, 101)
            Console.WriteLine (K08Adventure.GameLoop playerHp)
        
        member this.Question3() = failwith "todo"
        member this.Question4() = failwith "todo"
        
    
