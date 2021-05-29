structure K04 : Question =
  struct
    fun question1 () = (
      print "年齢を入力してください。＞";
      let
          val age = valOf (Int.fromString (valOf (TextIO.inputLine TextIO.stdIn)))
        in
         if age < 3 orelse age >= 70 then
          print "入場料金無料です。\n"
         else
          print "通常料金です。\n"
        end
      )

    fun question2 () = (
      print "性別を選択してください。（０：男性　１：女性）＞";
      let
          val gender = valOf (Int.fromString (valOf (TextIO.inputLine TextIO.stdIn)))
        in
         (case gender of
              0 => print "あら、格好良いですね。"
            | 1 => print "あら、モデルさんみたいですね。"
            | _ => print "そんな選択肢はありません。")
        end
      )

    fun question3 () = (
      print "年齢を入力してください。＞";
      let
          val age = valOf (Int.fromString (valOf (TextIO.inputLine TextIO.stdIn)))
        in
         if age < 3 orelse age >= 70 then
          print "入場料金無料です。\n"
         else if age >= 3 andalso age <= 15 then
          print "子供料金で半額です。"
         else if age >= 60 andalso age < 70 then
          print "シニア割引で一割引きです。"
         else
          print "通常料金です。"
        end
      )

    fun question4 () = (
      print "＊＊＊おみくじプログラム＊＊＊\n";
      print "おみくじを引きますか　（はい：１　いいえ：０）＞";
      let
          val choice = valOf (Int.fromString (valOf (TextIO.inputLine TextIO.stdIn)))
        in
         if choice >= 1 then
          let
              val oracle = Word.toInt ((MLton.Random.rand ()) mod 0w5)
            in
             print (case oracle of
                  0 => "大吉　とってもいいことがありそう！！"
                | 1 => "中吉　きっといいことあるんじゃないかな"
                | 2 => "小吉　少しぐらいはいいことあるかもね"
                | 3 => "凶　今日はおとなしくておいた方がいいかも"
                | 4 => "大凶　これじゃやばくない？早く家に帰った方がいいかも"
                | _ => "")
            end
         else
          ()
        end
      )
  end
