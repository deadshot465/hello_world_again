#!/usr/bin/env perl6
use K01;
use K02;
use K03;
use K04;

sub show_selections(Int $chapter) {
    if $chapter < 10 {
        for 1..4 -> $i {
            say "\t{ $i }) K0{ $chapter }_{ $i }";
        }
        if $chapter == 9 {
            say "\t5) K0{ $chapter }_5";
        }
    } else {
        for 1..4 -> $i {
            say "\t{ $i }) K{ $chapter }_{ $i }";
        }
    }
}

my @executables = [K01.new(), K02.new(), K03.new(), K04.new()];

say '実行したいプログラムを選択してください。';
for ^@executables.elems -> $i {
    if $i < 10 {
        print "{ $i + 1 }) K0{ $i + 1 }\t\t";
    } else {
        print "{ $i + 1 }) K{ $i + 1 }\t\t";
    }
}

my $choice = prompt('');
show_selections($choice);
my $choice_2 = prompt('');
@executables[$choice - 1].execute($choice_2);