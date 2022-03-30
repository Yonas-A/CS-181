datatype exp = Constant of int 
             | Double of exp 
             | Add of exp * exp
             | Divide of exp * exp

fun eval e =
    case e of
        Constant i => i
      | Double e2  => (eval e2) + (eval e2)
      | Add(e1,e2) => (eval e1) + (eval e2)
      | Divide(e1,e2) => (eval e1) div (eval e2)

fun no_literal_zero_divide e =
    let fun no_zero_second_arg (e1,e2) =
            let val second = no_literal_zero_divide e2
            in 
                if second >= 0 then true else false
            end
    in
        case e of
            Constant i    => i
          | Double e2     => no_literal_zero_divide e2
          | Add(e1,e2)    => no_literal_zero_divide(e1,e2)
          | Divide(e1,e2) => no_literal_zero_divide(e1,e2)
    end


datatype binary_tree = Leaf of int
                     | Node of int
                             * binary_tree
                             * binary_tree

fun tree_product e =
    case e of
        Leaf i => i
      | Node (i, left, right)  => (tree_product i) * (tree_product left) * (tree_product right)
                            
fun has_right_prod_larger e =
    case e of 
        Leaf i => false
      | Node (i, left, right)  => 
            let val left_product = tree_product left
                val right_product = tree_product right
            in 
                if right_product > left_product then true else false
            end
            
fun has_right_prod_larger e =
    case e of 
        Leaf i => false
      | Node (i, left, right)  => has_right_prod_larger( tree_product left) orelse has_right_prod_larger( tree_product right)

fun no_literal_zero_divide e = 
    case e of
        Constant _ => true
      | Double e => no_literal_zero_divide e
      | Add(e1,e2) => no_literal_zero_divide e1 andalso no_literal_zero_divide e2
      | Divide(_,Constant 0) => false
      | Divide(e1,e2) => no_literal_zero_divide e1 andalso no_literal_zero_divide e2
                                
            

val is_nonnegative = sorted3 0 0


val add_three_to_all = map (( fn x => x+3 ) , xs)

val x4 = map ((fn x => x+1), [4,8,12,16])


val add_three_to_all = map (( fn x => x+3 ) , xs)

fun add x y = x + y


val add_three_to_all = List.map (fn x => x + 1)

val add_three_to_all = List.map ( add 3 y)


fun chooser f g h xs = 
    case of xs
    [] => []
    x::xs' => h x => 