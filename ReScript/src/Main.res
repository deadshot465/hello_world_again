open Executable

module K01E = Executable(K01.K01)
module K02E = Executable(K02.K02)
module K03E = Executable(K03.K03)
module K04E = Executable(K04.K04)
module K05E = Executable(K05.K05)
module K06E = Executable(K06.K06)

let executables = [K01E.execute, K02E.execute, K03E.execute,
    K04E.execute, K05E.execute, K06E.execute
]

let show_selections = chapter => {
    if chapter < 10 {
        [1, 2, 3, 4]
        |> Array.iter(x => print_string(j`\t$x) K0${string_of_int(chapter)}_$x`))
    } else {
        [1, 2, 3, 4]
        |> Array.iter(x => print_string(j`\t$x) K${string_of_int(chapter)}_$x`))
    }
}

let () = {
    print_endline("実行したいプログラムを選択してください。")
    executables
    |> Array.iteri((i, _) => if i < 10 {
        print_string(j`${string_of_int(i + 1)}) K0${string_of_int(i + 1)}\t\t`)
    } else {
        print_string(j`${string_of_int(i + 1)}) K${string_of_int(i + 1)}\t\t`)
    })
    print_newline()
    
    let choice = read_int()
    show_selections(choice)
    let choice_2 = read_int()
    executables[choice - 1](choice_2)
}