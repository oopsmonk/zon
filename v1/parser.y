%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include "scanner.h"

/* Declare any additional functions and global variables here */

/* fixed: implicit declaration of function ‘yyerror’; did you mean ‘yyerrok’? [-Wimplicit-function-declaration] */
void yyerror (const char *msg)
{
    fprintf (stderr, "%s\n", msg);
}


%}

%union {
    int integer;
    float real;
    char* string;
    int boolean;
    char* identifier; /* Add this line */
}

%token EQ NEQ LT GT LTE GTE PLUS MINUS MUL 
%token DIV MOD ASSIGN SEMICOLON COMMA COLON LPAREN RPAREN LBRACE RBRACE

/* Declare tokens here */
%token INT_TYPE FLOAT_TYPE STRING_TYPE BOOL_TYPE TRUE FALSE VAR FN RETURN FOR IN IF ELSE
%token IDENTIFIER  /* Add this line */

/* FIX: error: symbol ‘INT_CONSTANT’ is used, but is not defined as a token and has no rules */
%token INT_CONSTANT FLOAT_CONSTANT STRING_CONSTANT BOOL_CONSTANT

%%

/* Define grammar rules here */

program:
    statement_list
    ;

statement_list:
    statement
    | statement_list statement
    ;

statement:
    variable_declaration
    | assignment_statement
    | function_call_statement
    | control_flow_statement
    | return_statement
    | expression_statement
    ;

variable_declaration:
    VAR identifier ':' data_type '=' expression ';'
    ;

assignment_statement:
    identifier '=' expression ';'
    ;

function_call_statement:
    identifier '(' arg_list ')' ';'
    ;

control_flow_statement:
    if_statement
    | for_statement
    ;

if_statement:
    IF '(' expression ')' '{' statement_list '}' ELSE '{' statement_list '}'
    ;

for_statement:
    FOR '(' variable_declaration ';' expression ';' expression ')' '{' statement_list '}'
    ;

return_statement:
    RETURN expression ';'
    ;

expression_statement:
    expression ';'
    ;

arg_list:
    /* empty */
    | expression
    | arg_list ',' expression
    ;

expression:
    '(' expression ')'
    | expression '+' expression
    | expression '-' expression
    | expression '*' expression
    | expression '/' expression
    | expression '%' expression
    | identifier
    | constant
    ;

data_type:
    INT_TYPE
    | FLOAT_TYPE
    | STRING_TYPE
    | BOOL_TYPE
    ;

identifier:
    IDENTIFIER   /* Add this line */
    ;

constant:
    INT_CONSTANT
    | FLOAT_CONSTANT
    | STRING_CONSTANT
    | BOOL_CONSTANT
    ;

%%

/* Define any additional functions and global variables here */

/* Define the main function for testing */

int main(int argc, char *argv[]) {
    /* Declare any necessary variables and data structures here */

    yyparse();

    /* Clean up any dynamically allocated memory and exit */

    return 0;
}
