

(* val test: (int * int -> bool) -> string list -> string = longest_string_helper  (fn (x, acc ) => if x > acc then true else false ) *)
			  
(*
fun backup1 (f,g) = fn x => case f x of NONE => g x | SOME y => y

fun backup2 f g = fn x => case f x of NONE => g x | SOME y => y
*)

(*								  

fun rev2 xs =
    let fun aux(xs,acc) =
            case xs of
                [] => acc
              | x::xs' => aux(xs', x::acc)
    in
        aux(xs,[])
    end


fun all f xs =
    let 
        fun helper acc xs =
        case xs of
            [] => NONE
            | x::xs' => SOME (helper xs') ( xs @ acc)
        in 
            helper [] xs
    end

fun all_answers f xs = (* means fun fold f = fn acc => fn xs => *)
    let fun aux(xs, acc) =
	    case xs of
                [] => NONE
              | x::xs' => if f x 
                          then (SOME x::xs') @ [ (SOME  aux(xs', acc))]
                          else NONE
    in
        aux(xs,[])
    end
*)


string_helper   (fn (x, y ) => if x > y then true else false ) ["One", "two", "three", "F", "fif", "sever" ]