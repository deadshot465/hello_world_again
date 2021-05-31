structure K06 : Question =
  struct
    fun getAges () = (
      let
          fun inputAge no amount acc =
            (case amount of
                 0 => acc
               | _ => (
                 print ((Int.toString (no + 1)) ^ "人目の年齢を入力して下さい：");
                 inputAge (no + 1) (amount - 1) ((valOf (Int.fromString (valOf (TextIO.inputLine TextIO.stdIn)))) :: acc)
                 ))
        in
         inputAge 0 5 []
        end
      )

    fun question1 () = (
      let
          val ages = getAges ()
          val count = List.length ages
          val totalAges = List.foldl (fn (acc, elem) => acc + elem) 0 ages
        in
         print ((Int.toString count) ^ "人の平均年齢は" ^ (Real.toString ((Real.fromInt totalAges) / (Real.fromInt count))) ^ "です。")
        end
      )

    fun makeUpperPyramid levels = (
      let
          fun make current levels' acc = (
            (case levels' of
                 0 => acc
               | _ => make (current + 1) (levels' - 1) ((String.implode (List.tabulate (current + 1, fn _ => #"*"))) :: acc))
            )
        in
         List.rev (make 0 levels [])
        end
      )

    fun makeLowerPyramid levels = (
      let
          fun make levels' acc = (
            (case levels' of
                 0 => acc
               | _ => make (levels' - 1) ((String.implode (List.tabulate (levels', fn _ => #"*"))) :: acc))
            )
        in
         List.rev (make levels [])
        end
      )

    fun makeSpecialPyramid levels = (
      let
          fun make amountOfStars amountOfSpaces acc = (
            (case amountOfStars of
                 0 => acc
               | _ => make (amountOfStars - 1) (amountOfSpaces + 1) (((String.implode (List.tabulate (amountOfSpaces, fn _ => #" "))) ^ (String.implode (List.tabulate (amountOfStars, fn _ => #"*"))) :: acc)))
            )
        in
         make levels 0 []
        end
      )

    fun question2 () = (
      print (String.concatWith "\n" (makeUpperPyramid 8));
      print "\n\n";
      print (String.concatWith "\n" (makeLowerPyramid 8));
      print "\n\n";
      print (String.concatWith "\n" (makeSpecialPyramid 8))
      )

    fun countCombinations amount = (
      let
          fun countTens remains = remains div 10

          fun countFifties amount remains arr = if amount < 0 then arr
                                                else countFifties (amount - 1) remains ((amount, (countTens (remains - (50 * amount)))) :: arr)

          fun countHundreds amount remains arr = if amount < 0 then arr
                                                 else (
                                                   let
                                                       val remains' = remains - (100 * amount)
                                                       val arr' = List.map (fn (x, y) => (amount, x, y)) (countFifties (remains' div 50) remains' [])
                                                     in
                                                      countHundreds (amount - 1) remains (arr' @ arr)
                                                     end
                                                   )
        in
         countHundreds (amount div 100) amount []
        end
      )

    fun question3 () = (
      let
          val combinations = List.map (fn (x, y, z) => ("10円の硬貨" ^ (Int.toString z) ^ "枚 50円の硬貨" ^ (Int.toString y) ^ "枚 100円の硬貨" ^ (Int.toString x) ^"枚\n")) (countCombinations 370)
        in
         print (String.concatWith "\n" combinations);
         print ("\n以上" ^ (Int.toString (List.length combinations)) ^ "通りを発見しました。\n")
        end
      )

    fun question4 () = (
      print "\t|\t";
      let
          fun printOneToTen num arr = (
            (case num of
                 0 => arr
               | _ => printOneToTen (num - 1) (num :: arr))
            )
        in
         print (String.concatWith "\t" (List.map (fn x => Int.toString x) (printOneToTen 9 [])));
         print "\n";
         print (String.implode (List.tabulate (90, fn _ => #"-")));
         print "\n";
         let
             fun calculations i arr = (
               let
                   fun multiplication j arr = (
                     (case j of
                          0 => arr
                        | _ => multiplication (j - 1) ((i * j) :: arr))
                     )
                 in
                  (case i of
                       0 => arr
                     | _ => calculations (i - 1) ((multiplication 9 []) :: arr))
                 end
               )
           in
            print (
              String.concatWith "\n" (Vector.foldr (op::) [] (
                Vector.mapi (fn (i, x) => (
                  let
                      val innerList = String.concatWith "\t" (List.map (fn y => Int.toString y) x)
                    in
                     (Int.toString (i + 1)) ^ "\t|\t" ^ innerList
                    end
                  )) (Vector.fromList (calculations 9 []))
                ))
              )
           end
        end
      )
  end
