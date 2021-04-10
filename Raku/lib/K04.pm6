class K04 is export {
    method question_1 {
        my $age = prompt('年齢を入力してください。＞');
        if $age < 3 || $age >= 70 {
            say '入場料金無料です。';
        } else {
            say '通常料金です。';
        }
    }

    method question_2 {
        my $gender = prompt('性別を選択してください。（０：男性　１：女性）＞');

        given $gender {
            when 0 { say 'あら、格好良いですね。'; }
            when 1 { say 'あら、モデルさんみたいですね。'; }
            default { say 'そんな選択肢はありません。'; }
        }
    }

    method question_3 {
        my $age = prompt('年齢を入力してください。＞');
        if $age < 3 || $age >= 70 {
            say '入場料金無料です。';
        } elsif $age >= 3 && $age <= 15 {
            say '子供料金で半額です。';
        } elsif $age >= 60 && $age < 70 {
            say 'シニア割引で一割引きです。';
        } else {
            say '通常料金です。';
        }
    }

    method question_4 {
        say '＊＊＊おみくじプログラム＊＊＊';
        my $choice = prompt('おみくじを引きますか　（はい：１　いいえ：０）＞');
        if $choice >= 1 {
            given 5.rand.Int {
                when 0 { say '大吉　とってもいいことがありそう！！'; }
                when 1 { say '中吉　きっといいことあるんじゃないかな'; }
                when 2 { say '小吉　少しぐらいはいいことあるかもね'; }
                when 3 { say '凶　今日はおとなしくておいた方がいいかも'; }
                when 4 { say '大凶　これじゃやばくない？早く家に帰った方がいいかも'; }
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