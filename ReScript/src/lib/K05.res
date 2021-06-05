open Question

module K05: Question = {
    let question_1 = () => {
        let salary = 19.0
        let age = 22
        let rec loop = (salary', age') => {
            switch (salary') {
                | x when x < 50.0 => loop(salary' *. 1.035, age' + 1)
                | _ => print_endline(j`$age'歳で月給$salary'万円`)
            }
        }
        loop(salary, age)
    }

    let question_2 = () => {
        let rec loop = choice => {
            switch choice {
                | x when x != 1 => {
                    print_endline("起きろ～")
                    print_string("1．起きた　2．あと5分…　3．Zzzz…\t入力：")
                    let choice' = read_int()
                    loop(choice')
                }
                | _ => print_endline("よし、学校へ行こう！")
            }
        }
        loop(0)
    }

    let question_3 = () => {
        let rec loop = choice => {
            switch choice {
                | x when x != 1 => {
                    print_endline("起きろ～")
                    print_string("1．起きた　2．あと5分…　3．Zzzz…\t入力：")
                    let choice' = read_int()
                    loop(choice')
                }
                | _ => {
                    print_endline("よし、学校へ行こう！")
                    loop(0)
                }
            }
        }
        loop(0)
    }

    type golem = {
        hp: int,
        defense: int,
        attack: int,
    }

    let rec input_damage = choice => {
        switch choice {
            | 1 => 60 + Random.int(40)
            | 2 => 30 + Random.int(100)
            | 3 => 20 + Random.int(180)
            | _ => {
                print_endline("攻撃手段を選択してください（1．攻撃　2．特技　3．魔法）＞")
                input_damage(read_int())
            }
        }
    }

    let question_4 = () => {
        Random.self_init()
        let golem = { hp: 300 + Random.int(200), defense: 80, attack: 50 }
        let player_hp = 200 + Random.int(100)
        print_endline(`ゴーレム　（HP：${string_of_int(golem.hp)}　防御力：${string_of_int(golem.defense)}）`)

        let rec loop = (golem', player_hp') => {
            switch (golem'.hp, player_hp') {
                | (x, y) when x == 0 && y != 0 => print_endline("ゴーレムを倒しました！")
                | (x, y) when x != 0 && y == 0 => print_endline("あなたはゴーレムに負けました！ゲームオーバー！")
                | (x, y) => {
                    print_endline(j`ゴーレム残りHP：$x`)
                    let damage = input_damage(0)
                    print_endline(j`基礎攻撃力は$damageです。`)
                    let damage = if (damage - golem'.defense <= 0) {
                        0
                    } else {
                        damage - golem'.defense
                    }
                    switch damage {
                        | 0 => {
                            print_endline("ゴーレム：「ハハハハハ、情けないな！貴様は弱すぎる！」")
                            print_endline(`ゴーレムがあなたを攻撃しました！攻撃値：${string_of_int(golem'.attack)}`)
                            let y' = if y - golem'.attack < 0 {
                                0
                            } else {
                                y - golem'.attack
                            }
                            print_endline(j`あなたの残りHPは：$y'`)
                            loop(golem', y')
                        }
                        | _ => {
                            print_endline(j`ダメージは$damageです。`)
                            let x' = if x - damage < 0 {
                                0
                            } else {
                                x - damage
                            }
                            print_endline(j`残りのHPは$x'です。`)
                            loop({ hp: x', defense: golem'.defense, attack: golem'.attack }, y)
                        }
                    }
                }
            }
        }
        loop(golem, player_hp)
    }
}