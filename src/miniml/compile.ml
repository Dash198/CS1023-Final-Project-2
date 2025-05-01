(** MiniML compiler. *)

open Machine

(** [compile e] compiles program [e] into a list of machine instructions. *)
let rec compile {Zoo.data=e'; _} =
  match e' with
    | Syntax.Var x -> [IVar x]
    | Syntax.Int k -> [IInt k]
    | Syntax.Bool b -> [IBool b]
    | Syntax.Times (e1, e2) -> (compile e1) @ (compile e2) @ [IMult]
    | Syntax.By (e1,e2) -> (compile e1) @ (compile e2) @ [IDiv]
    | Syntax.Plus (e1, e2) -> (compile e1) @ (compile e2) @ [IAdd]
    | Syntax.Minus (e1, e2) -> (compile e1) @ (compile e2) @ [ISub]
    | Syntax.Equal (e1, e2) -> (compile e1) @ (compile e2) @ [IEqual]
    | Syntax.Less (e1, e2) -> (compile e1) @ (compile e2) @ [ILess]
    | Syntax.If (e1, e2, e3) -> (compile e1) @ [IBranch (compile e2, compile e3)]
    (* Modified the definition of IClosure to include the type of the parameter as well for dynamic type checking.*)
    | Syntax.Fun (f, x, ty, _, e) -> [IClosure (f, x, compile e @ [IPopEnv], ty)]
    | Syntax.Apply (e1, e2) -> (compile e1) @ (compile e2) @ [ICall]
    | Syntax.Exptn e -> [IExptn e]    (* Exception compilation. *)
    | Syntax.Raise e -> [IRaise e]    (* Raise compilation added. *)
    (* While compiling try, also compile the expressions in each case using List.map and a helper anonymous function. *)
    | Syntax.Try (e,cases) -> (compile e) @ [IHandle (List.map (fun (e, ex) -> (e, compile ex)) cases)]