<?php

interface IExecutable
{
    public function question_1();
    public function question_2();
    public function question_3();
    public function question_4();
    public function execute(int $num): void;
}