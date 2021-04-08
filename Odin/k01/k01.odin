package k01

import "core:fmt"

@(private)
question_1 :: proc() {
    fmt.println("Hello World!　ようこそOdin言語の世界へ！");
}

@(private)
question_2 :: proc() {
    fmt.println("Hello World!");
    fmt.println("ようこそ");
    fmt.println("Odin言語の世界へ！");
}

@(private)
question_3 :: proc() {
    fmt.println("整数：%d", 12345);
    fmt.println("実数：%f", 123.456789);
    fmt.println("文字：%c", 'A');
    fmt.println("文字列：%s", "ABCdef");
}

@(private)
question_4 :: proc() {
    fmt.println("              ##");
    fmt.println("             #  #");
    fmt.println("             #  #");
    fmt.println("            #    #");
    fmt.println("           #      #");
    fmt.println("         ##        ##");
    fmt.println("       ##            ##");
    fmt.println("    ###                ###");
    fmt.println(" ###       ##    ##       ###");
    fmt.println("##        #  #  #  #        ##");
    fmt.println("##         ##    ##         ##");
    fmt.println(" ##     #            #     ##");
    fmt.println("  ###     ##########     ###");
    fmt.println("     ###              ###");
    fmt.println("        ##############");
}

execute :: proc(num: int) {
    switch num {
        case 1:
            question_1();
        case 2:
            question_2();
        case 3:
            question_3();
        case 4:
            question_4();
    }
}