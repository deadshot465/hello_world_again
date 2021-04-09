<?php

include "src/Golem.php";

class K02 implements IExecutable
{

    public function question_1()
    {
        $seisuu = 3;
        $jissuu = 2.6;
        $moji = 'A';
        echo "変数seisuuの値は" . $seisuu . "\n";
        echo "変数jissuuの値は" . $jissuu . "\n";
        echo "変数mojiの値は" . $moji . "\n";
    }

    public function question_2()
    {
        $number_1 = readline("一つ目の整数は？");
        $number_2 = readline("二つ目の整数は？");
        echo $number_1 . "÷" . $number_2 . "=" . $number_1 / $number_2 . "..." . $number_1 % $number_2;
    }

    public function question_3()
    {
        $price_A = readline("一つ目の商品の値段は？");
        $amount_A = readline("個数は？");
        $price_B = readline("二つ目の商品の値段は？");
        $amount_B = readline("個数は？");
        $total = ($price_A * $amount_A + $price_B * $amount_B) * 1.08;
        echo "お支払いは税込み￥" . $total;
    }

    public function question_4()
    {
        $golem = new Golem();
        echo "ゴーレム　（HP：" . $golem->hp . "　防御力：" . $golem->defense . "\n";
        echo "HP：" . $golem->hp . "\n";
        $damage = readline("今回の攻撃の値を入力してください＞");

        if ($damage - $golem->defense > 0)
        {
            $damage -= $golem->defense;
        }
        else
        {
            $damage = 0;
        }

        echo "ダメージは" . $damage . "です。\n";
        $golem->hp -= $damage;
        echo "残りのHPは" . $golem->hp . "です。";
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