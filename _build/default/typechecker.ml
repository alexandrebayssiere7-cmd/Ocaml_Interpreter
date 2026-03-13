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
  let tenv = add_env p.globals Env.empty in
  let globals_alias = List.fold_right (fun (a, b, _) init -> (a, b) :: init) p.globals [] in

  let rec get_attr c =
    match c.parent with
    | None -> c.attributes
    | Some s -> List.sort_uniq compare (c.attributes @ (get_attr (List.find (fun x -> x.class_name = s) p.classes)))
  in
  
  let rec get_meth c =
    match c.parent with
    | None -> c.methods
    | Some s -> List.sort_uniq compare (c.methods @ (get_meth (List.find (fun x -> x.class_name = s) p.classes)))
  in
  let rec check e typ tenv =
    let typ_e = type_expr e tenv in
    if typ_e <> typ && not (subclass type_e typ) then type_error typ_e typ

  and type_expr e tenv = match e with
    | Int _  -> TInt
    | Bool _ -> TBool
    | Unop(Opp, e1) -> check e1 TInt tenv; TInt
    | Unop(Not, e1) -> check e1 TBool tenv; TBool
    | Binop(And, e1, e2) | Binop(Or, e1, e2) -> check e1 TBool tenv; check e2 TBool tenv; TBool
    | Binop(Eq, e1, e2) | Binop(Neq, e1, e2) ->
      (match type_expr e1 tenv with
        | TInt ->  check e2 TInt tenv; TBool
        | TBool ->  check e2 TBool tenv; TBool
        | TClass(c) -> check e2 (TClass(c)) tenv; TBool
        | TVoid -> check e2 TVoid tenv; TBool)
    | Binop(Gt, e1, e2) | Binop(Ge, e1, e2) | Binop(Lt, e1, e2) | Binop(Le, e1, e2) ->
      check e1 TInt tenv; check e2 TInt tenv; TBool
    | Binop(_, e1, e2) -> check e1 TInt tenv; check e2 TInt tenv; TInt (*ca nous laisse ici les binops de + - * / donc que les opp arithmétique*)
    | This -> Env.find "this" tenv
    | New(s) -> check_class s [] tenv; TClass(s)
    | NewCstr(s, args) -> check_class s args tenv;
                          let cl = List.find (fun x -> x.class_name = s) p.classes in
                          TClass(cl.class_name)    | Get(m) -> type_mem_access m tenv
    | MethCall(e1, s, args) -> let t = type_expr e1 tenv in
                              (match t with
                              | TClass(c) -> check_mdef c s args tenv;
                                let cl = List.find (fun x -> x.class_name = c) p.classes in
                                let m = List.find (fun x -> x.method_name = s) (get_meth cl) in
                              m.return
                              | _ -> error (Printf.sprintf "It's not a vailable method"))
    | _ -> failwith "case not implemented in type_expr"

  and type_mem_access m tenv = match m with
    | Var(s) -> let t = Env.find_opt s tenv in
                (match t with
                | Some(v) -> v
                | None -> error (Printf.sprintf "Variable %s does not exist" s))
    | Field(e, s) -> (match type_expr e tenv with
                | TClass(c) -> let cl = List.find (fun x -> x.class_name = c) p.classes in
                              if not (List.mem s (List.map fst (get_attr cl))) then error (Printf.sprintf "Attribute %s is not defined for class %s" s cl.class_name);
                              snd (List.find (fun x -> fst x = s) (get_attr cl))
                | _ -> error (Printf.sprintf "Method %s is not applied to a class" s))
    | _ -> failwith "case not implemented in type_mem_access"
    and check_parent c =
      match c.parent with
        | None -> ()
        | Some s -> if not (List.exists (fun x -> x.class_name = s) p.classes) then error (Printf.sprintf "The class %s extended by %s doesn't exist" s c.class_name);
          if match (List.find (fun x -> x.class_name = s) p.classes).parent with | None -> false | Some s -> s = c.class_name then error (Printf.sprintf "The class %s extended by %s also extends %s" s c.class_name c.class_name)
    and check_class c args tenv =
      let cl = List.find_opt (fun x -> x.class_name = c) p.classes in
      match cl with
      | None -> error (Printf.sprintf "Class %s does not exist" c)
      | Some cl -> (check_parent cl;
        match args with
        | [] -> ()
        | _ -> let attr = List.map snd (get_attr (List.find (fun x -> x.class_name = c) p.classes)) in
             let args = List.map (fun a -> type_expr a tenv) args in
             if attr <> args then error (Printf.sprintf "Wrong number of arguments in class %s" cl.class_name))
    
    and check_mdef c m args tenv =
      let cl = List.find (fun x -> x.class_name = c) p.classes in
      if not (List.mem m (List.map (fun a -> a.method_name) (get_meth cl))) then error (Printf.sprintf "Method %s not found for class %s" m cl.class_name);
      let m = List.find (fun x -> x.method_name = m) (get_meth cl) in
      let () = if not (List.exists (fun i -> match i with | Return(_) -> true | _ -> false) m.code) && (m.return <> TVoid) then error (Printf.sprintf "Method %s should return a value of type %s" m.method_name (typ_to_string m.return)) in
      let tenv' = List.fold_left (fun init (s, t) -> Env.add s t init) Env.empty globals_alias in
      let tenv' = List.fold_left (fun init (s, t) -> Env.add s t init) tenv' m.params in
      let tenv' = List.fold_left (fun init (s, t) -> Env.add s t init) tenv' (List.fold_right (fun (a, b, _) init -> (a, b) :: init) m.locals []) in
      let tenv' = Env.add "this" (TClass(cl.class_name)) tenv' in
      let () = List.iter (fun i -> match i with | Return(e) -> check e m.return tenv' | _ -> ()) m.code in
      let attr = List.map snd m.params in
      let args = List.map (fun a -> type_expr a tenv) args in
      if attr <> args then error (Printf.sprintf "Wrong number of arguments in method %s from class %s" m.method_name cl.class_name)
    in
    let rec check_type_extend tm e tenv =
      let te = type_expr e tenv in
      match te with
      | TClass(c) -> if te = tm then () else
                    let c = List.find (fun x -> x.class_name = c) p.classes in
                    (match c.parent with
                    | None -> type_error tm te
                    | Some s -> let parent = (List.find (fun x -> x.class_name = s) p.classes) in check_type_extend tm (New parent.class_name) tenv)
      | _ -> check e tm tenv
      in
  
    let rec check_instr i ret tenv = match i with
      | Print e -> ()
      | Set (m, e) -> let tm = type_mem_access m tenv in
                      check_type_extend tm e tenv
      | If (e, s1, s2) -> check e TBool tenv;
                          check_seq s1 ret tenv;
                          check_seq s2 ret tenv
      | While (e, s) -> check e TBool tenv;
                        check_seq s ret tenv
      | Return e -> check e ret tenv
      | Expr e -> check e ret tenv
      | Assert e -> check e TBool tenv
    and check_seq s ret tenv =
      List.iter (fun i -> check_instr i ret tenv) s
    in
  check_seq p.main TVoid tenv ; check_globals p.globals tenv

