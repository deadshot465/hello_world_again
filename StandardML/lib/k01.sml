structure K01 : Question =
  struct
    fun question1 () = print "Hello World!　ようこそStandardML言語の世界へ！\n"

    fun question2 () = (print "Hello World!\n";
      print "ようこそ\n";
      print "StandardML言語の世界へ！\n")

    fun question3 () = (print ("整数：" ^ (Int.toString 12345) ^ "\n");
      print ("実数：" ^ (Real.toString 123.456789) ^ "\n");
      print ("文字：" ^ "A\n");
      print ("文字列：" ^ "ABCdef\n"))

    fun question4 () =
      (print "              ##\n";
      print "             #  #\n";
      print "             #  #\n";
      print "            #    #\n";
      print "           #      #\n";
      print "         ##        ##\n";
      print "       ##            ##\n";
      print "    ###                ###\n";
      print " ###       ##    ##       ###\n";
      print "##        #  #  #  #        ##\n";
      print "##         ##    ##         ##\n";
      print " ##     #            #     ##\n";
      print "  ###     ##########     ###\n";
      print "     ###              ###\n";
      print "        ##############\n")
  end
