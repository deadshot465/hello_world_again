<?php

class K04 implements IExecutable
{

    public function question_1()
    {
        $age = readline("年齢を入力してください。＞");
        if ($age < 3 || $age >= 70)
        {
            echo "入場料金無料です。\n";
        }
        else
        {
            echo "通常料金です。\n";
        }
    }

    public function question_2()
    {
        $gender = readline("性別を選択してください。（０：男性　１：女性）＞");
        echo match ((int)$gender) {
            0 => "あら、格好良いですね。\n",
            1 => "あら、モデルさんみたいですね。\n",
            default => "そんな選択肢はありません。\n",
        };
    }

    public function question_3()
    {
        $age = readline("年齢を入力してください。＞");
        if ($age < 3 || $age >= 70)
        {
            echo "入場料金無料です。\n";
        }
        else if ($age >= 3 && $age <= 15)
        {
            echo "子供料金で半額です。\n";
        }
        else if ($age >= 60 && $age < 70)
        {
            echo "シニア割引で一割引きです。\n";
        }
        else
        {
            echo "通常料金です。\n";
        }
    }

    public function question_4()
    {
        echo "＊＊＊おみくじプログラム＊＊＊\n";
        $choice = (int)readline("おみくじを引きますか　（はい：１　いいえ：０）＞");

        if ($choice >= 1)
        {
            echo match (rand(0, 4)) {
                0 => "大吉　とってもいいことがありそう！！\n",
                1 => "中吉　きっといいことあるんじゃないかな\n",
                2 => "小吉　少しぐらいはいいことあるかもね\n",
                3 => "凶　今日はおとなしくておいた方がいいかも\n",
                4 => "大凶　これじゃやばくない？早く家に帰った方がいいかも\n",
                default => ""
            };
        }
    }

    public function execute(int $num): void
    {
        switch ($num) {
            case 1:
                $this->question_1();
                break;
            case 2:
                $this->question_2();
                break;
            case 3:
                $this->question_3();
                break;
            case 4:
                $this->question_4();
                break;
        }
    }
}