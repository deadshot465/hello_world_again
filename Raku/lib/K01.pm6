class K01 is export {
    method question_1 {
        say 'Hello World!　ようこそRaku/Perl 6言語の世界へ！';
    }

    method question_2 {
        say 'Hello World!';
        say 'ようこそ';
        say 'Raku/Perl 6言語の世界へ！';
    }

    method question_3 {
        say "整数：{ 12345 }";
        say "実数：{ 123.456789 }";
        say "文字：{ 'A' }";
        say "文字列：{ 'ABCdef' }";
    }

    method question_4 {
        say '              ##';
	    say '             #  #';
	    say '             #  #';
	    say '            #    #';
	    say '           #      #';
	    say '         ##        ##';
	    say '       ##            ##';
	    say '    ###                ###';
	    say ' ###       ##    ##       ###';
	    say '##        #  #  #  #        ##';
	    say '##         ##    ##         ##';
	    say ' ##     #            #     ##';
	    say '  ###     ##########     ###';
	    say '     ###              ###';
	    say '        ##############';
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