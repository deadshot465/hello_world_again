open Question;

module Executable = (M: Question) => {
    let execute =
    fun
    | 1 => M.question_1()
    | 2 => M.question_2()
    | 3 => M.question_3()
    | 4 => M.question_4()
    | _ => ();
};