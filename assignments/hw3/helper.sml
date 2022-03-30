fun fold f acc xs = (* means fun fold f = fn acc => fn xs => *)
    case xs of
	[] => acc
      | x::xs' => fold f (f(acc, x)) xs'

fun filter f xs =
    case xs of
        [] => []
      | x::xs' => if f x then x::(filter f xs') else filter f xs'

fun filter1 (f,xs) =
    case xs of
        [] => []
      | x::xs' => if f x
                  then x::(filter1 (f,xs'))
                  else filter1 (f,xs')

fun map f xs =
    case xs of
        [] => []
      | x::xs' => (f (x, x))::(map f xs' )

fun string_helper f xs =
    case xs of 
        [] => ""
        | x::[] => x
        | x::x'::xs' => if f (String.size x, String.size x') then string_helper f  (x'::xs') else string_helper f (x'::xs')

fun testHelper f xs = 
    case xs of 
        [] => ""
      | x::xs' => testHelper f xs'

fun newHelper f xs =
    let 
        val i = 0
    in  
        case xs of
            [] => []
          | x::xs' => (f(i, x)) :: newHelper f xs'
    end

val test_STRING_HELPER = string_helper (fn (x, y) => if x > y then true else false)


fun f8 xs s =
    let 
        val i = String.size s
    in
        fold (fn (x,y) => x andalso String.size y < i)  true  xs
    end


val mapTest = List.map

(* val test2 = List.map (fn (x, y) => if x > y then true else false) [1, 2, 3, 4, 5] *)

val filterTest = List.filter 

fun curry f x y = f (x,y)

fun curry2 f x y = f (x,x) y(x, x)

val pairWithOne : string list -> (string * int) list = List.map (fn x => (x,1))

fun backup2 f g = fn x => case f x of NONE => g x | SOME y => y

(* fun rev2 xs =
    let fun aux(xs,acc) =
            case xs of
                [] => acc
              | x::xs' => aux(xs', x::acc)
    in
        aux(xs,[])
    end *)


 
