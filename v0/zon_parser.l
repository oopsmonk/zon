%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "zon_parser.tab.h"
%}

%%

"var"                  { return VAR; }
"fn"                   { return FN; }
"if"                   { return IF; }
"else"                 { return ELSE; }
"for"                  { return FOR; }
"in"                   { return IN; }
"while"                { return WHILE; }
"true"                 { return BOOL_LITERAL; }
"false"                { return BOOL_LITERAL; }

"int"                  { return INT_TYPE; }
"float"                { return FLOAT_TYPE; }
"bool"                 { return BOOL_TYPE; }
"string"               { return STRING_TYPE; }

"=="                   { return EQUALITY_OP; }
"!="                   { return EQUALITY_OP; }
"<="                   { return RELATIONAL_OP; }
">="                   { return RELATIONAL_OP; }
"<"                    { return RELATIONAL_OP; }
">"                    { return RELATIONAL_OP; }

"+"                    { return ADD_OP; }
"-"                    { return ADD_OP; }
"*"                    { return MUL_OP; }
"/"                    { return MUL_OP; }
"%"                    { return MUL_OP; }

"||"                   { return LOGICAL_OP; }
"&&"                   { return LOGICAL_OP; }

"!"                    { return NOT_OP; }
"~"                    { return NOT_OP; }
"|"                    { return BITWISE_OP; }
"^"                    { return BITWISE_OP; }
"&"                    { return BITWISE_OP; }
"<<"                   { return SHIFT_OP; }
">>"                   { return SHIFT_OP; }

"="                    { return ASSIGN_OP; }
":"                    { return COLON; }
","                    { return COMMA; }
";"                    { return SEMICOLON; }
"("                    { return LPAREN; }
")"                    { return RPAREN; }
"{"                    { return LBRACE; }
"}"                    { return RBRACE; }
"["                    { return LBRACKET; }
"]"                    { return RBRACKET; }

[a-zA-Z_][a-zA-Z0-9_]* { yylval.string_val = strdup(yytext); return IDENTIFIER; }
[0-9]+                 { yylval.int_val = atoi(yytext); return INT_LITERAL; }
[0-9]+\.[0-9]+         { yylval.float_val = atof(yytext); return FLOAT_LITERAL; }
\"([^\\\"]|\\.)*\"     { yylval.string_val = strdup(yytext+1); yylval.string_val[strlen(yytext)-2] = '\0'; return STRING_LITERAL; }
[ \t\n\r]              { /* ignore whitespace */ }
.                      { printf("Unrecognized character: %s\n", yytext); return -1; }

%%

int yywrap() {
    return 1;
}
