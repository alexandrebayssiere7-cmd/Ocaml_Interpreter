%{

  open Lexing
  open Kawa

%}

%token <int> INT
%token <string> IDENT
%token <bool> BOOL
%token N 
%token MAIN
%token LPAR RPAR BEGIN END SEMI
%token PRINT
%token EOF
%token TRUE FALSE  
%token VAR 
%token ATTRIBUTE METHOD 
%token CLASS NEW THIS
%token IF ELSE WHILE
%token RETURN VOID
%token PLUS STAR MINUS EQ DIV BEQ NEQ LT LE  GT GE  REM
%token AND OR POINT COMMA  EXCL
%token EXTENDS

%start program
%type <Kawa.program> program
%nonassoc DIV LT LE 
%left PLUS STAR MUL MINUS AND OR
%%

typ:
|INT {TInt}
|BOOL {TBool}
|id = IDENT {TCLASS(id)}
|VOID {Tvoid}
;
expr:
|n=INT { Int(n) }
|b=BOOL {Bool(b)}
|MINUS n=INT  {Unop(Opp,Int(n))}
|EXCL n=BOOL {Unop(Not,Bool(n))}
|n1=INT PLUS n2=INT {Binop(Add,Int(n1),Int(n2))}
|n1=INT STAR n2=INT {Binop(Mul,Int(n1),Int(n2))}
|n1=INT MINUS n2=INT {Binop(Sub,Int(n1),Int(n2))}
|n1=INT DIV n2=INT {Binop(Div,Int(n1),Int(n2))}
|n1=expr BEQ n2=expr {Binop(Eq,n1,n2)}
|n1=BOOL AND n2=BOOL {Binop(And,Bool(n1),Bool(n2))}
|n1=BOOL OR n2  = BOOL {Binop(Or,Bool(n1),Bool(n2))}
|n1=INT LT n2=INT  {Binop(Lt,Int(n1),Int(n2))}
|n1=INT LE n2 = INT {Binop(Le,Int(n1), Int(n2))}
|n1=INT GT n2 = INT {Binop(Gt,Int(n1), Int(n2))}
|n1=INT GE n2 = INT {Binop(Ge,Int(n1), Int(n2))}
|n1=INT NEQ n2 = INT {Binop(Neq,Int(n1), Int(n2))}
|n1=INT REM n2=INT {Binop(Rem,Int(n1),Int(n2))}

;
mem_access:
|i=IDENT {Var(i)}
|e=expr POINT i=IDENT {Field(e,i)}
;
instr:
| PRINT LPAR e=expr RPAR SEMI { Print(e) }
| m=mem_access EQ e=expr SEMI {Set(m,e)}
| IF LPAR c=expr RPAR BEGIN s1 =seq END ELSE BEGIN s2=seq END { If(c, s1, s2) }
| WHILE LPAR c=expr RPAR BEGIN s=seq END {While(c,s)}
| RETURN e=expr SEMI {Return(e)}
| e=expr SEMI {Expr(e)}
;
seq:
|s=list(instr) {(s)}
;
var_decl:
|VAR t=typ ident=IDENT SEMI {(ident,t)}
;
attribut_decl:
|ATTRIBUTE t=typ ident=IDENT SEMI {(ident,t)}
;
parametres:
|t=typ ident=IDENT {(ident,t)}
; 
method_def:
|METHOD t=typ ident=IDENT LPAR params=separated_list(COMMA,parametres) RPAR BEGIN local=list(var_decl)    main=seq
 END {{ident,main,params,local,t}}
;
extension:
|EXTENDS id = IDENT {STRING(id)}
;
class_def:
|CLASS ident=IDENT  parent=option(extension) BEGIN attribut=list(attribut_decl)  methode=list(method_def)  END {{ident,attribut,methode,parent}}
;
program:
| MAIN BEGIN main=seq END EOF
    {  {classes=[]; globals=[]; main} }
;