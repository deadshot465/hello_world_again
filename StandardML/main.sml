structure K01E = Executable(K01)
structure K02E = Executable(K02)
structure K03E = Executable(K03)
structure K04E = Executable(K04)
structure K05E = Executable(K05)
structure K06E = Executable(K06)

val executables = Array.fromList [K01E.execute, K02E.execute,
  K03E.execute, K04E.execute, K05E.execute, K06E.execute]

fun showSelections chapter = (
  let
      val numbers = [1, 2, 3, 4]
    in
     if chapter < 10 then
      List.app (fn x => print ("\t" ^ (Int.toString x) ^ ") K0" ^ (Int.toString chapter) ^ "_" ^ (Int.toString x) ^ "\n")) numbers
     else
      List.app (fn x => print ("\t" ^ (Int.toString x) ^ ") K" ^ (Int.toString chapter) ^ "_" ^ (Int.toString x) ^ "\n")) numbers
    end
  )

fun entry () = (MLton.Random.srand (valOf (MLton.Random.useed ()));
    print "実行したいプログラムを選択してください。\n";
    Array.appi (fn (i, _) =>
      if i < 10 then
        print ((Int.toString (i + 1)) ^ ") K0" ^ (Int.toString (i + 1)) ^ "\t\t")
      else
        print ((Int.toString (i + 1)) ^ ") K" ^ (Int.toString (i + 1)) ^ "\t\t")) executables;
    print "\n";
    let
        val choice = valOf (Int.fromString (valOf (TextIO.inputLine TextIO.stdIn)))
      in
       showSelections choice;
       let
           val choice2 = valOf (Int.fromString (valOf (TextIO.inputLine TextIO.stdIn)))
         in
          (Array.sub (executables, choice - 1)) choice2
         end
      end
  )

val _ = entry ()
