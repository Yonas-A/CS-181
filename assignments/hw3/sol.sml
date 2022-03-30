(* CSE341, HW3 Provided Code *)

datatype pattern = WildcardP
                 | VariableP of string
                 | UnitP
                 | ConstantP of int
                 | ConstructorP of string * pattern
                 | TupleP of pattern list

datatype valu = Constant of int
              | Unit
              | Constructor of string * valu
              | Tuple of valu list

(**** for the challenge problem only ****)

datatype typ = AnythingT
             | UnitT
             | IntT
             | TupleT of typ list
             | DatatypeT of string

(**** you can put all your code here ****)

fun only_lowercase xs  = 
    List.filter (fn x => Char.isLower (String.sub(x, 0)) ) xs 

fun longest_string1 xs = 
    List.foldl (fn (x, acc) => if String.size x <= String.size acc then acc else x ) "" xs

fun longest_string2 xs = 
    List.foldl (fn (x, acc) => if String.size x <  String.size acc then acc else x ) "" xs


(* val longest_string_helper = fn : (int * int -> bool) -> string list -> string *)

fun longest_string_helper f xs =
    case xs of 
        [] => ""
        | x::[] => x
        | x::x'::xs' => if f (String.size x, String.size x') then longest_string_helper f  (x::xs') else longest_string_helper f (x'::xs')

(* fun all_answers f xs =
    case xs of 
        f(x) => NONE  => NONE
        |  *)


(* 
fun all_answers f xs = (* means fun fold f = fn acc => fn xs => *)
    let fun aux(xs, acc) =
	    case xs of
                [] => NONE
              | x::xs' => if f x 
                          then SOME(x::xs') @ SOME [ aux(xs', acc)]
                          else NONE
    in
        aux(xs, [])
    end 
*)

(* fun all_answers f xs = (* means fun fold f = fn acc => fn xs => *)
    let fun aux(xs, acc) =
	    case xs of
                [] => NONE
              | x::xs' => (case f x  of 
                                NONE => NONE 
                          | SOME y =>  y @  [ aux(xs', acc)])
    in
        aux(xs, [])
    end *)
    
fun filter (f, xs) = 
    case xs of
        [] => []
        | x::xs' => if (f x) then x :: (filter (f, xs'))
                             else (filter (f, xs'))

fun filter2 (f, xs) = 
    case xs of
        [] => []
        | x::xs' => if (f x) then x @ (filter2 (f, xs'))
                             else (filter2 (f, xs'))

fun rev2 lst =
    let fun aux(lst,acc) =
            case lst of
                [] => acc
              | x::xs => aux(xs, x::acc)
    in
        aux(lst,[])
    end

fun all_answers f xs = 
    let fun aux(xs, acc) =
	    case xs of
                [] => NONE
              | x::xs' => if (f x) then [SOME x] @  [ SOME(aux (xs', x::acc)) ]
                             else NONE []
    in
        aux(xs,[])
    end

