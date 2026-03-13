
(* The type of tokens. *)

type token = 
  | WHILE
  | VOID
  | VAR
  | TRUE
  | THIS
  | STAR
  | SEMI
  | RPAR
  | RETURN
  | REM
  | PRINT
  | POINT
  | PLUS
  | OR
  | NEW
  | NEQ
  | N
  | MINUS
  | METHOD
  | MAIN
  | LT
  | LPAR
  | LE
  | INT of (int)
  | IF
  | IDENT of (string)
  | GT
  | GE
  | FALSE
  | EXTENDS
  | EXCL
  | EQ
  | EOF
  | END
  | ELSE
  | DIV
  | COMMA
  | CLASS
  | BOOL of (bool)
  | BEQ
  | BEGIN
  | ATTRIBUTE
  | AND

(* This exception is raised by the monolithic API functions. *)

exception Error

(* The monolithic API. *)

val program: (Lexing.lexbuf -> token) -> Lexing.lexbuf -> (Kawa.program)
