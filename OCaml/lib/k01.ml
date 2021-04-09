open Question

module K01 : Question = struct
  let question_1 () = print_string "Hello World!　ようこそOCaml言語の世界へ！"

  let question_2 () =
    print_endline "Hello World!";
    print_endline "ようこそ";
    print_endline "OCaml言語の世界へ！"

  let question_3 () =
    print_endline ("整数：" ^ string_of_int 12345);
    print_endline ("実数：" ^ string_of_float 123.456789);
    print_endline ("文字：" ^ "A");
    print_endline ("文字列：" ^ "ABCdef")

  let question_4 () =
    print_endline "              ##";
    print_endline "             #  #";
    print_endline "             #  #";
    print_endline "            #    #";
    print_endline "           #      #";
    print_endline "         ##        ##";
    print_endline "       ##            ##";
    print_endline "    ###                ###";
    print_endline " ###       ##    ##       ###";
    print_endline "##        #  #  #  #        ##";
    print_endline "##         ##    ##         ##";
    print_endline " ##     #            #     ##";
    print_endline "  ###     ##########     ###";
    print_endline "     ###              ###";
    print_endline "        ##############"
end