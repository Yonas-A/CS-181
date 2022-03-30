(* Programming Languages, Dan Grossman, CSE341 *)

(* Lecture 6: Nested Pattern-Matching, Exceptions, Tail Recursion *)

exception ListLengthMismatch

(* don't do this *)
fun old_zip3 (l1,l2,l3) = 
    if null l1 andalso null l2 andalso null l3
    then []
    else if null l1 orelse null l2 orelse null l3
    then raise ListLengthMismatch
    else (hd l1, hd l2, hd l3) :: old_zip3(tl l1, tl l2, tl l3)

(* don't do this *)
fun shallow_zip3 (l1,l2,l3) =
    case l1 of
        [] => 
        (case l2 of 
             [] => (case l3 of
                        [] => []
                      | _ => raise ListLengthMismatch)
           | _ => raise ListLengthMismatch)
      | hd1::tl1 => 
        (case l2 of
             [] => raise ListLengthMismatch
           | hd2::tl2 => (case l3 of
                              [] => raise ListLengthMismatch
                            | hd3::tl3 => 
                              (hd1,hd2,hd3)::shallow_zip3(tl1,tl2,tl3)))

(* do this *)
fun zip3 list_triple =
    case list_triple of 
        ([],[],[]) => []
      | (hd1::tl1,hd2::tl2,hd3::tl3) => (hd1,hd2,hd3)::zip3(tl1,tl2,tl3)
      | _ => raise ListLengthMismatch

(* and the inverse *)
fun unzip3 lst =
    case lst of
        [] => ([],[],[])
      | (a,b,c)::tl => let val (l1,l2,l3) = unzip3 tl
                       in
                           (a::l1,b::l2,c::l3)
                       end

(* another elegant use of "deep" patterns *)
fun nondecreasing xs =
    case xs of
        [] => true
      | x::[] => true
      | head::(neck::rest) => (head <= neck andalso nondecreasing (neck::rest))

(* or remember this from homework 1 without pattern-matching? *)

fun cumulative_sum xs =
    case xs of
        [] => xs
      | x::[] => xs
      | head::(neck::rest) => head :: cumulative_sum ((head+neck) :: rest)

(* nested pattern-matching often convenient even without recursion;
   also the wildcard pattern is good style 
   match on a pair and one or more parts of it quite useful on homework 2
*)
datatype sgn = P | N | Z

fun multsign (x1,x2) = 
  let fun sign x = if x=0 then Z else if x>0 then P else N 
  in
      case (sign x1,sign x2) of
          (Z,_) => Z
        | (_,Z) => Z
        | (P,P) => P
        | (N,N) => P
        | _     => N (* many say bad style; I am okay with it *)
  end

(* simpler use of wildcard pattern for when you do not need the data *)

fun len xs =
    case xs of
       [] => 0
      | _::xs' => 1 + len xs'

(* exceptions *)

fun hd xs =
    case xs of
        []   => raise List.Empty
      | x::_ => x

exception MyUndesirableCondition

exception MyOtherException of int * int

fun mydiv (x,y) =
    if y=0
    then raise MyUndesirableCondition
    else x div y 

fun maxlist (xs,ex) = (* int list * exn -> int *)
    case xs of
        [] => raise ex
      | x::[] => x
      | x::xs' => Int.max(x,maxlist(xs',ex))

val w = maxlist ([3,4,5],MyUndesirableCondition) (* 5 *)

val x = maxlist ([3,4,5],MyUndesirableCondition) (* 5 *)
        handle MyUndesirableCondition => 42

(*val y = maxlist ([],MyUndesirableCondition)*)

val z = maxlist ([],MyUndesirableCondition) (* 42 *)
        handle MyUndesirableCondition => 42

(* tail recursion: fact2 is tail-recursive, fact1 is not *)

fun fact1 n = if n=0 then 1 else n * fact1(n-1)

(*
   fact1 4 
     => 4 * fact1(3)
     => 4 * 3 * fact1(2)
     => 4 * 3 * 2 * fact1(1)
     => 4 * 3 * 2 * 1 * fact1(0)
     => 4 * 3 * 2 * 1 * 1
     => ..
     => 24
*)

fun fact2 n =
    let fun aux(n,acc) = if n=0 then acc else aux(n-1,acc*n)
    in
        aux(n,1)
    end

(*
   fact2 4
     => aux(4,1)
     => aux(3,4)
     => aux(2,12)
     => aux(1,24)
     => aux(0,24)
     => 24
*)

(* more examples of making functions tail-recursive *)

fun sum1 xs =
    case xs of
        [] => 0
      | i::xs' => i + sum1 xs'

fun sum2 xs =
    let fun f (xs,acc) =
            case xs of
                [] => acc
              | i::xs' => f(xs',i+acc)
    in
        f(xs,0)
    end

fun rev1 xs =
   case xs of
       [] => []
     | x::xs' => (rev1 xs') @ [x]

fun rev2 xs =
    let fun aux(xs,acc) =
            case xs of
                [] => acc
              | x::xs' => aux(xs', x::acc)
    in
        aux(xs,[])
    end
