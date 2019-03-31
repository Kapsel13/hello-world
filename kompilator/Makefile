a.out:  kompilator.tab.c kompilator.tab.h lex.yy.c
	g++ kompilator.tab.c kompilator.tab.h lex.yy.c -std=c++11 -lfl

lex.yy.c: kompilator.l
	  flex kompilator.l
kompilator.tab.h kompilator.tab.c: kompilator.y
					bison -d kompilator.y
