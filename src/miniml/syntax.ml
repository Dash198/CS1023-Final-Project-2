(* Abstract syntax. *)

(* Variable names *)
type name = string

(* Types *)
type ty =
  | TInt              (* Integers *)
  | TBool             (* Booleans *)
  | TExptn
  | TArrow of ty * ty (* Functions *)

type exptn =
  | DivisionByZero 
  | GenericException of int

(* Expressions *)
type expr = expr' Zoo.located
and expr' =
  | Var of name          		(* Variable *)
  | Int of int           		(* Non-negative integer constant *)
  | Bool of bool         		(* Boolean constant *)
  | Times of expr * expr 		(* Product [e1 * e2] *)
  | Plus of expr * expr  		(* Sum [e1 + e2] *)
  | By of expr * expr       (* Integer quotient [e1/e2] *)
  | Minus of expr * expr 		(* Difference [e1 - e2] *)
  | Equal of expr * expr 		(* Integer comparison [e1 = e2] *)
  | Less of expr * expr  		(* Integer comparison [e1 < e2] *)
  | If of expr * expr * expr 		(* Conditional [if e1 then e2 else e3] *)
  (**| Try of expr * expr * expr   (* Try-with block [try e1 with error then e2] *)*)
  | Fun of name * name * ty * ty * expr (* Function [fun f(x:s):t is e] *)
  | Apply of expr * expr 		(* Application [e1 e2] *)
  | Exptn of exptn                  (* Sample to try an error *)
  | Raise of exptn          (* Raise an exception *)
  | Try of expr * (exptn * expr) list (* Try-with block *)

(* Toplevel commands *)
type command =
  | Expr of expr       (* Expression *)
  | Def of name * expr (* Value definition [let x = e] *)
