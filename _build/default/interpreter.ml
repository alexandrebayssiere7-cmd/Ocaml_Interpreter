open Kawa

type value =
  | VInt  of int
  | VBool of bool
  | VObj  of obj
  | Null
and obj = {
  cls:    string;
  fields: (string, value) Hashtbl.t;
}

exception Error of string
exception Return of value

let error s = raise (Error s)

(* Les objets sont comparés par identité, comme en Java. *)
let equal v1 v2 = match v1, v2 with
  | VObj o1, VObj o2 -> o1 == o2
  | _ -> v1 = v2

let string_of_value = function
  | VInt n  -> string_of_int n
  | VBool b -> string_of_bool b
  | Null    -> "null"
  | VObj o  -> "Object of class : " ^ o.cls

let exec_prog (p: program): unit =
  let env = Hashtbl.create 16 in
  List.iter (fun (x, _) -> Hashtbl.replace env x Null) p.globals;

  let find_class c =
    match List.find_opt (fun x -> x.class_name = c) p.classes with
    | Some cl -> cl
    | None -> error (Printf.sprintf "class %s does not exist" c)
  in
  let rec add_fields c h =
    List.iter (fun (x, _) -> Hashtbl.replace h x Null) c.attributes;
    Option.iter (fun s -> add_fields (find_class s) h) c.parent
  in
  (* Méthodes de la classe avant celles du parent : une redéfinition masque
     la méthode héritée. *)
  let rec all_methods c =
    let cl = find_class c in
    match cl.parent with
    | None -> cl.methods
    | Some s -> cl.methods @ all_methods s
  in
  let find_method c m =
    match List.find_opt (fun x -> x.method_name = m) (all_methods c) with
    | Some f -> f
    | None -> error (Printf.sprintf "method %s not found in class %s" m c)
  in

  let rec eval_call f this args =
    if List.length args <> List.length f.params then
      error (Printf.sprintf "method %s expects %d arguments"
               f.method_name (List.length f.params));
    let lenv = Hashtbl.create 16 in
    List.iter2 (fun (x, _) v -> Hashtbl.replace lenv x v) f.params args;
    List.iter (fun (x, _) -> Hashtbl.replace lenv x Null) f.locals;
    Hashtbl.replace lenv "this" (VObj this);
    try exec_seq f.code lenv; Null
    with Return v -> v

  (* [lenv] contient les variables locales ; les globales restent dans [env],
     partagé par tous les appels. Dans le main, [lenv] est [env]. *)
  and exec_seq s lenv =
    let lookup x =
      match Hashtbl.find_opt lenv x with
      | Some v -> v
      | None ->
        match Hashtbl.find_opt env x with
        | Some v -> v
        | None -> error (Printf.sprintf "variable %s does not exist" x)
    in
    let assign x v =
      if Hashtbl.mem lenv x then Hashtbl.replace lenv x v
      else if Hashtbl.mem env x then Hashtbl.replace env x v
      else error (Printf.sprintf "variable %s does not exist" x)
    in

    let rec evali e = match eval e with
      | VInt n -> n
      | v -> error ("expected an integer, got " ^ string_of_value v)
    and evalb e = match eval e with
      | VBool b -> b
      | v -> error ("expected a boolean, got " ^ string_of_value v)
    and evalo e = match eval e with
      | VObj o -> o
      | Null -> error "null pointer access"
      | v -> error ("expected an object, got " ^ string_of_value v)

    and eval (e: expr): value = match e with
      | Int n  -> VInt n
      | Bool b -> VBool b
      | Binop(Add, e1, e2) -> VInt (evali e1 + evali e2)
      | Binop(Sub, e1, e2) -> VInt (evali e1 - evali e2)
      | Binop(Mul, e1, e2) -> VInt (evali e1 * evali e2)
      | Binop((Div | Rem) as op, e1, e2) ->
        let n1 = evali e1 in
        let n2 = evali e2 in
        if n2 = 0 then error "division by zero";
        VInt (if op = Div then n1 / n2 else n1 mod n2)
      | Binop(Eq, e1, e2)  -> VBool (equal (eval e1) (eval e2))
      | Binop(Neq, e1, e2) -> VBool (not (equal (eval e1) (eval e2)))
      | Binop(Lt, e1, e2)  -> VBool (evali e1 < evali e2)
      | Binop(Le, e1, e2)  -> VBool (evali e1 <= evali e2)
      | Binop(Gt, e1, e2)  -> VBool (evali e1 > evali e2)
      | Binop(Ge, e1, e2)  -> VBool (evali e1 >= evali e2)
      | Binop(And, e1, e2) -> VBool (evalb e1 && evalb e2)
      | Binop(Or, e1, e2)  -> VBool (evalb e1 || evalb e2)
      | Unop(Not, e1) -> VBool (not (evalb e1))
      | Unop(Opp, e1) -> VInt (- (evali e1))
      | Get (Var x) -> lookup x
      | Get (Field (e1, x)) ->
        let o = evalo e1 in
        (match Hashtbl.find_opt o.fields x with
         | Some v -> v
         | None -> error (Printf.sprintf "attribute %s not found in class %s" x o.cls))
      | This ->
        (match Hashtbl.find_opt lenv "this" with
         | Some v -> v
         | None -> error "this used outside a method")
      | New c ->
        let h = Hashtbl.create 4 in
        add_fields (find_class c) h;
        VObj {cls = c; fields = h}
      | NewCstr(c, args) ->
        let o = evalo (New c) in
        ignore (eval_call (find_method c "constructor") o (List.map eval args));
        VObj o
      | MethCall(e1, m, args) ->
        let o = evalo e1 in
        eval_call (find_method o.cls m) o (List.map eval args)
    in

    let rec exec (i: instr): unit = match i with
      | Print e -> print_endline (string_of_value (eval e))
      | Set(Var x, e) -> assign x (eval e)
      | Set(Field (e1, x), e) ->
        let o = evalo e1 in
        Hashtbl.replace o.fields x (eval e)
      | If(e, s1, s2) -> List.iter exec (if evalb e then s1 else s2)
      | While(e, s) -> while evalb e do List.iter exec s done
      | Return e -> raise (Return (eval e))
      | Expr e -> ignore (eval e)
    in
    List.iter exec s
  in

  exec_seq p.main env
