<?php


class Golem
{
    public int $hp = 0;
    public int $defense = 0;
    public int $attack = 0;

    public function __construct(int $hp = 300, int $defense = 80, int $attack = 50)
    {
        $this->hp = $hp;
        $this->defense = $defense;
        $this->attack = $attack;
    }
}