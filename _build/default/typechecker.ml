open Kawa

exception Error of string
let error s = raise (Error s)
let type_error ty_actual ty_expected =
  error (Printf.sprintf "expected %s, got %s"
           (typ_to_string ty_expected) (typ_to_string ty_actual))

module Env = Map.Make(String)
type tenv = typ Env.t
let add_env l tenv =
  List.fold_left (fun env (x, t) -> Env.add x t env) tenv l

let typecheck_prog p =
  let find_class c =
    match List.find_opt (fun x -> x.class_name = c) p.classes with
    | Some cl -> cl
    | None -> error (Printf.sprintf "Class %s does not exist" c)
  in
  (* Ancêtres de [c], du parent direct jusqu'à la racine. *)
  let rec ancestors seen c =
    match (find_class c).parent with
    | None -> []
    | Some s ->
      if List.mem s seen then
        error (Printf.sprintf "Inheritance cycle through class %s" s);
      s :: ancestors (s :: seen) s
  in
  let subclass c1 c2 = c1 = c2 || List.mem c2 (ancestors [c1] c1) in
  let compatible t_actual t_expected =
    match t_actual, t_expected with
    | TClass c1, TClass c2 -> subclass c1 c2
    | _ -> t_actual = t_expected
  in
  (* Membres de la classe avant ceux du parent : une redéfinition masque
     le membre hérité. *)
  let rec all_attributes c =
    let cl = find_class c in
    match cl.parent with
    | None -> cl.attributes
    | Some s -> cl.attributes @ all_attributes s
  in
  let rec all_methods c =
    let cl = find_class c in
    match cl.parent with
    | None -> cl.methods
    | Some s -> cl.methods @ all_methods s
  in
  let find_method c m =
    match List.find_opt (fun x -> x.method_name = m) (all_methods c) with
    | Some f -> f
    | None -> error (Printf.sprintf "Method %s not found for class %s" m c)
  in
  let check_typ = function
    | TClass c -> ignore (find_class c)
    | TVoid | TInt | TBool -> ()
  in
  let check_decls l = List.iter (fun (_, t) -> check_typ t) l in

  let rec check e typ tenv =
    let typ_e = type_expr e tenv in
    if not (compatible typ_e typ) then type_error typ_e typ

  and type_expr e tenv = match e with
    | Int _  -> TInt
    | Bool _ -> TBool
    | Unop(Opp, e1) -> check e1 TInt tenv; TInt
    | Unop(Not, e1) -> check e1 TBool tenv; TBool
    | Binop((Add | Sub | Mul | Div | Rem), e1, e2) ->
      check e1 TInt tenv; check e2 TInt tenv; TInt
    | Binop((Lt | Le | Gt | Ge), e1, e2) ->
      check e1 TInt tenv; check e2 TInt tenv; TBool
    | Binop((And | Or), e1, e2) ->
      check e1 TBool tenv; check e2 TBool tenv; TBool
    | Binop((Eq | Neq), e1, e2) ->
      let t1 = type_expr e1 tenv in
      let t2 = type_expr e2 tenv in
      if not (compatible t1 t2 || compatible t2 t1) then type_error t2 t1;
      TBool
    | Get m -> type_mem_access m tenv
    | This ->
      (match Env.find_opt "this" tenv with
       | Some t -> t
       | None -> error "this used outside a method")
    | New c -> check_typ (TClass c); TClass c
    | NewCstr(c, args) ->
      check_args (find_method c "constructor") args tenv; TClass c
    | MethCall(e1, m, args) ->
      (match type_expr e1 tenv with
       | TClass c -> let f = find_method c m in check_args f args tenv; f.return
       | t -> error (Printf.sprintf "Method %s called on a value of type %s"
                       m (typ_to_string t)))

  and check_args f args tenv =
    if List.length args <> List.length f.params then
      error (Printf.sprintf "Method %s expects %d arguments, got %d"
               f.method_name (List.length f.params) (List.length args));
    List.iter2 (fun e (_, t) -> check e t tenv) args f.params

  and type_mem_access m tenv = match m with
    | Var x ->
      (match Env.find_opt x tenv with
       | Some t -> t
       | None -> error (Printf.sprintf "Variable %s does not exist" x))
    | Field(e, x) ->
      (match type_expr e tenv with
       | TClass c ->
         (match List.assoc_opt x (all_attributes c) with
          | Some t -> t
          | None -> error (Printf.sprintf "Attribute %s is not defined for class %s" x c))
       | t -> error (Printf.sprintf "Attribute %s accessed on a value of type %s"
                       x (typ_to_string t)))
  in

  let rec check_instr i ret tenv = match i with
    | Print e ->
      if type_expr e tenv = TVoid then error "Cannot print a void value"
    | Set(m, e) -> check e (type_mem_access m tenv) tenv
    | If(e, s1, s2) ->
      check e TBool tenv; check_seq s1 ret tenv; check_seq s2 ret tenv
    | While(e, s) -> check e TBool tenv; check_seq s ret tenv
    | Return e -> check e ret tenv
    | Expr e -> ignore (type_expr e tenv)
  and check_seq s ret tenv =
    List.iter (fun i -> check_instr i ret tenv) s
  in
  (* Vrai si tous les chemins d'exécution de [s] passent par un return. *)
  let rec returns s =
    List.exists (function
        | Return _ -> true
        | If(_, s1, s2) -> returns s1 && returns s2
        | While(Bool true, _) -> true (* boucle infinie : jamais de sortie sans return *)
        | _ -> false) s
  in

  let globals = add_env p.globals Env.empty in
  let check_method cl m =
    check_typ m.return; check_decls m.params; check_decls m.locals;
    if m.method_name = "constructor" && m.return <> TVoid then
      error (Printf.sprintf "Constructor of class %s must return void" cl.class_name);
    let tenv = add_env m.locals (add_env m.params globals) in
    check_seq m.code m.return (Env.add "this" (TClass cl.class_name) tenv);
    if m.return <> TVoid && not (returns m.code) then
      error (Printf.sprintf "Method %s should return a value of type %s"
               m.method_name (typ_to_string m.return))
  in
  let check_class cl =
    ignore (ancestors [cl.class_name] cl.class_name);
    check_decls cl.attributes;
    List.iter (check_method cl) cl.methods
  in

  check_decls p.globals;
  List.iter check_class p.classes;
  check_seq p.main TVoid globals
