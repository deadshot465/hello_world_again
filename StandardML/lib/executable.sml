functor Executable(M: Question) =
  struct
    fun execute(1) = M.question1 ()
      | execute(2) = M.question2 ()
      | execute(3) = M.question3 ()
      | execute(4) = M.question4 ()
      | execute(_) = ()
  end
