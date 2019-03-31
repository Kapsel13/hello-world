%option yylineno
%option noyywrap
%{
#define YYSTYPE std::string
#include <string>
#include <stdlib.h>
#include "kompilator.tab.h"
int yylex(void);
extern void yyerror (char const *);
using namespace std;
%}
white [ \t]+
digit [0-9]+
integer {digit}
comment "("[^()]*")"
name  [_a-z]+

%%

{comment} { }
{white} { }
{integer} { yylval=(yytext); 
 return num;
}
{name} {    yylval = (yytext);
  return pidentifier;}

"VAR"   return VAR;
"BEGIN" return BEGUN;
"END"   return END;
"WRITE" return WRITE;
"READ"  return READ;
"IF"    return IF;
"THEN"  return THEN;
"ELSE"  return ELSE;
"ENDIF" return ENDIF;
"WHILE" return WHILE;
"DO"    return DO;
"ENDWHILE" return ENDWHILE;
"FOR" return FOR;
"FROM" return FROM;
"TO" return TO;
"ENDFOR" return ENDFOR;
"DOWNTO" return DOWNTO;
"="     return EQUAL;
"<>"    return NEQUAL;
"<"     return SMALLER;
">"     return GRATTER;
"<="    return SMEQUAL;
">="    return GTEQUAL;
":="    return ASIGN;
";"     return SEMICOLON;
"+"     return PLUS;
"-"     return MINUS;
"*"     return TIMES;
"/"     return DIVIDE;
"%"     return MODULO;
"["     return LSQB;
"]"     return RSQB;
\n { }


