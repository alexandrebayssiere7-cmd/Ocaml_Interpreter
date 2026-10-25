open Lexing

(* Enchaîne analyse lexicale, analyse syntaxique, typage et exécution.
   Les erreurs attendues (programme invalide) sont renvoyées sous forme de
   message ; toute autre exception est une anomalie et remonte à l'appelant. *)
let run (lb: lexbuf): (unit, string) result =
  let position () =
    let b = lexeme_start_p lb and e = lexeme_end_p lb in
    Printf.sprintf "line %d, characters %d-%d" b.pos_lnum
      (b.pos_cnum - b.pos_bol + 1) (e.pos_cnum - b.pos_bol + 1)
  in
  try
    let prog = Kawaparser.program Kawalexer.token lb in
    Typechecker.typecheck_prog prog;
    Interpreter.exec_prog prog;
    Ok ()
  with
  | Kawalexer.Error s -> Error (Printf.sprintf "%s: lexical error: %s" (position ()) s)
  | Kawaparser.Error  -> Error (Printf.sprintf "%s: syntax error" (position ()))
  | Typechecker.Error s -> Error ("type error: " ^ s)
  | Interpreter.Error s -> Error ("interpreter error: " ^ s)
