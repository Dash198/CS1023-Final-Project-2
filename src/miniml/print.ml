let ty t ppf =
  let rec ty ~max_level t ppf =
    if not (Format.over_max_boxes ()) then
      match t with
        | Syntax.TExptn -> Zoo.print_parens ppf ~max_level ~at_level:0 "error"
        | Syntax.TInt -> Zoo.print_parens ppf ~max_level ~at_level:0 "int"
        | Syntax.TBool -> Zoo.print_parens ppf ~max_level ~at_level:0 "bool"
        | Syntax.TArrow (t1, t2) ->
          Zoo.print_parens ppf ~max_level ~at_level:1 "%t ->@ %t" (ty ~max_level:0 t1) (ty ~max_level:1 t2)
  in
    ty ~max_level:1 t ppf

let mvalue m ppf =
  match m with
    | Machine.MInt k -> Zoo.print_parens ppf "%d" k
    | Machine.MBool b -> Zoo.print_parens ppf "%b" b
    | Machine.MClosure _ -> Zoo.print_parens ppf "<fun>"
    | Machine.MExptn e-> (
      match e with
      | Syntax.DivisionByZero -> Zoo.print_parens ppf "Division By Zero"
      | Syntax.GenericException e -> Zoo.print_parens ppf "Generic Exception %d" e
    )
