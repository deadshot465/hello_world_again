class K03 is export {
    method question_1 {
        my $age = prompt('年齢を入力してください。＞');
        if $age < 20 {
            say '未成年なので購入できません。';
        }
    }

    method question_2 {
        my $height = prompt('身長を入力してください。＞');
        $height /= 100.0;

        my $weight = prompt('体重を入力してください。＞');
        my $standard = $height * $height * 22.0;
        say "あなたの標準体重は{ $standard }です。";
        if $weight > $standard && ($weight - $standard) / $standard * 100.0 > 14.0 {
            say '太り気味です。';
        } elsif $weight < $standard && ($weight - $standard) / $standard * 100.0 < -14.0 {
            say '痩せ気味です。';
        } else {
            say '普通ですね。';
        }
    }

    method question_3 {
        my $random_number = 99.rand.Int;
        say '０から９９の範囲の数値が決定されました。';
        my $guess = prompt('決められた数値を予想し、この数値よりも大きな値を入力してください＞');

        say "決められた数値は{ $random_number }です。";
        if $guess > $random_number {
            say '正解です。';
        } else {
            say '不正解です。';
        }
    }

    method question_4 {
        my $random_number = 99.rand.Int;
        say '０から９９の範囲の数値が決定されました。';
        my $guess = prompt('決められた数値を予想し、この数値よりも大きな値を入力してください＞');

        say "決められた数値は{ $random_number }です。";
        if $guess < 0 || $guess > 99 {
            say '反則です！';
        } elsif $guess > $random_number && $guess - $random_number <= 10 {
            say '大正解です！！';
        } elsif $guess < $random_number && $random_number - $guess <= 10 {
            say '惜しい！';
        } elsif $guess == $random_number {
            say 'お見事！';
        } else {
            if $guess > $random_number {
                say '正解です。';
            } else {
                say '不正解です。';
            }
        }
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