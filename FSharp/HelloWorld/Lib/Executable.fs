namespace HelloWorld.Lib

type Executable(m: Question) =
    member public this.execute num =
        match num with
        | 1 -> m.question_1 ()
        | 2 -> m.question_2 ()
        | 3 -> m.question_3 ()
        | 4 -> m.question_4 ()
        | _ -> ()