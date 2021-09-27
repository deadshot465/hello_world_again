namespace HelloWorld.Lib

type Executable(m: IQuestion) =
    member public this.Execute num =
        match num with
        | 1 -> m.Question1 ()
        | 2 -> m.Question2 ()
        | 3 -> m.Question3 ()
        | 4 -> m.Question4 ()
        | _ -> ()