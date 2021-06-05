open Question

module K02: Question = {
    let question_1 = () => {
        let seisuu = 3
        let jissuu = 2.6
        let moji = 'A'
        print_endline(j`変数seisuuの値は$seisuu`)
        print_endline(j`変数jissuuの値は$jissuu`)
        print_endline(j`変数mojiの値は$moji`)
    }

    let question_2 = () => {
        print_string("一つ目の整数は？")
        let number_1 = read_int()
        print_string("二つ目の整数は？")
        let number_2 = read_int()
        print_string(j`$number_1÷$number_2=${string_of_int(number_1 / number_2)}...${string_of_int(mod(number_1, number_2))}`)
    }

    let question_3 = () => {
        print_string("一つ目の商品の値段は？")
        let price_A = read_int()
        print_string("個数は？")
        let amount_A = read_int()
        print_string("二つ目の商品の値段は？")
        let price_B = read_int()
        print_string("個数は？")
        let amount_B = read_int()
        let total = float_of_int(price_A * amount_A + price_B * amount_B) *. 1.1
        print_endline(j`お支払いは税込み￥$total`)
    }

    type golem = {
        hp: int,
        defense: int,
        attack: int
    }

    let question_4 = () => {
        let golem = { hp: 300, defense: 80, attack: 50 }
        print_endline(j`ゴーレム　（HP：${string_of_int(golem.hp)}　防御力：${string_of_int(golem.defense)}）`)
        print_endline("HP：" ++ string_of_int(golem.hp))
        print_string("今回の攻撃の値を入力してください＞")
        let damage = read_int()
        let final_damage = if damage - golem.defense > 0 {
            damage - golem.defense
        } else {
            0
        }
        print_endline(j`ダメージは$final_damageです。`)
        let golem = { hp: golem.hp - final_damage, defense: golem.defense, attack: golem.attack }
        print_endline(`残りのHPは${string_of_int(golem.hp)}です。`)
    }
}