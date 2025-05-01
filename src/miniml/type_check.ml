(** Type checking. *)

open Syntax
exception Type_Error

let typing_error ~loc = Zoo.error ~kind:"Type error" ~loc

(** [check ctx ty e] verifies that expression [e] has type [ty] in
    context [ctx]. If it does, it returns unit, otherwise it raises the
    [Type_error] exception. *)
let rec check ctx ty (e) =
  let ty' = type_of ctx e in
    if ty' <> ty then
      raise Type_Error

(** [type_of ctx e] computes the type of expression [e] in context
    [ctx]. If [e] does not have a type it raises the [Type_error]
    exception. *)
and type_of ctx {Zoo.data=e; loc} =
  match e with
    | Var x ->
      (try List.assoc x ctx with
	  Not_found -> typing_error ~loc "unknown variable %s" x)
    | Int _ -> TInt
    | Bool _ -> TBool
    | Exptn _ -> TExptn

    (* Changed the type-checking for arithmetic and logical operations. If the types don't match, then an exception would be thrown.
    This is later checked during runtime in machine.ml as well. *)
    | Times (a, b) -> (try check ctx TInt a; check ctx TInt b; TInt with Type_Error -> TExptn)
    | By (a, b) -> (try check ctx TInt a; check ctx TInt b; TInt; with Type_Error -> TExptn)
    | Plus (a, b) -> (try check ctx TInt a; check ctx TInt b; TInt with Type_Error -> TExptn)
    | Minus (a, b) -> (try check ctx TInt a; check ctx TInt b; TInt with Type_Error -> TExptn)
    | Equal (a, b) -> (try check ctx TInt a; check ctx TInt b; TBool with Type_Error -> TExptn)
    | Less (a, b) -> (try check ctx TInt a; check ctx TInt b; TBool with Type_Error -> TExptn)

    | Raise _ -> TExptn

    (* For try, if the first expression results in an exception, then the type of the
      expressions in the with block is returned. It is assumed that all the expressions
      in the with block are of the same type, or else the type of the last expression would be returned.*)

    | Try (e, cases) ->
      let ty = type_of ctx e in
      (* Recursively go through the list and return the type of the last expression. *)
      let rec match_cases cases exp_case = match cases with
      | (_, exp) :: body -> let t' = type_of ctx exp in match_cases body t'
      | [] -> exp_case in
      (* Assign the return type to t' if the test expression is an exception. *)
      let t' = match_cases cases ty in if ty = TExptn then t' else ty

    | If (e1, e2, e3) ->
      check ctx TBool e1 ;
      let ty = type_of ctx e2 in
	check ctx ty e3 ; ty
    | Fun (f, x, ty1, ty2, e) ->
      check ((f, TArrow(ty1,ty2)) :: (x, ty1) :: ctx) ty2 e ;
      TArrow (ty1, ty2)

    (* Again, if the parameter is not of the expected data type, then an exception
      would be thrown, and this is checked in machine.ml during runtime. *)
    | Apply (e1, e2) ->
      begin
        match type_of ctx e1 with
	          | TArrow (ty1, ty2) -> 
                (try check ctx ty1 e2; ty2  
                with 
                  Type_Error -> TExptn
                )
            | _ -> typing_error ~loc
                  "this expression is used as a function but its type is not a function"
      end
