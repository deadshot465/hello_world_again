open Question;

module K04: Question = {
    let question_1 = () => {
        print_string("年齢を入力してください。＞");
        let age = read_int();
        if (age < 3 || age >= 70) {
            print_endline("入場料金無料です。");
        } else {
            print_endline("通常料金です。");
        }
    };
    
    let question_2 = () => {
        print_string("性別を選択してください。（０：男性　１：女性）＞");
        switch (read_int()) {
            | 0 => print_endline("あら、格好良いですね。")
            | 1 => print_endline("あら、モデルさんみたいですね。")
            | _ => print_endline("そんな選択肢はありません。");
        }
    };
    
    let question_3 = () => {
        print_string("年齢を入力してください。＞");
        let age = read_int();
        switch (age) {
            | x when x < 3 || x >= 70 => print_endline("入場料金無料です。")
            | x when x >= 3 && x <= 15 => print_endline("子供料金で半額です。")
            | x when x >= 60 && x < 70 => print_endline("シニア割引で一割引きです。")
            | _ => print_endline("通常料金です。");
        }
    };
    
    let question_4 = () => {
        Random.self_init();
        print_endline("＊＊＊おみくじプログラム＊＊＊");
        print_string("おみくじを引きますか　（はい：１　いいえ：０）＞");
        let choice = read_int();
        if (choice >= 1) {
            print_endline(switch (Random.int(5)) {
                | 0 => "大吉　とってもいいことがありそう！！"
                | 1 => "中吉　きっといいことあるんじゃないかな"
                | 2 => "小吉　少しぐらいはいいことあるかもね"
                | 3 => "凶　今日はおとなしくておいた方がいいかも"
                | 4 => "大凶　これじゃやばくない？早く家に帰った方がいいかも"
                | _ => ""
            });
        }
    };
};