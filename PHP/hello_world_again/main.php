<?php

include "src/K01.php";
include "src/K02.php";
include "src/K03.php";
include "src/K04.php";

function show_selections(int $chapter) {
    if ($chapter < 10) {
        for ($i = 1; $i <= 4; $i++) {
            echo "\t" . $i . ") K0" . $chapter . "_" . $i . "\n";
        }
        if ($chapter === 9) {
            echo "\t5) K0" . $chapter . "_5\n";
        }
    } else {
        for ($i = 1; $i <= 4; $i++) {
            echo "\t" . $i . ") K" . $chapter . "_" . $i . "\n";
        }
    }
}

$executables = [
    new K01(), new K02(), new K03(), new K04()
];

for ($i = 0; $i < count($executables); $i++)
{
    echo $i + 1 . ") K0" . $i + 1 . "\t\t";
}
echo "\n";

$input = readline("実行したいプログラムを選択してください。");

if ($input)
{
    show_selections($input);
    $choice_2 = readline();
    if ($choice_2)
    {
        $executables[$input - 1]->execute($choice_2);
    }
}