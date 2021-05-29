structure K02 : Question =
  struct
    fun question1 () =
      (let
          val seisuu = 3
          val jissuu = 2.6
          val moji = "A"
        in
         print ("変数seisuuの値は" ^ (Int.toString seisuu) ^ "\n");
         print ("変数jissuuの値は" ^ (Real.toString jissuu) ^ "\n");
         print ("変数mojiの値は" ^ moji ^ "\n")
        end)

    fun question2 () = (print "一つ目の整数は？";
      let
          val str1 = valOf (TextIO.inputLine TextIO.stdIn)
          val number1 = valOf (Int.fromString str1)
        in
         print "二つ目の整数は？";
         let
             val str2 = valOf (TextIO.inputLine TextIO.stdIn)
             val number2 = valOf (Int.fromString str2)
           in
            print ((Int.toString number1) ^ "÷" ^ (Int.toString number2) ^ "=" ^ (Int.toString (number1 div number2)) ^ "..." ^ (Int.toString (number1 mod number2)))
           end
        end)

    fun question3 () = (print "一つ目の商品の値段は？";
      let
          val priceA = valOf (Int.fromString (valOf (TextIO.inputLine TextIO.stdIn)))
        in
         print "個数は？";
         let
             val amountA = valOf (Int.fromString (valOf (TextIO.inputLine TextIO.stdIn)))
           in
            print "二つ目の商品の値段は？";
            let
                val priceB = valOf (Int.fromString (valOf (TextIO.inputLine TextIO.stdIn)))
              in
               print "個数は？";
               let
                   val amountB = valOf (Int.fromString (valOf (TextIO.inputLine TextIO.stdIn)))
                   val total = (Real.fromInt ((priceA * amountA) + (priceB * amountB))) * 1.1
                 in
                  print ("お支払いは税込み￥" ^ (Real.toString total))
                 end
              end
           end
        end
      )

    type golem = { hp: int, defense: int, attack: int }

    fun question4 () = (
      let
          val golem = { hp = 300, defense = 80, attack = 50 }
        in
         print ("ゴーレム　（HP：" ^ (Int.toString (#hp golem)) ^ "　防御力：" ^ (Int.toString (#defense golem)) ^ "）\n");
         print ("HP：" ^ (Int.toString (#hp golem)) ^ "\n");
         print "今回の攻撃の値を入力してください＞";
         let
             val damage = valOf (Int.fromString (valOf (TextIO.inputLine TextIO.stdIn)))
             val finalDamage = if damage - (#defense golem) > 0 then
              damage - (#defense golem)
             else
              0
           in
            print ("ダメージは" ^ (Int.toString finalDamage) ^ "です。");
            let
                val golem = { hp = (#hp golem) - finalDamage, defense = 80, attack = 50 }
              in
               print ("残りのHPは" ^ (Int.toString (#hp golem)) ^ "です。")
              end
           end
        end
      )
  end
