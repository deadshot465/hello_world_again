module HelloWorld.Lib.Kex2.Kex2

open System
open HelloWorld.Lib.Shared

let runKex2 () =
    printfn "冒険が今始まる！"
    let player = { Player.Hp = Constants.PlayerInitialHp; Player.Defense = Constants.PlayerInitialDefense }
    Console.WriteLine (Kex2Battle.GameLoop player)