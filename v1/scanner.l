%option header-file="scanner.h"

%{
#include "parser.tab.h"
#include <string.h>
%}

DIGIT           [0-9]
LETTER          [A-Za-z]
WHITESPACE      [ \t\n]

%%

"fn"            { return FN; }
"var"           { return VAR; }
"if"            { return IF; }
"else"          { return ELSE; }
"for"           { return FOR; }
"return"        { return RETURN; }

"int"           { return INT_TYPE; }
"float"         { return FLOAT_TYPE; }
"string"        { return STRING_TYPE; }
"bool"          { return BOOL_TYPE; }

{DIGIT}+        { yylval.integer = atoi(yytext); return INT_CONSTANT; }
{DIGIT}+\.{DIGIT}+ { yylval.real = atof(yytext); return FLOAT_CONSTANT; }
\"([^\\\n]|(\\.))*\"  { yylval.string = strdup(yytext); return STRING_CONSTANT; }
"true"|"false"  { yylval.boolean = strcmp(yytext, "true") == 0 ? 1 : 0; return BOOL_CONSTANT; }

"=="            { return EQ; }
"!="            { return NEQ; }
"<"             { return LT; }
">"             { return GT; }
"<="            { return LTE; }
">="            { return GTE; }

"+"             { return PLUS; }
"-"             { return MINUS; }
"*"             { return MUL; }
"/"             { return DIV; }
"%"             { return MOD; }

"="             { return ASSIGN; }
";"             { return SEMICOLON; }
","             { return COMMA; }
":"             { return COLON; }
"("             { return LPAREN; }
")"             { return RPAREN; }
"{"             { return LBRACE; }
"}"             { return RBRACE; }

{LETTER}({LETTER}|{DIGIT})* { yylval.identifier = strdup(yytext); return IDENTIFIER; }

{WHITESPACE}+   /* ignore whitespace */
.               { printf("Invalid token: %s\n", yytext); }

%%

int yywrap(void) {
    return 1;
}
