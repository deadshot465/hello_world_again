open Question;

module K06: Question = {
    let get_ages = {
        let rec input_age = no => amount => acc => {
            switch (amount) {
                | 0 => acc
                | _ => {
                    Printf.printf("%d人目の年齢を入力して下さい：", no + 1);
                    input_age(no + 1, amount - 1, [read_int(), ...acc]);
                }
            }
        };
        input_age(0, 5, [])
    }

    let question_1 = () => {
        let ages = get_ages;
        let count = List.length(ages);
        let total_ages = List.fold_left((acc, elem) => acc + elem, 0, ages);
        Printf.printf("%d人の平均年齢は%fです。", count, float_of_int(total_ages) /. float_of_int(count));
    }

    let make_upper_pyramid = levels => {
        let rec make = current => levels' => acc => {
            switch (levels') {
                | 0 => acc
                | _ => make(current + 1, levels' - 1, [String.make(current + 1, '*'), ...acc]);
            }
        };
        make(0, levels, []) |> List.rev;
    }

    let make_lower_pyramid = levels => {
        let rec make = levels' => acc => {
            switch (levels') {
                | 0 => acc
                | _ => make(levels' - 1, [String.make(levels', '*'), ...acc]);
            }
        };
        make(levels, []) |> List.rev;
    }

    let make_special_pyramid = levels => {
        let rec make = amount_of_stars => amount_of_spaces => acc => {
            switch (amount_of_stars) {
                | 0 => acc
                | _ => make(amount_of_stars - 1, amount_of_spaces + 1, [String.make(amount_of_stars, '*') ++ String.make(amount_of_spaces, ' '), ...acc]);
            }
        };
        make(levels, 0, []);
    }

    let question_2 = () => {
        make_upper_pyramid(8)
        |> String.concat("\n")
        |> print_endline;

        make_lower_pyramid(8)
        |> String.concat("\n")
        |> print_endline;

        make_special_pyramid(8)
        |> String.concat("\n")
        |> print_endline;
    }

    let question_3 = () => {
        ()
    }

    let question_4 = () => {
        ()
    }
}