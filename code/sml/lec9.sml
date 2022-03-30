(* Programming Languages, Dan Grossman, CSE341 *)

(* Lecture 9: Function-Closure Idioms *)

fun compose (f,g) = fn x => f (g x)

fun sqrt_of_abs i = Math.sqrt(Real.fromInt (abs i))

fun sqrt_of_abs i = (Math.sqrt o Real.fromInt o abs) i

val sqrt_of_abs = Math.sqrt o Real.fromInt o abs

(* tells the parser !> is a function that appears between its two arguments *)
infix !> 

(* operator more commonly written |>, but that confuses the current version
   of SML Mode for Emacs, leading to bad editing and formatting *)

(* definition of the pipeline operator *)
fun x !> f = f x

fun sqrt_of_abs i = i !> abs !> Real.fromInt !> Math.sqrt

fun backup1 (f,g) = fn x => case f x of NONE => g x | SOME y => y

fun backup2 (f,g) = fn x => f x handle _ => g x

(* old way to get the effect of multiple arguments *)
fun sorted3_tupled (x,y,z) = z >= y andalso y >= x

val t1 = sorted3_tupled (7,9,11)

(* new way: currying *)
val sorted3 = fn x => fn y => fn z => z >= y andalso y >= x

(* alternately: fun sorted3 x = fn y => fn z => z >= y andalso y >= x *)

val t2 = ((sorted3 7) 9) 11

(* syntactic sugar for calling curried functions: optional parentheses *)
val t3 = sorted3 7 9 11 

(* syntactic sugar for defining curried functions: space between arguments *)
fun sorted3_nicer x y z = z >= y andalso y >= x

(* more calls that work: *)
val t4 = sorted3_nicer 7 9 11
val t5 = ((sorted3_nicer 7) 9) 11

(* calls that do not work: cannot mix tupling and currying *)
(*val wrong1 = ((sorted3_tupled 7) 9) 11*)
(*val wrong2 = sorted3_tupled 7 9 11*)
(*val wrong3 = sorted3 (7,9,11)*)
(*val wrong4 = sorted3_nicer (7,9,11)*)

(* a more useful example *)
fun fold f acc xs = (* means fun fold f = fn acc => fn xs => *)
  case xs of
      []     => acc
    | x::xs' => fold f (f(acc,x)) xs'
(* Note: foldl in the ML standard library is very similar, but 
   the two arguments for the function f are in the opposite order. 
   The order is, naturally, a matter of taste.
*)

(* a call to curried fold: will improve with partial application next *)
fun sum xs = fold (fn (x,y) => x+y) 0 xs

(* If a curried function is applied to "too few" arguments, that just returns
   a closure, which is often useful -- a powerful idiom (no new semantics) *)

val is_nonnegative = sorted3 0 0

val sum = fold (fn (x,y) => x+y) 0

(* In fact, not doing this is often a harder-to-notice version of
   unnecessary function wrapping, as in these inferior versions *)

fun is_nonnegative_inferior x = sorted3 0 0 x

fun sum_inferior xs = fold (fn (x,y) => x+y) 0 xs

(* another example *)

fun range i j = if i > j then [] else i :: range (i+1) j

val countup  = range 1

fun countup_inferior x = range 1 x

(* common style is to curry higher-order functions with function arguments
   first to enable convenient partial application *)

fun exists predicate xs =
    case xs of
      [] => false
    | x::xs' => predicate x orelse exists predicate xs'

val no = exists (fn x => x=7) [4,11,23]

val hasZero = exists (fn x => x=0)

val incrementAll = List.map (fn x => x + 1)

(* library functions foldl, List.filter, etc. also generally curried: *)

val removeZeros = List.filter (fn x => x <> 0)

(* but if you get a strange message about "value restriction", just put back
   in the actually-necessary wrapping or an explicit non-polymorphic type *)

(* does not work for reasons we will not explain here (more later) *)
(* (only an issue will polymorphic functions) *)

(* val pairWithOne = List.map (fn x => (x,1)) *)

(* workarounds: *)
fun pairWithOne xs = List.map (fn x => (x,1)) xs

val pairWithOne : string list -> (string * int) list = List.map (fn x => (x,1))

(* this different function works fine because result is not polymorphic *)
val incrementAndPairWithOne = List.map (fn x => (x+1,1))

(* generic functions to switch how/whether currying is used *)
(* in each case, the type tells you a lot *)

fun curry f x y = f (x,y)

fun uncurry f (x,y) = f x y

fun other_curry1 f = fn x => fn y => f y x

fun other_curry2 f x y = f y x

(* example *)

(* tupled but we wish it were curried *)
fun range (i,j) = if i > j then [] else i :: range(i+1, j)

(* no problem *)
val countup = curry range 1

val xs = countup 7

(* callbacks *)

(* these two bindings would be internal (private) to the library *)
val cbs : (int -> unit) list ref = ref []
fun onEvent i =
   let fun loop fs =
         case fs of 
             [] => ()
           | f::fs' => (f i; loop fs')
   in loop (!cbs) end

(* clients call only this function (public interface to the library) *)
fun onKeyEvent f = cbs := f::(!cbs)

(* some clients where closures are essential
   notice different environments use bindings of different types
 *)
val timesPressed = ref 0
val _ = onKeyEvent (fn _ => timesPressed := (!timesPressed) + 1)

fun printIfPressed i =
    onKeyEvent (fn j => if i=j
                        then print ("you pressed " ^ Int.toString i ^ "\n")
                        else ())

(*
val _ = printIfPressed 4
val _ = printIfPressed 11
val _ = printIfPressed 23
val _ = printIfPressed 4
*)

(***************** likely optional below here: ADT via closures ************)

(* a set of ints with three operations *)
(* this interface is immutable -- insert returns a new set -- but we could
   also have implemented a mutable version using ML's references *)
(* Note: a 1-constructor datatype is an SML trick for recursive types *)
datatype set = S of { insert : int -> set, 
                      member : int -> bool, 
                      size   : unit -> int }

(* implementation of sets: this is the fancy stuff, but clients using
   this abstraction do not need to understand it *)
val empty_set =
    let
        fun make_set xs = (* xs is a "private field" in result *)
            let (* contains a "private method" in result *)
                fun contains i = List.exists (fn j => i=j) xs
            in
                S { insert = fn i => if contains i 
                                     then make_set xs 
                                     else make_set (i::xs),
                    member = contains,
                    size   = fn () => length xs
                  }
            end
    in
        make_set []
    end 

(* example client *)
fun use_sets () =
    let val S s1 = empty_set
        val S s2 = (#insert s1) 34
        val S s3 = (#insert s2) 34
        val S s4 = #insert s3 19
    in
        if (#member s4) 42
        then 99
        else if (#member s4) 19
        then 17 + (#size s3) ()
        else 0
    end 
