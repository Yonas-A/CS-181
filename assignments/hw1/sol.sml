fun is_older (d1: int*int*int, d2: int*int*int) = 
    if (#3 d1) < (#3 d2) (* year d1 < year d2 *)
    then true
    else if (#3 d1) = (#3 d2) andalso (#2 d1) < (#2 d2) (* year of d1 = d2 and month of d1 < d2 *)
    then true
    else if  (#3 d1) = (#3 d2) andalso (#2 d1) = (#2 d2) andalso (#1 d1) < (#1 d2) (* year d1 = d2 and month d1 = d2 and day d1 < d2 *)
    then true
    else false  

fun number_in_month (xs : (int * int * int) list, x : int) = 
    if null xs
    then 0
    else if #2 (hd xs) = x
    then 1 + number_in_month(tl xs, x)
    else number_in_month(tl xs, x)

fun number_in_months (xs : (int * int * int) list, xd : int list) = 
    if null xd
    then 0
    else number_in_months(xs, tl xd) + number_in_month(xs, hd xd) 

fun dates_in_month (xs : (int * int * int) list, x : int) = 
    if null xs
    then []
    else if #2 (hd xs) = x
    then #1 (hd xs) :: dates_in_month(tl xs, x)
    else dates_in_month(tl xs, x)

fun dates_in_months (xs : (int * int * int) list, xd : int list) = 
    if null xd
    then []
    else dates_in_month(xs, hd xd) @ dates_in_months(xs, tl xd)

fun get_nth ( str : string list, x:int) =
    if null str
    then "hd str"
    else 
        let 
            fun get (str : string list, from : int) =
                if from = x
                then hd str
                else get( tl str, from + 1)
        in
            get (str, 1)
        end

fun date_to_string(d : int*int*int) = 
    let 
        val str = [ "January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"];
        val t = "-"
    in
        get_nth (str, #2 d) ^ t ^ Int.toString(#1 d) ^ t ^ Int.toString(#3 d)
    end

fun number_before_reaching_sum ( sum : int, xs : int list) =
    if null xs
    then 0
    else 
        let 
            fun get_sum (total : int, xs : int list, index : int) =
                if total < sum andalso total + hd xs >= sum
                then index
                else get_sum (total + hd xs, tl xs, index + 1)
        in
            get_sum (0, xs, 0)
        end

fun what_month(x : int) = 
    let 
        val xs = [31,28,31,30,31,30,31,31,30,31,30,31]
    in
       1 + number_before_reaching_sum(x, xs)
    end

fun month_range(a, b) = 
    if a > b
    then []
    else a :: month_range(a+ 1, b)

fun oldest (xs : (int * int * int) list) =
    if null xs
    then NONE
    else let (* fine to assume argument nonempty because it is local *)
        fun oldest_nonEmpty (xs : (int * int * int) list) =
                if null (tl xs) (* xs better not be [] *)
                then hd xs
                else 
                    let val tl_ans = oldest_nonEmpty(tl xs)
                    in
                        if is_older(hd xs , tl_ans)
                        then hd xs
                        else tl_ans
                    end
        in
            SOME (oldest_nonEmpty xs)
        end  


(* helper function for the first challenge problems *)
fun remove_all(x, xs) = 
    if null xs
    then []
    else if (hd xs) = x
    then remove_all(x, tl xs)
    else (hd xs) :: remove_all(x, tl xs)

fun  number_in_months_challenge (xs : (int * int * int) list, xd : int list) = 
    if null xd
    then 0
    else 
        let 
            val head = hd xd
        in 
            let 
                val t = remove_all(head, tl xd)
            in 
                number_in_months_challenge(xs, t) + number_in_month(xs, head) 
            end
        end

fun  dates_in_months_challenge (xs : (int * int * int) list, xd : int list) = 
    if null xd
    then []
    else 
        let 
            val head = hd xd
        in 
            let 
                val t = remove_all(head, tl xd)
            in
                dates_in_month(xs, head) @ dates_in_months_challenge(xs, t)
            end
        end
