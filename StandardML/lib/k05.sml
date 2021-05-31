structure K05 : Question =
  struct
    fun question1 () = (
      let
          val salary = 19.0
          val age = 22
          fun loop salary' age' = if salary' < 50.0 then loop (salary' * 1.035) (age' + 1)
                                  else print ((Int.toString age') ^ "歳で月給" ^ (Real.toString salary') ^ "万円\n")
        in
         loop salary age
        end
      )

    fun question2 () = (
      let
          fun loop choice = if choice <> 1 then
                              (print "起きろ～\n";
                              print "1．起きた　2．あと5分…　3．Zzzz…\t入力：";
                              loop (valOf (Int.fromString (valOf (TextIO.inputLine TextIO.stdIn)))))
                            else
                              print "よし、学校へ行こう！"
        in
         loop 0
        end
      )

    fun question3 () = (
      let
          fun loop choice = if choice <> 1 then
                              (print "起きろ～\n";
                              print "1．起きた　2．あと5分…　3．Zzzz…\t入力：";
                              loop (valOf (Int.fromString (valOf (TextIO.inputLine TextIO.stdIn)))))
                            else
                              (print "よし、学校へ行こう！";
                              loop 0)
        in
         loop 0
        end
      )

    type golem = { hp: int, defense: int, attack: int }

    fun inputDamage(1) = 60 + (Word.toInt ((MLton.Random.rand ()) mod 0w40))
      | inputDamage(2) = 30 + (Word.toInt ((MLton.Random.rand ()) mod 0w100))
      | inputDamage(3) = 20 + (Word.toInt ((MLton.Random.rand ()) mod 0w180))
      | inputDamage(_) = (
        print "攻撃手段を選択してください（1．攻撃　2．特技　3．魔法）＞";
        inputDamage (valOf (Int.fromString (valOf (TextIO.inputLine TextIO.stdIn))))
        )

    fun question4 () = (
      let
          val golem = { hp = 300 + (Word.toInt ((MLton.Random.rand ()) mod 0w200)), defense = 80, attack = 50 }
          val playerHp = 200 + (Word.toInt ((MLton.Random.rand ()) mod 0w100))
        in
         print ("ゴーレム　（HP：" ^ (Int.toString (#hp golem)) ^ "　防御力：" ^ (Int.toString (#defense golem)) ^ "）\n");
         let
             fun loop golem' playerHp' = if (#hp golem') = 0 andalso playerHp' <> 0 then
                                            print "ゴーレムを倒しました！\n"
                                          else if (#hp golem') <> 0 andalso playerHp' = 0 then
                                            print "あなたはゴーレムに負けました！ゲームオーバー！\n"
                                          else (
                                            print ("ゴーレム残りHP：" ^ (Int.toString (#hp golem')) ^ "\n");
                                            let
                                                val damage = inputDamage 0
                                              in
                                               print ("基礎攻撃力は" ^ (Int.toString damage) ^ "です。\n");
                                               let
                                                   val damage' = if (damage - (#defense golem')) <= 0 then 0 else (damage - (#defense golem'))
                                                 in
                                                  (case damage' of
                                                       0 => (
                                                         print "ゴーレム：「ハハハハハ、情けないな！貴様は弱すぎる！」\n";
                                                         print ("ゴーレムがあなたを攻撃しました！攻撃値：" ^ (Int.toString (#attack golem')) ^ "\n");
                                                         let
                                                             val hp = if (playerHp' - (#attack golem')) < 0 then 0 else (playerHp' - (#attack golem'))
                                                           in
                                                            print ("あなたの残りHPは：" ^ (Int.toString hp) ^ "\n");
                                                            loop golem' hp
                                                           end
                                                         )
                                                     | _ => (
                                                       print ("ダメージは" ^ (Int.toString damage') ^ "です。\n");
                                                       let
                                                           val hp = if ((#hp golem') - damage') < 0 then 0 else ((#hp golem') - damage')
                                                         in
                                                          print ("残りのHPは" ^ (Int.toString hp) ^ "です。\n");
                                                          loop ({ hp = hp, defense = (#defense golem'), attack = (#attack golem') }) playerHp'
                                                         end
                                                       ))
                                                 end
                                              end
                                            )
           in
            loop golem playerHp
           end
        end
      )
  end
