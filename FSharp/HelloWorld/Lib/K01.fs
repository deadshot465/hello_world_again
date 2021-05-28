namespace HelloWorld.Lib

type K01() =
    interface Question with
        member this.question_1() = printfn "Hello World!　ようこそF#言語の世界へ！"
        
        member this.question_2() =
            printfn "Hello World!"
            printfn "ようこそ"
            printfn "F#言語の世界へ！"
            
        member this.question_3() =
            printfn $"整数：{12345}"
            printfn $"実数：{123.456789}"
            printfn $"文字：{'A'}"
            printfn "文字列：%s" "ABCdef"
            
        member this.question_4() =
            printfn "              ##";
            printfn "             #  #";
            printfn "             #  #";
            printfn "            #    #";
            printfn "           #      #";
            printfn "         ##        ##";
            printfn "       ##            ##";
            printfn "    ###                ###";
            printfn " ###       ##    ##       ###";
            printfn "##        #  #  #  #        ##";
            printfn "##         ##    ##         ##";
            printfn " ##     #            #     ##";
            printfn "  ###     ##########     ###";
            printfn "     ###              ###";
            printfn "        ##############"