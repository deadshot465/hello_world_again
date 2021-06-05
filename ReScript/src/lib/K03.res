open Question

module K03: Question = {
    let question_1 = () => {
        print_string("年齢を入力してください。＞")
        let age = read_int()
        if age < 20 {
            print_endline("未成年なので購入できません。")
        }
    }

    let question_2 = () => {
        print_string("身長を入力してください。＞")
        let height = read_float() *. 0.01
        print_string("体重を入力してください。＞")
        let weight = read_float()
        let standard = height *. height *. 22.0
        print_endline(j`あなたの標準体重は$standardです。`)
        switch weight {
            | x when x > standard && (x -. standard) /. standard *. 100.0 > 14.0 =>
                print_endline("太り気味です。")
            | x when x < standard && (x -. standard) /. standard *. 100.0 < -14.0 =>
                print_endline("痩せ気味です。")
            | _ => print_endline("普通ですね。")
        }
    }

    let question_3 = () => {
        Random.self_init()
        let random_number = Random.int(100)
        print_endline("０から９９の範囲の数値が決定されました。")
        print_string("決められた数値を予想し、この数値よりも大きな値を入力してください＞")
        let guess = read_int()
        print_endline(j`決められた数値は$random_numberです。`)
        print_endline(if guess > random_number {
            "正解です。"
        } else {
            "不正解です。"
        })
    }

    let question_4 = () => {
        Random.self_init()
        let random_number = Random.int(100)
        print_endline("０から９９の範囲の数値が決定されました。")
        print_string("決められた数値を予想し、この数値よりも大きな値を入力してください＞")
        let guess = read_int()
        print_endline(j`決められた数値は$random_numberです。`)
        print_endline(
            switch guess {
                | x when x < 0 || x > 99 => "反則です！"
                | x when x > random_number && x - random_number <= 10 => "大正解です！"
                | x when x < random_number && random_number - x <= 10 => "惜しい！"
                | x when x == random_number => "お見事！"
                | _ => if guess > random_number {
                    "正解です。"
                } else {
                    "不正解です。"
                }
            }
        )
    }
}