structure K03 : Question =
  struct
    fun question1 () = (
      print "年齢を入力してください。＞";
      let
          val age = valOf (Int.fromString (valOf (TextIO.inputLine TextIO.stdIn)))
        in
         if age < 20 then
          print "未成年なので購入できません。\n"
         else
          ()
        end
      )

    fun question2 () = (
      print "身長を入力してください。＞";
      let
          val height = (valOf (Real.fromString (valOf (TextIO.inputLine TextIO.stdIn)))) * 0.01
        in
         print "体重を入力してください。＞";
         let
             val weight = valOf (Real.fromString (valOf (TextIO.inputLine TextIO.stdIn)))
             val standard = height * height * 22.0
           in
            print ("あなたの標準体重は" ^ (Real.toString standard) ^ "です。\n");
            if (weight > standard) andalso ((weight - standard) / standard) * 100.0 > 14.0 then
              print "太り気味です。"
            else
              if (weight < standard) andalso ((weight - standard) / standard) * 100.0 < ~14.0 then
                print "痩せ気味です。"
              else
                print "普通ですね。"
           end
        end
      )

    fun question3 () = (
      let
          val randomNumber = Word.toInt ((MLton.Random.rand ()) mod 0w100)
        in
         print "０から９９の範囲の数値が決定されました。\n";
         print "決められた数値を予想し、この数値よりも大きな値を入力してください＞";
         let
             val guess = valOf (Int.fromString (valOf (TextIO.inputLine TextIO.stdIn)))
           in
            print ("決められた数値は" ^ (Int.toString randomNumber) ^ "です。\n");
            print (if guess > randomNumber then
              "正解です。"
              else
              "不正解です。")
           end
        end
      )

    fun question4 () = (
      let
          val randomNumber = Word.toInt ((MLton.Random.rand ()) mod 0w100)
        in
         print "０から９９の範囲の数値が決定されました。\n";
         print "決められた数値を予想し、この数値よりも大きな値を入力してください＞";
         let
             val guess = valOf (Int.fromString (valOf (TextIO.inputLine TextIO.stdIn)))
           in
            print ("決められた数値は" ^ (Int.toString randomNumber) ^ "です。\n");
            print (if guess < 0 orelse guess > 99 then "反則です！"
              else if guess > randomNumber andalso (guess - randomNumber) <= 10 then "大正解です！"
              else if guess < randomNumber andalso (randomNumber - guess) <= 10 then "惜しい！"
              else if guess = randomNumber then "お見事！"
              else if guess > randomNumber then "正解です。" else "不正解です。")
           end
        end
      )
  end
