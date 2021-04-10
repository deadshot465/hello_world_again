use Golem;

class K02 is export {
    method question_1 {
        my $seisuu = 3;
        my $jissuu = 2.6;
        my $moji = 'A';
        say "変数seisuuの値は{ $seisuu }";
        say "変数jissuuの値は{ $jissuu }";
        say "変数mojiの値は{ $moji }";
    }

    method question_2 {
        my $number_1 = prompt('一つ目の整数は？');
        my $number_2 = prompt('二つ目の整数は？');
        say "{ $number_1 }÷{ $number_2 }={ $number_1 / $number_2 }...{ $number_1 % $number_2 }";
    }

    method question_3 {
        my $price_a = prompt('一つ目の商品の値段は？');
        my $amount_a = prompt('個数は？');
        my $price_b = prompt('二つ目の商品の値段は？');
        my $amount_b = prompt('個数は？');

        my $total = ($price_a * $amount_a + $price_b * $amount_b) * 1.08;
        say "お支払いは税込み￥{ $total }です。";
    }

    method question_4 {
        my $golem = Golem.new(hp => 300, defense => 80, attack => 70);
        say "ゴーレム　（HP：{ $golem.hp }　防御力：{ $golem.defense }）";
        say "HP：{ $golem.hp }";
        my $damage = prompt('今回の攻撃の値を入力してください＞');

        if $damage - $golem.defense > 0 {
            $damage -= $golem.defense;
        } else {
            $damage = 0;
        }

        say "ダメージは{ $damage }です。";
        $golem.hp -= $damage;
        say "残りのHPは{ $golem.hp }です。";
    }

    method execute(Int $num) {
        given $num {
            when 1 { $.question_1 }
            when 2 { $.question_2 }
            when 3 { $.question_3 }
            when 4 { $.question_4 }
        }
    }
}