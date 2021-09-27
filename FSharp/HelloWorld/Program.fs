namespace HelloWorld

open System
open HelloWorld.Lib

module HelloWorld =
    let executables = [|Executable(K01()); Executable(K02()); Executable(K03())
                        Executable(K04()); Executable(K05()); Executable(K06())
                        Executable(K07()); Executable(K08())|]
    
    let showSelections chapter =
        if chapter < 10 then
            [1; 2; 3; 4] |> List.iter (fun x -> printfn $"\t{x}) K0{chapter}_{x}")
        else
            [1; 2; 3; 4] |> List.iter (fun x -> printfn $"\t{x}) K{chapter}_{x}")
    
    [<EntryPoint>]
    let main argv =
        printfn "実行したいプログラムを選択してください。"
        executables |> Array.iteri (fun i _ ->
            if i < 10 then printf $"{i + 1}) K0{i + 1}\t\t"
            else printf $"{i + 1}) K{i + 1}\t\t")
        printfn ""
        let choice = Console.ReadLine() |> Int32.Parse
        showSelections choice
        let choice2 = Console.ReadLine() |> Int32.Parse
        executables.[choice - 1].Execute choice2
        0 // return an integer exit code