namespace HelloWorld.Lib

type K01() =
    interface IQuestion with
        member this.Question1() = printfn "Hello World!　ようこそF#言語の世界へ！"
        
        member this.Question2() =
            printfn "Hello World!"
            printfn "ようこそ"
            printfn "F#言語の世界へ！"
            
        member this.Question3() =
            printfn $"整数：{12345}"
            printfn $"実数：{123.456789}"
            printfn $"文字：{'A'}"
            printfn "文字列：%s" "ABCdef"
            
        member this.Question4() =
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