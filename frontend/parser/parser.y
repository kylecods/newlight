%token PRINT FOR WHILE RETURN FUNC VAR ELSE IF TRUE FALSE IDENTIFIER DIGIT STRING
%token EQ_EQ MI_MI PLUS_PLUS OR AND NOT_EQ LE_EQ GR_EQ PLUS_EQ MI_EQ DIV_EQ MUL_EQ
%left ','
%right "?" ":" "=" "+=" "-=" "*=" "/=" 
%left   "||"
%left   "&&"
%left   "&" 
%left   "|" 
%left "<" ">" "<=" ">="
%left  "+" "-"
%left "*" "/"
%right "++" "--"
%left  "(" "[" ")" "]"

%%
program : declaration

declaration :   declaration varDeclaration
|               functionDeclaration
;

functionDeclaration : FUNC IDENTIFIER '(' parameters ')' block
|               %empty
;

parameters :    parameter 
|               %empty
;

parameter : parameter ',' IDENTIFIER 
|           IDENTIFIER
;


varDeclaration :  VAR varDecl
|                 varDeclaration ',' varDecl 
;

varDecl     :    IDENTIFIER '=' expressionStatement   
|                IDENTIFIER 
;

block :  '{' statement '}'

statement : stmt 
|           %empty
;

stmt :  forStatement
|       ifStatement
|       whileStatement
|       expressionStatement
|       returnStatement
|       printStatement 
;

printStatement : PRINT '(' expression ')' ';'

ifStatement : IF '('  expression  ')' block;

expressionStatement : expression ';'
|                      expression
;

whileStatement : WHILE '(' expression ')' block;

forStatement   : FOR '(' forParams ')' block;

forParams :     varDeclaration ';' expression ';' expression
|               ';'
;

returnStatement : RETURN expression ';'
|                   RETURN ';'
;

c_expr : expression
|       c_expr ',' expression
;

e_expr : expression
|       e_expr ',' expression
|       %empty
;


expression : BOOL |  LIST | CALL | UNARY | BINARY | DIGIT | STRING
|           IDENTIFIER
|           '(' expression ')'           
;

BOOL : TRUE | FALSE ;

LIST: expression '[' c_expr ']' ;

CALL : expression '(' e_expr ')';

BINARY :  expression '+' expression
        | expression '-' expression %prec '+'
        | expression '*' expression
        | expression '/' expression
        | expression '&' expression
        | expression '|' expression
        | expression PLUS_EQ expression
        | expression MI_EQ expression
        | expression DIV_EQ expression
        | expression MUL_EQ expression
        | expression AND expression
        | expression OR expression
        | expression NOT_EQ expression
        | expression EQ_EQ expression
        | expression GR_EQ expression
        | expression LE_EQ expression
;

UNARY   : '!' expression
        | "--" expression  %prec "++" 
        | "++" expression  
        | '~' expression    
;

%%


