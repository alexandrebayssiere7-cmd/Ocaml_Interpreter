
module MenhirBasics = struct
  
  exception Error
  
  let _eRR =
    fun _s ->
      raise Error
  
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
    | INT of (
# 8 "kawaparser.mly"
       (int)
# 38 "kawaparser.ml"
  )
    | IF
    | IDENT of (
# 9 "kawaparser.mly"
       (string)
# 44 "kawaparser.ml"
  )
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
    | BOOL of (
# 10 "kawaparser.mly"
       (bool)
# 61 "kawaparser.ml"
  )
    | BEQ
    | BEGIN
    | ATTRIBUTE
    | AND
  
end

include MenhirBasics

# 1 "kawaparser.mly"
  

  open Lexing
  open Kawa


# 79 "kawaparser.ml"

type ('s, 'r) _menhir_state = 
  | MenhirState02 : ('s, _menhir_box_program) _menhir_state
    (** State 02.
        Stack shape : .
        Start symbol: program. *)

  | MenhirState04 : (('s, _menhir_box_program) _menhir_cell1_WHILE, _menhir_box_program) _menhir_state
    (** State 04.
        Stack shape : WHILE.
        Start symbol: program. *)

  | MenhirState37 : ((('s, _menhir_box_program) _menhir_cell1_WHILE, _menhir_box_program) _menhir_cell1_expr, _menhir_box_program) _menhir_state
    (** State 37.
        Stack shape : WHILE expr.
        Start symbol: program. *)

  | MenhirState38 : (('s, _menhir_box_program) _menhir_cell1_RETURN, _menhir_box_program) _menhir_state
    (** State 38.
        Stack shape : RETURN.
        Start symbol: program. *)

  | MenhirState41 : (('s, _menhir_box_program) _menhir_cell1_expr, _menhir_box_program) _menhir_state
    (** State 41.
        Stack shape : expr.
        Start symbol: program. *)

  | MenhirState44 : (('s, _menhir_box_program) _menhir_cell1_PRINT, _menhir_box_program) _menhir_state
    (** State 44.
        Stack shape : PRINT.
        Start symbol: program. *)

  | MenhirState49 : (('s, _menhir_box_program) _menhir_cell1_IF, _menhir_box_program) _menhir_state
    (** State 49.
        Stack shape : IF.
        Start symbol: program. *)

  | MenhirState52 : ((('s, _menhir_box_program) _menhir_cell1_IF, _menhir_box_program) _menhir_cell1_expr, _menhir_box_program) _menhir_state
    (** State 52.
        Stack shape : IF expr.
        Start symbol: program. *)

  | MenhirState57 : (((('s, _menhir_box_program) _menhir_cell1_IF, _menhir_box_program) _menhir_cell1_expr, _menhir_box_program) _menhir_cell1_seq, _menhir_box_program) _menhir_state
    (** State 57.
        Stack shape : IF expr seq.
        Start symbol: program. *)

  | MenhirState61 : (('s, _menhir_box_program) _menhir_cell1_mem_access, _menhir_box_program) _menhir_state
    (** State 61.
        Stack shape : mem_access.
        Start symbol: program. *)

  | MenhirState65 : (('s, _menhir_box_program) _menhir_cell1_instr, _menhir_box_program) _menhir_state
    (** State 65.
        Stack shape : instr.
        Start symbol: program. *)


and ('s, 'r) _menhir_cell1_expr = 
  | MenhirCell1_expr of 's * ('s, 'r) _menhir_state * (Kawa.expr)

and ('s, 'r) _menhir_cell1_instr = 
  | MenhirCell1_instr of 's * ('s, 'r) _menhir_state * (Kawa.instr)

and ('s, 'r) _menhir_cell1_mem_access = 
  | MenhirCell1_mem_access of 's * ('s, 'r) _menhir_state * (Kawa.mem_access)

and ('s, 'r) _menhir_cell1_seq = 
  | MenhirCell1_seq of 's * ('s, 'r) _menhir_state * (Kawa.seq)

and ('s, 'r) _menhir_cell1_IF = 
  | MenhirCell1_IF of 's * ('s, 'r) _menhir_state

and ('s, 'r) _menhir_cell1_PRINT = 
  | MenhirCell1_PRINT of 's * ('s, 'r) _menhir_state

and ('s, 'r) _menhir_cell1_RETURN = 
  | MenhirCell1_RETURN of 's * ('s, 'r) _menhir_state

and ('s, 'r) _menhir_cell1_WHILE = 
  | MenhirCell1_WHILE of 's * ('s, 'r) _menhir_state

and _menhir_box_program = 
  | MenhirBox_program of (Kawa.program) [@@unboxed]

let _menhir_action_01 =
  fun n ->
    (
# 39 "kawaparser.mly"
       ( Int(n) )
# 170 "kawaparser.ml"
     : (Kawa.expr))

let _menhir_action_02 =
  fun b ->
    (
# 40 "kawaparser.mly"
        (Bool(b))
# 178 "kawaparser.ml"
     : (Kawa.expr))

let _menhir_action_03 =
  fun n ->
    (
# 41 "kawaparser.mly"
              (Unop(Opp,Int(n)))
# 186 "kawaparser.ml"
     : (Kawa.expr))

let _menhir_action_04 =
  fun n ->
    (
# 42 "kawaparser.mly"
             (Unop(Not,Bool(n)))
# 194 "kawaparser.ml"
     : (Kawa.expr))

let _menhir_action_05 =
  fun n1 n2 ->
    (
# 43 "kawaparser.mly"
                    (Binop(Add,Int(n1),Int(n2)))
# 202 "kawaparser.ml"
     : (Kawa.expr))

let _menhir_action_06 =
  fun n1 n2 ->
    (
# 44 "kawaparser.mly"
                    (Binop(Mul,Int(n1),Int(n2)))
# 210 "kawaparser.ml"
     : (Kawa.expr))

let _menhir_action_07 =
  fun n1 n2 ->
    (
# 45 "kawaparser.mly"
                     (Binop(Sub,Int(n1),Int(n2)))
# 218 "kawaparser.ml"
     : (Kawa.expr))

let _menhir_action_08 =
  fun n1 n2 ->
    (
# 46 "kawaparser.mly"
                   (Binop(Div,Int(n1),Int(n2)))
# 226 "kawaparser.ml"
     : (Kawa.expr))

let _menhir_action_09 =
  fun n1 n2 ->
    (
# 47 "kawaparser.mly"
                     (Binop(Eq,n1,n2))
# 234 "kawaparser.ml"
     : (Kawa.expr))

let _menhir_action_10 =
  fun n1 n2 ->
    (
# 48 "kawaparser.mly"
                     (Binop(And,Bool(n1),Bool(n2)))
# 242 "kawaparser.ml"
     : (Kawa.expr))

let _menhir_action_11 =
  fun n1 n2 ->
    (
# 49 "kawaparser.mly"
                       (Binop(Or,Bool(n1),Bool(n2)))
# 250 "kawaparser.ml"
     : (Kawa.expr))

let _menhir_action_12 =
  fun n1 n2 ->
    (
# 50 "kawaparser.mly"
                   (Binop(Lt,Int(n1),Int(n2)))
# 258 "kawaparser.ml"
     : (Kawa.expr))

let _menhir_action_13 =
  fun n1 n2 ->
    (
# 51 "kawaparser.mly"
                    (Binop(Le,Int(n1), Int(n2)))
# 266 "kawaparser.ml"
     : (Kawa.expr))

let _menhir_action_14 =
  fun n1 n2 ->
    (
# 52 "kawaparser.mly"
                    (Binop(Gt,Int(n1), Int(n2)))
# 274 "kawaparser.ml"
     : (Kawa.expr))

let _menhir_action_15 =
  fun n1 n2 ->
    (
# 53 "kawaparser.mly"
                    (Binop(Ge,Int(n1), Int(n2)))
# 282 "kawaparser.ml"
     : (Kawa.expr))

let _menhir_action_16 =
  fun n1 n2 ->
    (
# 54 "kawaparser.mly"
                     (Binop(Neq,Int(n1), Int(n2)))
# 290 "kawaparser.ml"
     : (Kawa.expr))

let _menhir_action_17 =
  fun n1 n2 ->
    (
# 55 "kawaparser.mly"
                   (Binop(Rem,Int(n1),Int(n2)))
# 298 "kawaparser.ml"
     : (Kawa.expr))

let _menhir_action_18 =
  fun e ->
    (
# 63 "kawaparser.mly"
                              ( Print(e) )
# 306 "kawaparser.ml"
     : (Kawa.instr))

let _menhir_action_19 =
  fun e m ->
    (
# 64 "kawaparser.mly"
                              (Set(m,e))
# 314 "kawaparser.ml"
     : (Kawa.instr))

let _menhir_action_20 =
  fun c s1 s2 ->
    (
# 65 "kawaparser.mly"
                                                              ( If(c, s1, s2) )
# 322 "kawaparser.ml"
     : (Kawa.instr))

let _menhir_action_21 =
  fun c s ->
    (
# 66 "kawaparser.mly"
                                         (While(c,s))
# 330 "kawaparser.ml"
     : (Kawa.instr))

let _menhir_action_22 =
  fun e ->
    (
# 67 "kawaparser.mly"
                     (Return(e))
# 338 "kawaparser.ml"
     : (Kawa.instr))

let _menhir_action_23 =
  fun e ->
    (
# 68 "kawaparser.mly"
              (Expr(e))
# 346 "kawaparser.ml"
     : (Kawa.instr))

let _menhir_action_24 =
  fun () ->
    (
# 208 "<standard.mly>"
    ( [] )
# 354 "kawaparser.ml"
     : (Kawa.seq))

let _menhir_action_25 =
  fun x xs ->
    (
# 210 "<standard.mly>"
    ( x :: xs )
# 362 "kawaparser.ml"
     : (Kawa.seq))

let _menhir_action_26 =
  fun i ->
    (
# 59 "kawaparser.mly"
         (Var(i))
# 370 "kawaparser.ml"
     : (Kawa.mem_access))

let _menhir_action_27 =
  fun e i ->
    (
# 60 "kawaparser.mly"
                      (Field(e,i))
# 378 "kawaparser.ml"
     : (Kawa.mem_access))

let _menhir_action_28 =
  fun main ->
    (
# 94 "kawaparser.mly"
    (  {classes=[]; globals=[]; main} )
# 386 "kawaparser.ml"
     : (Kawa.program))

let _menhir_action_29 =
  fun s ->
    (
# 71 "kawaparser.mly"
               ((s))
# 394 "kawaparser.ml"
     : (Kawa.seq))

let _menhir_print_token : token -> string =
  fun _tok ->
    match _tok with
    | AND ->
        "AND"
    | ATTRIBUTE ->
        "ATTRIBUTE"
    | BEGIN ->
        "BEGIN"
    | BEQ ->
        "BEQ"
    | BOOL _ ->
        "BOOL"
    | CLASS ->
        "CLASS"
    | COMMA ->
        "COMMA"
    | DIV ->
        "DIV"
    | ELSE ->
        "ELSE"
    | END ->
        "END"
    | EOF ->
        "EOF"
    | EQ ->
        "EQ"
    | EXCL ->
        "EXCL"
    | EXTENDS ->
        "EXTENDS"
    | FALSE ->
        "FALSE"
    | GE ->
        "GE"
    | GT ->
        "GT"
    | IDENT _ ->
        "IDENT"
    | IF ->
        "IF"
    | INT _ ->
        "INT"
    | LE ->
        "LE"
    | LPAR ->
        "LPAR"
    | LT ->
        "LT"
    | MAIN ->
        "MAIN"
    | METHOD ->
        "METHOD"
    | MINUS ->
        "MINUS"
    | N ->
        "N"
    | NEQ ->
        "NEQ"
    | NEW ->
        "NEW"
    | OR ->
        "OR"
    | PLUS ->
        "PLUS"
    | POINT ->
        "POINT"
    | PRINT ->
        "PRINT"
    | REM ->
        "REM"
    | RETURN ->
        "RETURN"
    | RPAR ->
        "RPAR"
    | SEMI ->
        "SEMI"
    | STAR ->
        "STAR"
    | THIS ->
        "THIS"
    | TRUE ->
        "TRUE"
    | VAR ->
        "VAR"
    | VOID ->
        "VOID"
    | WHILE ->
        "WHILE"

let _menhir_fail : unit -> 'a =
  fun () ->
    Printf.eprintf "Internal failure -- please contact the parser generator's developers.\n%!";
    assert false

include struct
  
  [@@@ocaml.warning "-4-37"]
  
  let _menhir_run_73 : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v ->
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | EOF ->
          let main = _v in
          let _v = _menhir_action_28 main in
          MenhirBox_program _v
      | _ ->
          _eRR ()
  
  let rec _menhir_run_03 : type  ttv_stack. ttv_stack -> _ -> _ -> (ttv_stack, _menhir_box_program) _menhir_state -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _menhir_stack = MenhirCell1_WHILE (_menhir_stack, _menhir_s) in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | LPAR ->
          let _menhir_s = MenhirState04 in
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | MINUS ->
              _menhir_run_05 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | INT _v ->
              _menhir_run_07 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | EXCL ->
              _menhir_run_28 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | BOOL _v ->
              _menhir_run_30 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | _ ->
              _eRR ())
      | _ ->
          _eRR ()
  
  and _menhir_run_05 : type  ttv_stack. ttv_stack -> _ -> _ -> (ttv_stack, _menhir_box_program) _menhir_state -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | INT _v ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          let n = _v in
          let _v = _menhir_action_03 n in
          _menhir_goto_expr _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | _ ->
          _eRR ()
  
  and _menhir_goto_expr : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_program) _menhir_state -> _ -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      match _menhir_s with
      | MenhirState02 ->
          _menhir_run_67 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState37 ->
          _menhir_run_67 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState52 ->
          _menhir_run_67 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState57 ->
          _menhir_run_67 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState65 ->
          _menhir_run_67 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState61 ->
          _menhir_run_62 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState49 ->
          _menhir_run_50 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState44 ->
          _menhir_run_45 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState41 ->
          _menhir_run_42 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState38 ->
          _menhir_run_39 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState04 ->
          _menhir_run_35 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  and _menhir_run_67 : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_program) _menhir_state -> _ -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      match (_tok : MenhirBasics.token) with
      | SEMI ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          let e = _v in
          let _v = _menhir_action_23 e in
          _menhir_goto_instr _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | POINT ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | IDENT _v_0 ->
              let _tok = _menhir_lexer _menhir_lexbuf in
              let (i, e) = (_v_0, _v) in
              let _v = _menhir_action_27 e i in
              _menhir_goto_mem_access _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
          | _ ->
              _eRR ())
      | BEQ ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_41 _menhir_stack _menhir_lexbuf _menhir_lexer
      | _ ->
          _eRR ()
  
  and _menhir_goto_instr : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_program) _menhir_state -> _ -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      let _menhir_stack = MenhirCell1_instr (_menhir_stack, _menhir_s, _v) in
      match (_tok : MenhirBasics.token) with
      | WHILE ->
          _menhir_run_03 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState65
      | RETURN ->
          _menhir_run_38 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState65
      | PRINT ->
          _menhir_run_43 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState65
      | MINUS ->
          _menhir_run_05 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState65
      | INT _v_0 ->
          _menhir_run_07 _menhir_stack _menhir_lexbuf _menhir_lexer _v_0 MenhirState65
      | IF ->
          _menhir_run_48 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState65
      | IDENT _v_1 ->
          _menhir_run_53 _menhir_stack _menhir_lexbuf _menhir_lexer _v_1 MenhirState65
      | EXCL ->
          _menhir_run_28 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState65
      | BOOL _v_2 ->
          _menhir_run_30 _menhir_stack _menhir_lexbuf _menhir_lexer _v_2 MenhirState65
      | END ->
          let _v_3 = _menhir_action_24 () in
          _menhir_run_66 _menhir_stack _menhir_lexbuf _menhir_lexer _v_3
      | _ ->
          _eRR ()
  
  and _menhir_run_38 : type  ttv_stack. ttv_stack -> _ -> _ -> (ttv_stack, _menhir_box_program) _menhir_state -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _menhir_stack = MenhirCell1_RETURN (_menhir_stack, _menhir_s) in
      let _menhir_s = MenhirState38 in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | MINUS ->
          _menhir_run_05 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | INT _v ->
          _menhir_run_07 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | EXCL ->
          _menhir_run_28 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | BOOL _v ->
          _menhir_run_30 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | _ ->
          _eRR ()
  
  and _menhir_run_07 : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_program) _menhir_state -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s ->
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | STAR ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | INT _v_0 ->
              let _tok = _menhir_lexer _menhir_lexbuf in
              let (n2, n1) = (_v_0, _v) in
              let _v = _menhir_action_06 n1 n2 in
              _menhir_goto_expr _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
          | _ ->
              _eRR ())
      | REM ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | INT _v_1 ->
              let _tok = _menhir_lexer _menhir_lexbuf in
              let (n2, n1) = (_v_1, _v) in
              let _v = _menhir_action_17 n1 n2 in
              _menhir_goto_expr _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
          | _ ->
              _eRR ())
      | PLUS ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | INT _v_2 ->
              let _tok = _menhir_lexer _menhir_lexbuf in
              let (n2, n1) = (_v_2, _v) in
              let _v = _menhir_action_05 n1 n2 in
              _menhir_goto_expr _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
          | _ ->
              _eRR ())
      | NEQ ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | INT _v_3 ->
              let _tok = _menhir_lexer _menhir_lexbuf in
              let (n2, n1) = (_v_3, _v) in
              let _v = _menhir_action_16 n1 n2 in
              _menhir_goto_expr _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
          | _ ->
              _eRR ())
      | MINUS ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | INT _v_4 ->
              let _tok = _menhir_lexer _menhir_lexbuf in
              let (n2, n1) = (_v_4, _v) in
              let _v = _menhir_action_07 n1 n2 in
              _menhir_goto_expr _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
          | _ ->
              _eRR ())
      | LT ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | INT _v_5 ->
              let _tok = _menhir_lexer _menhir_lexbuf in
              let (n2, n1) = (_v_5, _v) in
              let _v = _menhir_action_12 n1 n2 in
              _menhir_goto_expr _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
          | _ ->
              _eRR ())
      | LE ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | INT _v_6 ->
              let _tok = _menhir_lexer _menhir_lexbuf in
              let (n2, n1) = (_v_6, _v) in
              let _v = _menhir_action_13 n1 n2 in
              _menhir_goto_expr _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
          | _ ->
              _eRR ())
      | GT ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | INT _v_7 ->
              let _tok = _menhir_lexer _menhir_lexbuf in
              let (n2, n1) = (_v_7, _v) in
              let _v = _menhir_action_14 n1 n2 in
              _menhir_goto_expr _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
          | _ ->
              _eRR ())
      | GE ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | INT _v_8 ->
              let _tok = _menhir_lexer _menhir_lexbuf in
              let (n2, n1) = (_v_8, _v) in
              let _v = _menhir_action_15 n1 n2 in
              _menhir_goto_expr _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
          | _ ->
              _eRR ())
      | DIV ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | INT _v_9 ->
              let _tok = _menhir_lexer _menhir_lexbuf in
              let (n2, n1) = (_v_9, _v) in
              let _v = _menhir_action_08 n1 n2 in
              _menhir_goto_expr _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
          | _ ->
              _eRR ())
      | BEQ | POINT | RPAR | SEMI ->
          let n = _v in
          let _v = _menhir_action_01 n in
          _menhir_goto_expr _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | _ ->
          _eRR ()
  
  and _menhir_run_28 : type  ttv_stack. ttv_stack -> _ -> _ -> (ttv_stack, _menhir_box_program) _menhir_state -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | BOOL _v ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          let n = _v in
          let _v = _menhir_action_04 n in
          _menhir_goto_expr _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | _ ->
          _eRR ()
  
  and _menhir_run_30 : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_program) _menhir_state -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s ->
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | OR ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | BOOL _v_0 ->
              let _tok = _menhir_lexer _menhir_lexbuf in
              let (n2, n1) = (_v_0, _v) in
              let _v = _menhir_action_11 n1 n2 in
              _menhir_goto_expr _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
          | _ ->
              _eRR ())
      | AND ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | BOOL _v_1 ->
              let _tok = _menhir_lexer _menhir_lexbuf in
              let (n2, n1) = (_v_1, _v) in
              let _v = _menhir_action_10 n1 n2 in
              _menhir_goto_expr _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
          | _ ->
              _eRR ())
      | BEQ | POINT | RPAR | SEMI ->
          let b = _v in
          let _v = _menhir_action_02 b in
          _menhir_goto_expr _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | _ ->
          _eRR ()
  
  and _menhir_run_43 : type  ttv_stack. ttv_stack -> _ -> _ -> (ttv_stack, _menhir_box_program) _menhir_state -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _menhir_stack = MenhirCell1_PRINT (_menhir_stack, _menhir_s) in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | LPAR ->
          let _menhir_s = MenhirState44 in
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | MINUS ->
              _menhir_run_05 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | INT _v ->
              _menhir_run_07 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | EXCL ->
              _menhir_run_28 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | BOOL _v ->
              _menhir_run_30 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | _ ->
              _eRR ())
      | _ ->
          _eRR ()
  
  and _menhir_run_48 : type  ttv_stack. ttv_stack -> _ -> _ -> (ttv_stack, _menhir_box_program) _menhir_state -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _menhir_stack = MenhirCell1_IF (_menhir_stack, _menhir_s) in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | LPAR ->
          let _menhir_s = MenhirState49 in
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | MINUS ->
              _menhir_run_05 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | INT _v ->
              _menhir_run_07 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | EXCL ->
              _menhir_run_28 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | BOOL _v ->
              _menhir_run_30 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | _ ->
              _eRR ())
      | _ ->
          _eRR ()
  
  and _menhir_run_53 : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_program) _menhir_state -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s ->
      let _tok = _menhir_lexer _menhir_lexbuf in
      let i = _v in
      let _v = _menhir_action_26 i in
      _menhir_goto_mem_access _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  and _menhir_goto_mem_access : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_program) _menhir_state -> _ -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      let _menhir_stack = MenhirCell1_mem_access (_menhir_stack, _menhir_s, _v) in
      match (_tok : MenhirBasics.token) with
      | EQ ->
          let _menhir_s = MenhirState61 in
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | MINUS ->
              _menhir_run_05 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | INT _v ->
              _menhir_run_07 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | EXCL ->
              _menhir_run_28 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | BOOL _v ->
              _menhir_run_30 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | _ ->
              _eRR ())
      | _ ->
          _eRR ()
  
  and _menhir_run_66 : type  ttv_stack. (ttv_stack, _menhir_box_program) _menhir_cell1_instr -> _ -> _ -> _ -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v ->
      let MenhirCell1_instr (_menhir_stack, _menhir_s, x) = _menhir_stack in
      let xs = _v in
      let _v = _menhir_action_25 x xs in
      _menhir_goto_list_instr_ _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
  
  and _menhir_goto_list_instr_ : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_program) _menhir_state -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s ->
      match _menhir_s with
      | MenhirState65 ->
          _menhir_run_66 _menhir_stack _menhir_lexbuf _menhir_lexer _v
      | MenhirState02 ->
          _menhir_run_64 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | MenhirState37 ->
          _menhir_run_64 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | MenhirState52 ->
          _menhir_run_64 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | MenhirState57 ->
          _menhir_run_64 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | _ ->
          _menhir_fail ()
  
  and _menhir_run_64 : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_program) _menhir_state -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s ->
      let s = _v in
      let _v = _menhir_action_29 s in
      _menhir_goto_seq _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
  
  and _menhir_goto_seq : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_program) _menhir_state -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s ->
      match _menhir_s with
      | MenhirState02 ->
          _menhir_run_73 _menhir_stack _menhir_lexbuf _menhir_lexer _v
      | MenhirState37 ->
          _menhir_run_71 _menhir_stack _menhir_lexbuf _menhir_lexer _v
      | MenhirState57 ->
          _menhir_run_58 _menhir_stack _menhir_lexbuf _menhir_lexer _v
      | MenhirState52 ->
          _menhir_run_54 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | _ ->
          _menhir_fail ()
  
  and _menhir_run_71 : type  ttv_stack. ((ttv_stack, _menhir_box_program) _menhir_cell1_WHILE, _menhir_box_program) _menhir_cell1_expr -> _ -> _ -> _ -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v ->
      let _tok = _menhir_lexer _menhir_lexbuf in
      let MenhirCell1_expr (_menhir_stack, _, c) = _menhir_stack in
      let MenhirCell1_WHILE (_menhir_stack, _menhir_s) = _menhir_stack in
      let s = _v in
      let _v = _menhir_action_21 c s in
      _menhir_goto_instr _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  and _menhir_run_58 : type  ttv_stack. (((ttv_stack, _menhir_box_program) _menhir_cell1_IF, _menhir_box_program) _menhir_cell1_expr, _menhir_box_program) _menhir_cell1_seq -> _ -> _ -> _ -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v ->
      let _tok = _menhir_lexer _menhir_lexbuf in
      let MenhirCell1_seq (_menhir_stack, _, s1) = _menhir_stack in
      let MenhirCell1_expr (_menhir_stack, _, c) = _menhir_stack in
      let MenhirCell1_IF (_menhir_stack, _menhir_s) = _menhir_stack in
      let s2 = _v in
      let _v = _menhir_action_20 c s1 s2 in
      _menhir_goto_instr _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  and _menhir_run_54 : type  ttv_stack. (((ttv_stack, _menhir_box_program) _menhir_cell1_IF, _menhir_box_program) _menhir_cell1_expr as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_program) _menhir_state -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s ->
      let _menhir_stack = MenhirCell1_seq (_menhir_stack, _menhir_s, _v) in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | ELSE ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | BEGIN ->
              let _tok = _menhir_lexer _menhir_lexbuf in
              (match (_tok : MenhirBasics.token) with
              | WHILE ->
                  _menhir_run_03 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState57
              | RETURN ->
                  _menhir_run_38 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState57
              | PRINT ->
                  _menhir_run_43 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState57
              | MINUS ->
                  _menhir_run_05 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState57
              | INT _v_0 ->
                  _menhir_run_07 _menhir_stack _menhir_lexbuf _menhir_lexer _v_0 MenhirState57
              | IF ->
                  _menhir_run_48 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState57
              | IDENT _v_1 ->
                  _menhir_run_53 _menhir_stack _menhir_lexbuf _menhir_lexer _v_1 MenhirState57
              | EXCL ->
                  _menhir_run_28 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState57
              | BOOL _v_2 ->
                  _menhir_run_30 _menhir_stack _menhir_lexbuf _menhir_lexer _v_2 MenhirState57
              | END ->
                  let _v_3 = _menhir_action_24 () in
                  _menhir_run_64 _menhir_stack _menhir_lexbuf _menhir_lexer _v_3 MenhirState57
              | _ ->
                  _eRR ())
          | _ ->
              _eRR ())
      | _ ->
          _eRR ()
  
  and _menhir_run_41 : type  ttv_stack. (ttv_stack, _menhir_box_program) _menhir_cell1_expr -> _ -> _ -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer ->
      let _menhir_s = MenhirState41 in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | MINUS ->
          _menhir_run_05 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | INT _v ->
          _menhir_run_07 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | EXCL ->
          _menhir_run_28 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | BOOL _v ->
          _menhir_run_30 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | _ ->
          _eRR ()
  
  and _menhir_run_62 : type  ttv_stack. ((ttv_stack, _menhir_box_program) _menhir_cell1_mem_access as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_program) _menhir_state -> _ -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      match (_tok : MenhirBasics.token) with
      | SEMI ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          let MenhirCell1_mem_access (_menhir_stack, _menhir_s, m) = _menhir_stack in
          let e = _v in
          let _v = _menhir_action_19 e m in
          _menhir_goto_instr _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | BEQ ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_41 _menhir_stack _menhir_lexbuf _menhir_lexer
      | _ ->
          _eRR ()
  
  and _menhir_run_50 : type  ttv_stack. ((ttv_stack, _menhir_box_program) _menhir_cell1_IF as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_program) _menhir_state -> _ -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
      match (_tok : MenhirBasics.token) with
      | RPAR ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | BEGIN ->
              let _tok = _menhir_lexer _menhir_lexbuf in
              (match (_tok : MenhirBasics.token) with
              | WHILE ->
                  _menhir_run_03 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState52
              | RETURN ->
                  _menhir_run_38 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState52
              | PRINT ->
                  _menhir_run_43 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState52
              | MINUS ->
                  _menhir_run_05 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState52
              | INT _v_0 ->
                  _menhir_run_07 _menhir_stack _menhir_lexbuf _menhir_lexer _v_0 MenhirState52
              | IF ->
                  _menhir_run_48 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState52
              | IDENT _v_1 ->
                  _menhir_run_53 _menhir_stack _menhir_lexbuf _menhir_lexer _v_1 MenhirState52
              | EXCL ->
                  _menhir_run_28 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState52
              | BOOL _v_2 ->
                  _menhir_run_30 _menhir_stack _menhir_lexbuf _menhir_lexer _v_2 MenhirState52
              | END ->
                  let _v_3 = _menhir_action_24 () in
                  _menhir_run_64 _menhir_stack _menhir_lexbuf _menhir_lexer _v_3 MenhirState52
              | _ ->
                  _eRR ())
          | _ ->
              _eRR ())
      | BEQ ->
          _menhir_run_41 _menhir_stack _menhir_lexbuf _menhir_lexer
      | _ ->
          _eRR ()
  
  and _menhir_run_45 : type  ttv_stack. ((ttv_stack, _menhir_box_program) _menhir_cell1_PRINT as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_program) _menhir_state -> _ -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      match (_tok : MenhirBasics.token) with
      | RPAR ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | SEMI ->
              let _tok = _menhir_lexer _menhir_lexbuf in
              let MenhirCell1_PRINT (_menhir_stack, _menhir_s) = _menhir_stack in
              let e = _v in
              let _v = _menhir_action_18 e in
              _menhir_goto_instr _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
          | _ ->
              _eRR ())
      | BEQ ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_41 _menhir_stack _menhir_lexbuf _menhir_lexer
      | _ ->
          _eRR ()
  
  and _menhir_run_42 : type  ttv_stack. ((ttv_stack, _menhir_box_program) _menhir_cell1_expr as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_program) _menhir_state -> _ -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      match (_tok : MenhirBasics.token) with
      | BEQ ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_41 _menhir_stack _menhir_lexbuf _menhir_lexer
      | POINT | RPAR | SEMI ->
          let MenhirCell1_expr (_menhir_stack, _menhir_s, n1) = _menhir_stack in
          let n2 = _v in
          let _v = _menhir_action_09 n1 n2 in
          _menhir_goto_expr _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | _ ->
          _eRR ()
  
  and _menhir_run_39 : type  ttv_stack. ((ttv_stack, _menhir_box_program) _menhir_cell1_RETURN as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_program) _menhir_state -> _ -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      match (_tok : MenhirBasics.token) with
      | SEMI ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          let MenhirCell1_RETURN (_menhir_stack, _menhir_s) = _menhir_stack in
          let e = _v in
          let _v = _menhir_action_22 e in
          _menhir_goto_instr _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | BEQ ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_41 _menhir_stack _menhir_lexbuf _menhir_lexer
      | _ ->
          _eRR ()
  
  and _menhir_run_35 : type  ttv_stack. ((ttv_stack, _menhir_box_program) _menhir_cell1_WHILE as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_program) _menhir_state -> _ -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
      match (_tok : MenhirBasics.token) with
      | RPAR ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | BEGIN ->
              let _tok = _menhir_lexer _menhir_lexbuf in
              (match (_tok : MenhirBasics.token) with
              | WHILE ->
                  _menhir_run_03 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState37
              | RETURN ->
                  _menhir_run_38 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState37
              | PRINT ->
                  _menhir_run_43 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState37
              | MINUS ->
                  _menhir_run_05 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState37
              | INT _v_0 ->
                  _menhir_run_07 _menhir_stack _menhir_lexbuf _menhir_lexer _v_0 MenhirState37
              | IF ->
                  _menhir_run_48 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState37
              | IDENT _v_1 ->
                  _menhir_run_53 _menhir_stack _menhir_lexbuf _menhir_lexer _v_1 MenhirState37
              | EXCL ->
                  _menhir_run_28 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState37
              | BOOL _v_2 ->
                  _menhir_run_30 _menhir_stack _menhir_lexbuf _menhir_lexer _v_2 MenhirState37
              | END ->
                  let _v_3 = _menhir_action_24 () in
                  _menhir_run_64 _menhir_stack _menhir_lexbuf _menhir_lexer _v_3 MenhirState37
              | _ ->
                  _eRR ())
          | _ ->
              _eRR ())
      | BEQ ->
          _menhir_run_41 _menhir_stack _menhir_lexbuf _menhir_lexer
      | _ ->
          _eRR ()
  
  let _menhir_run_00 : type  ttv_stack. ttv_stack -> _ -> _ -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer ->
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | MAIN ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | BEGIN ->
              let _tok = _menhir_lexer _menhir_lexbuf in
              (match (_tok : MenhirBasics.token) with
              | WHILE ->
                  _menhir_run_03 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState02
              | RETURN ->
                  _menhir_run_38 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState02
              | PRINT ->
                  _menhir_run_43 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState02
              | MINUS ->
                  _menhir_run_05 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState02
              | INT _v ->
                  _menhir_run_07 _menhir_stack _menhir_lexbuf _menhir_lexer _v MenhirState02
              | IF ->
                  _menhir_run_48 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState02
              | IDENT _v ->
                  _menhir_run_53 _menhir_stack _menhir_lexbuf _menhir_lexer _v MenhirState02
              | EXCL ->
                  _menhir_run_28 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState02
              | BOOL _v ->
                  _menhir_run_30 _menhir_stack _menhir_lexbuf _menhir_lexer _v MenhirState02
              | END ->
                  let _v = _menhir_action_24 () in
                  _menhir_run_64 _menhir_stack _menhir_lexbuf _menhir_lexer _v MenhirState02
              | _ ->
                  _eRR ())
          | _ ->
              _eRR ())
      | _ ->
          _eRR ()
  
end

let program =
  fun _menhir_lexer _menhir_lexbuf ->
    let _menhir_stack = () in
    let MenhirBox_program v = _menhir_run_00 _menhir_stack _menhir_lexbuf _menhir_lexer in
    v
