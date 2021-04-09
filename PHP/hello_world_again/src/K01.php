<?php

include "IExecutable.php";

class K01 implements IExecutable
{

    public function question_1()
    {
        echo "Hello World!　ようこそPHP言語の世界へ！";
    }

    public function question_2()
    {
        echo "Hello World!\n";
        echo "ようこそ\n";
        echo "PHP言語の世界へ！\n";
    }

    public function question_3()
    {
        echo "整数：" . 12345 . "\n";
        echo "実数：" . 123.456789 . "\n";
        echo "文字：" . 'A' . "\n";
        echo "文字列：" . "ABCdef" . "\n";
    }

    public function question_4()
    {
        echo "              ##\n";
        echo "             #  #\n";
        echo "             #  #\n";
        echo "            #    #\n";
        echo "           #      #\n";
        echo "         ##        ##\n";
        echo "       ##            ##\n";
        echo "    ###                ###\n";
        echo " ###       ##    ##       ###\n";
        echo "##        #  #  #  #        ##\n";
        echo "##         ##    ##         ##\n";
        echo " ##     #            #     ##\n";
        echo "  ###     ##########     ###\n";
        echo "     ###              ###\n";
        echo "        ##############\n";
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