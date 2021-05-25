open Lib.Executable;

module K01 = Executable(Lib.K01.K01);
module K02 = Executable(Lib.K02.K02);
module K03 = Executable(Lib.K03.K03);
module K04 = Executable(Lib.K04.K04);
module K05 = Executable(Lib.K05.K05);
module K06 = Executable(Lib.K06.K06);

let executables = [
    K01.execute, K02.execute, K03.execute,
    K04.execute, K05.execute, K06.execute
];

let show_selections = chapter => {
    if (chapter < 10) {
        [1, 2, 3, 4]
        |> List.iter(x => Printf.printf("\t%d) K0%d_%d", x, chapter, x));
    } else {
        [1, 2, 3, 4]
        |> List.iter(x => Printf.printf("\t%d) K%d_%d", x, chapter, x));
    }
};

let () = {
    print_endline("実行したいプログラムを選択してください。");
    executables
    |> List.iteri((i, _) => if (i < 10) {
        Printf.printf("%d) K0%d\t\t", i + 1, i + 1);
    } else {
        Printf.printf("%d) K%d\t\t", i + 1, i + 1);
    });
    print_newline();
    let choice = read_int();
    show_selections(choice);
    let choice_2 = read_int();
    switch (List.nth_opt(executables, choice - 1)) {
        | None => print_endline("選択された課題はございません。")
        | Some(exec) => exec(choice_2);
    }
};
