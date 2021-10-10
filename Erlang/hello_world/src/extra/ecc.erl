-module(ecc).
-compile(export_all).

-spec start_semester() -> pid().
start_semester() ->
    spawn(?MODULE, school, [[]]).

-spec school(_) -> 'ok'.
school(StudentList) ->
    receive
        {From, {join, Student}} ->
            From ! {self(), ok},
            school([Student | StudentList]);
        {From, {leave, Student}} ->
            case lists:member(Student, StudentList) of
                true ->
                    From ! {self(), ok},
                    school(lists:delete(Student, StudentList));
                false ->
                    From ! {self(), not_found},
                    school(StudentList)
            end;
        terminate ->
            ok
    end.

join(Pid, Student) ->
    Pid ! {self(), {join, Student}},
    receive
        {Pid, Msg} -> Msg
    end.

leave(Pid, Student) ->
    Pid ! {self(), {leave, Student}},
    receive
        {Pid, Msg} -> Msg
    end.

-spec start_critic() -> pid().
start_critic() ->
    spawn(?MODULE, restarter, []).

-spec restarter() -> 'ok'.
restarter() ->
    process_flag(trap_exit, true),
    PID = spawn_link(?MODULE, critic, []),
    register(critic, PID),
    receive
        { 'EXIT', PID, normal } ->
            ok;
        { 'EXIT', PID, shutdown } ->
            ok;
        { 'EXIT', PID, _ } ->
            restarter()
    end.

-spec judge(string()) -> string() | atom().
judge(SubjectName) ->
    Ref = make_ref(),
    critic ! { self(), Ref, SubjectName },
    receive
        { Ref, Criticism } -> Criticism
    after 2000 ->
        timeout
    end.

