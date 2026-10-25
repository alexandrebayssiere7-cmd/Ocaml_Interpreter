%{

  open Kawa

%}

%token <int> INT
%token <string> IDENT
%token MAIN
%token LPAR RPAR BEGIN END SEMI
%token PRINT
%token EOF
%token TRUE FALSE
%token VAR
%token ATTRIBUTE METHOD
%token CLASS NEW THIS EXTENDS
%token IF ELSE WHILE
%token RETURN VOID TINT TBOOL
%token PLUS STAR MINUS EQ DIV BEQ NEQ LT LE GT GE REM
%token AND OR POINT COMMA EXCL

%left OR
%left AND
%nonassoc BEQ NEQ
%nonassoc LT LE GT GE
%left PLUS MINUS
%left STAR DIV REM
%nonassoc UMINUS EXCL
%left POINT

%start program
%type <Kawa.program> program
%%

program:
| globals=list(var_decl) classes=list(class_def) MAIN BEGIN main=seq END EOF
    { {classes; globals; main} }
;

typ:
| TINT     { TInt }
| TBOOL    { TBool }
| VOID     { TVoid }
| c=IDENT  { TClass c }
;

var_decl:
| VAR t=typ x=IDENT SEMI { (x, t) }
;

attribute_decl:
| ATTRIBUTE t=typ x=IDENT SEMI { (x, t) }
;

param:
| t=typ x=IDENT { (x, t) }
;

method_def:
| METHOD return=typ method_name=IDENT
  LPAR params=separated_list(COMMA, param) RPAR
  BEGIN locals=list(var_decl) code=seq END
    { {method_name; code; params; locals; return} }
;

class_def:
| CLASS class_name=IDENT parent=option(preceded(EXTENDS, IDENT))
  BEGIN attributes=list(attribute_decl) methods=list(method_def) END
    { {class_name; attributes; methods; parent} }
;

seq:
| s=list(instr) { s }
;

instr:
| PRINT LPAR e=expr RPAR SEMI                                  { Print e }
| m=mem_access EQ e=expr SEMI                                  { Set(m, e) }
| IF LPAR c=expr RPAR BEGIN s=seq END                          { If(c, s, []) }
| IF LPAR c=expr RPAR BEGIN s1=seq END ELSE BEGIN s2=seq END   { If(c, s1, s2) }
| WHILE LPAR c=expr RPAR BEGIN s=seq END                       { While(c, s) }
| RETURN e=expr SEMI                                           { Return e }
| e=expr SEMI                                                  { Expr e }
;

mem_access:
| x=IDENT                 { Var x }
| e=expr POINT x=IDENT    { Field(e, x) }
;

expr:
| n=INT                    { Int n }
| TRUE                     { Bool true }
| FALSE                    { Bool false }
| THIS                     { This }
| m=mem_access             { Get m }
| LPAR e=expr RPAR         { e }
| NEW c=IDENT              { New c }
| NEW c=IDENT LPAR args=separated_list(COMMA, expr) RPAR       { NewCstr(c, args) }
| e=expr POINT m=IDENT LPAR args=separated_list(COMMA, expr) RPAR { MethCall(e, m, args) }
| MINUS e=expr %prec UMINUS { Unop(Opp, e) }
| EXCL e=expr               { Unop(Not, e) }
| e1=expr op=binop e2=expr  { Binop(op, e1, e2) }
;

%inline binop:
| PLUS  { Add }
| MINUS { Sub }
| STAR  { Mul }
| DIV   { Div }
| REM   { Rem }
| LT    { Lt }
| LE    { Le }
| GT    { Gt }
| GE    { Ge }
| BEQ   { Eq }
| NEQ   { Neq }
| AND   { And }
| OR    { Or }
;
