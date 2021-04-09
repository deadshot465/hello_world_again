<?php

class K03 implements IExecutable
{

    public function question_1()
    {
        $age = readline("年齢を入力してください。＞");
        if ($age < 20)
        {
            echo "未成年なので購入できません。";
        }
    }

    public function question_2()
    {
        $height = readline("身長を入力してください。＞");
        $height /= 100.0;
        $weight = readline("体重を入力してください。＞");
        $standard = ($height * $height) * 22.0;
        echo "あなたの標準体重は" . $standard . "です。\n";

        if ($weight > $standard && ($weight - $standard) / $standard * 100.0 > 14.0)
        {
            echo "太り気味です。";
        }
        else if ($weight < $standard && ($weight - $standard) / $standard * 100.0 < -14.0)
        {
            echo "痩せ気味です。";
        }
        else
        {
            echo "普通ですね。";
        }
    }

    public function question_3()
    {
        $random_number = rand(0, 99);
        echo "０から９９の範囲の数値が決定されました。\n";
        $guess = readline("決められた数値を予想し、この数値よりも大きな値を入力してください＞");
        echo "決められた数値は" . $random_number . "です。\n";
        if ($guess > $random_number)
        {
            echo "正解です。";
        }
        else
        {
            echo "不正解です。";
        }
    }

    public function question_4()
    {
        $random_number = rand(0, 99);
        echo "０から９９の範囲の数値が決定されました。\n";
        $guess = readline("決められた数値を予想し、この数値よりも大きな値を入力してください＞");
        echo "決められた数値は" . $random_number . "です。\n";

        if ($guess < 0 || $guess > 99)
        {
            echo "反則です！";
        }
        else if ($guess > $random_number && $guess - $random_number <= 10)
        {
            echo "大正解です！";
        }
        else if ($random_number > $guess && $random_number - $guess <= 10)
        {
            echo "惜しい！";
        }
        else if ((int)$guess === $random_number)
        {
            echo "お見事！";

        }
        else
        {
            if ($guess > $random_number)
            {
                echo "正解です。";
            }
            else
            {
                echo "不正解です。";
            }
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