-spec critic() -> no_return().
critic() ->
    receive
        { From, Ref, "iOS Programming" } ->
            From ! { Ref, "iOS is popular and is fun anyway!" };
        { From, Ref, "Server-side Programming" } ->
            From ! { Ref, "Server-side programming has lots of potential. You should learn it!" };
        { From, Ref, "Game Article Reading" } ->
            From ! { Ref, "English is as important as Japanese!" };
        { From, Ref, "Ada" } ->
            From ! { Ref, "A military-grade language used to be used for military and government software that require extreme safety." };
        { From, Ref, "Agda" } ->
            From ! { Ref, "A Haskell-like, non Turing-complete language focusing on theorem proving." };
        { From, Ref, "APL" } ->
            From ! { Ref, "Exotic language with exotic symbols that focuses on array operations." };
        { From, Ref, "C" } ->
            From ! { Ref, "C is an insult to human brains but is slightly better due to its simplicity." };
        { From, Ref, "C++" } ->
            From ! { Ref, "C++ is the biggest insult to human brains." };
        { From, Ref, "C#" } ->
            From ! { Ref, "Microsoft Java is as cool as it sounds." };
        { From, Ref, "Clojure" } ->
            From ! { Ref, "Lisp on JVM that focuses on functional programming." };
        { From, Ref, "COBOL" } ->
            From ! { Ref, "An obsolete language that still has considerable demands due to legacy systems." };
        { From, Ref, "Common Lisp" } ->
            From ! { Ref, "One of the oldest Lispy language that has great support for both FP and OOP (via CLOS)." };
        { From, Ref, "Coq" } ->
            From ! { Ref, "An OCaml-like, non Turing-complete language by Inria focusing on theorem proving." };
        { From, Ref, "Crystal" } ->
            From ! { Ref, "A highly potential language that could have replaced Go had it got enough supports." };
        { From, Ref, "Cython" } ->
            From ! { Ref, "Statically-typed Python with great C interop." };
        { From, Ref, "Dart" } ->
            From ! { Ref, "A language made by Google that features C#-like syntax and runs on Dart VM, but also can be compiled to native binaries. Mainly used with Flutter nowadays." };
        { From, Ref, "Dhall" } ->
            From ! { Ref, "A programmable configuration language that is guaranteed to terminate and is non Turing-complete." };
        { From, Ref, "Elm" } ->
            From ! { Ref, "A pure functional language focusing on simplicity and UI." };
        { From, Ref, "Elixir" } ->
            From ! { Ref, "If you want both Erlang's concurrency, fault-tolerance, scalability and Ruby's syntax. Also more familiar and modern syntax, unlike Erlang's which is inspired by Prolog." };
        { From, Ref, "Erlang" } ->
            From ! { Ref, "The de facto go-to language and platform if you want absolute concurrency." };
        { From, Ref, "F#" } ->
            From ! { Ref, "Microsoft's implementation of OCaml without great module system, but with full .NET interop and ecosystem." };
        { From, Ref, "F*" } ->
            From ! { Ref, "A joint project between Inria and Microsoft Research. A F#-inspired functional language that is Turing-complete." };
        { From, Ref, "Fortran" } ->
            From ! { Ref, "A high level language that has a long history but still used nowadays for paralleled computing." };
        { From, Ref, "Go" } ->
            From ! { Ref, "The worst of all." };
        { From, Ref, "Golang" } ->
            From ! { Ref, "The worst of all." };
        { From, Ref, "Haskell" } ->
            From ! { Ref, "The de facto king of pure functional language." };
        { From, Ref, "Hy" } ->
            From ! { Ref, "Lisp in Python." };
        { From, Ref, "Idris" } ->
            From ! { Ref, "A dependent-typed language that is Turing-complete and features Haskell-flavored syntax." };
        { From, Ref, "Java" } ->
            From ! { Ref, "Java has come a long way. Would be even better without those mindless simps." };
        { From, Ref, "JavaScript" } ->
            From ! { Ref, "The hipster and the de facto language of the web. Also one of the worst languages." };
        { From, Ref, "Julia" } ->
            From ! { Ref, "A relatively new language focusing on speed with C performance and Python-like syntax." };
        { From, Ref, "Kotlin" } ->
            From ! { Ref, "A better Java. Less powerful than Scala. Good for Android development." };
        { From, Ref, "Nim" } ->
            From ! { Ref, "Also a good candidate that could have replaced Go. The documentation needs improvement, and the syntax needs to be unified, though." };
        { From, Ref, "Objective C" } ->
            From ! { Ref, "An outdated language mainly used on development for software on Apple products and now replaced by Swift." };
        { From, Ref, "OCaml" } ->
            From ! { Ref, "A pragmatic FP language with a few OO functioanlity made by Inria. Also used in Facebook Flow and bootstrapping Rust's first compiler." };
        { From, Ref, "Odin" } ->
            From ! { Ref, "A general purpose language that is fairly new." };
        { From, Ref, "Perl" } ->
            From ! { Ref, "A somewhat outdated dynamic language heavily used in the past. The sixth version has been renamed to Raku." };
        { From, Ref, "PHP" } ->
            From ! { Ref, "Oh no." };
        { From, Ref, "Prolog" } ->
            From ! { Ref, "Who needs OOP and FP when you have LP (Logic Programming)?" };
        { From, Ref, "PureScript" } ->
            From ! { Ref, "Pure functional language that almost has the exactly same syntax with Haskell and transpiles to JavaScript." };
        { From, Ref, "Python" } ->
            From ! { Ref, "Go-to language for new programmers, students, competitive programming and data science thanks to great projects such as NumPy, scikit-learn, PyTorch, Anaconda, etc." };
        { From, Ref, "R" } ->
            From ! { Ref, "A relatively academic language mainly used in statistics." };
        { From, Ref, "Raku" } ->
            From ! { Ref, "Perl 6 is here!" };
        { From, Ref, "ReasonML" } ->
            From ! { Ref, "A different flavor of OCaml catering to JS developers." };
        { From, Ref, "ReScript" } ->
            From ! { Ref, "A newborn language based on ReasonML that focuses on JavaScript interop and more JavaScript syntax." };
        { From, Ref, "Ruby" } ->
            From ! { Ref, "A fun-to-use interpreted language. The language of the famous Ruby on Rails framework." };
        { From, Ref, "Rust" } ->
            From ! { Ref, "A low level language focusing on memory safety, thread safety, zero cost abstraction and performance." };
        { From, Ref, "Scala" } ->
            From ! { Ref, "Extremely powerful compromise between FP and OOP." };
        { From, Ref, "Standard ML" } ->
            From ! { Ref, "A different ML language mainly used in academics." };
        { From, Ref, "Swift" } ->
            From ! { Ref, "The de facto programming language nowadays for macOS, iOS, iPadOS, watchOS and tvOS development." };
        { From, Ref, "TypeScript" } ->
            From ! { Ref, "JavaScript with static typing and static analysis. Full support for existing JavaScript libraries." };
        { From, Ref, "V" } ->
            From ! { Ref, "A.k.a. meme language." };
        { From, Ref, "Zig" } ->
            From ! { Ref, "A low level language which intends to replace C." };
        { From, Ref, _ } ->
            From ! { Ref, "Sorry I don't have any comments for that!" }
    end,
    critic().