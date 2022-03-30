use "sol.sml";

(* ========================================================================= *)

val is_older_test_1 = is_older((18,5,2019), (19,5,2019)) = true;

val is_older_test_2 = is_older((19,5,2019), (19,5,2019)) = false;

val is_older_test_3 = is_older((19,6,2019), (19,5,2019)) = false;

val is_older_test_4 = is_older((19,5,2019), (19,6,2019)) = true;

val is_older_test_5 = is_older((19,5,2019), (18,5,2019)) = false; 


val all_is_older_test = is_older_test_1 andalso is_older_test_2 andalso is_older_test_3 andalso is_older_test_4 andalso is_older_test_5 ;

(* ========================================================================= *)

val number_in_month_test_1 = number_in_month([(18,5,2019), (19,5,2019)], 5) = 2;

val number_in_month_test_2 = number_in_month([(18,1,2019), (19,5,2019)], 5) = 1;

val number_in_month_test_3 = number_in_month([], 5) = 0;

val number_in_month_test_4 = number_in_month([(18,1,2019), (19,1,2019)], 5) = 0;

val number_in_month_test_5 = number_in_month([(19,5,2019)], 5) = 1;

val number_in_month_test_6 = number_in_month([(09,12,1990), (20,1,1990), (17,12,2000), (28,02,2021), (25, 12, 2021)], 12) = 3;


val all_number_in_month_test = number_in_month_test_1 andalso number_in_month_test_2 andalso number_in_month_test_3 andalso number_in_month_test_4 andalso number_in_month_test_5 andalso number_in_month_test_6;

(* ========================================================================= *)

val number_in_months_test_1 = number_in_months([(01,5,2019), (18,1,2019), (19,5,2019)], [5, 4]) = 2;

val number_in_months_test_2 = number_in_months([(18,1,2019), (19,5,2019), (19,5,2019)], [1,5]) = 3; 

val number_in_months_test_2 = number_in_months([(09,12,1900), (20,1,1900), (17,12,2000), (18,1,2010), (28,02,2000), (5,12,2000), (18,1,2010), (19,1,2010), (19,5,2010)], [1,12,5,2]) = 9; 

val number_in_months_test_3 = number_in_months([], [5]) = 0;

val number_in_months_test_4 = number_in_months([], []) = 0;

val number_in_months_test_5 = number_in_months([(18,1,2019), (19,1,2019)], [5,7]) = 0;

val number_in_months_test_6 = number_in_months([(19,3,2019)], [2,3,4]) = 1;


val all_number_in_months_test = number_in_months_test_1 andalso number_in_months_test_2 andalso number_in_months_test_3 andalso number_in_months_test_4 andalso number_in_months_test_5 andalso number_in_months_test_6;

(* ========================================================================= *)

val dates_in_month_test_1 = dates_in_month([(09,12,1900), (20,1,1900), (17,12,2000)],1) = [20];

val dates_in_month_test_2 = dates_in_month([(09,12,1900), (20,1,1900), (17,12,2000)],12) = [9,17];

val dates_in_month_test_3 = dates_in_month([],1) = [];

val dates_in_month_test_4 = dates_in_month([(09,12,1900), (20,1,1900), (17,12,2000)], 15) = [];

val dates_in_month_test_5 = dates_in_month([(09,12,1900), (20,1,1900), (17,12,2000) , (18,1,2010), (28,02,2000), (25,12,2000), (18,1,2010), (19,1,2010), (19,5,2010)], 1) = [20,18,18,19];

val all_dates_in_month_test = dates_in_month_test_1 andalso dates_in_month_test_2 andalso dates_in_month_test_3 andalso dates_in_month_test_4 andalso dates_in_month_test_5;


(* ========================================================================= *)

val dates_in_months_test_1 = dates_in_months([(09,12,1900), (20,1,1900), (17,12,2000) , (18,1,2010), (28,02,2000), (25,12,2000), (19,1,2010), (19,5,2010)], [12, 1, 2]) = [9,17,25,20,18,19,28];

val dates_in_months_test_2 = dates_in_months([(09,12,1900), (20,1,1900), (17,12,2000) , (18,1,2010), (28,02,2000), (25,12,2000), (19,1,2010), (19,5,2010)], [5]) = [19];

val dates_in_months_test_3 = dates_in_months([(09,12,1900), (20,1,1900), (17,12,2000) , (18,1,2010), (28,02,2000), (25,12,2000), (19,1,2010), (19,5,2010)], [12]) = [9,17,25];

val dates_in_months_test_4 = dates_in_months([], [12, 1, 2]) = [];

val dates_in_months_test_5 = dates_in_months([(09,12,1900), (20,1,1900)], []) = [];

val dates_in_months_test_6 = dates_in_months([(09,12,1900), (20,1,1900), (17,12,2000) , (18,1,2010), (28,02,2000), (25,12,2000), (19,1,2010), (19,5,2010)], [1, 2, 5, 12] ) = 
[20,18,19,28,19,9,17,25];


val all_dates_in_months_test = dates_in_months_test_1 andalso dates_in_months_test_2 andalso dates_in_months_test_3 andalso dates_in_months_test_4 andalso dates_in_months_test_5 andalso dates_in_months_test_6;



(* ========================================================================= *)
(* 
val get_nth_test_1 = get_nth(["ab", "cd", "ef", "gh", "ij", "lm"], 1) = "ab";

val get_nth_test_2 = get_nth(["ab", "cd", "ef", "gh", "ij", "lm"], 6) = "lm";

val get_nth_test_3 = get_nth(["ab", "cd", "ef", "gh", "ij", "lm"], 5) = "ij";

val get_nth_test_4 = get_nth([], 1) = "";

val get_nth_test_5 = get_nth(["ab", "cd", "ef", "gh", "ij", "lm"], 7) = "";


val all_get_nth_test_ = get_nth_test_1 andalso get_nth_test_2 andalso get_nth_test_3 andalso get_nth_test_4;
 *)
(* ========================================================================= *)

val date_to_string_test_1 = date_to_string(15,9,2000) = "September-15-2000";

val date_to_string_test_2 = date_to_string(28,5,2000) = "May-28-2000";

val date_to_string_test_3 = date_to_string(14,1,2022) = "January-14-2022";

val all_date_to_string_test = date_to_string_test_1 andalso date_to_string_test_2 andalso  date_to_string_test_3;

(* ========================================================================= *)

val number_before_reaching_sum_test_1 = number_before_reaching_sum(5, [1, 5, 7]) = 1;

val number_before_reaching_sum_test_2 = number_before_reaching_sum(10, [1, 5, 7, 15]) = 2;

val number_before_reaching_sum_test_3 = number_before_reaching_sum(27, [10, 8, 6, 3, 9]) = 3;

val number_before_reaching_sum_test_4 = number_before_reaching_sum(27, [1, 2, 3, 4, 5, 6, 7, 8, 1, 1, 8, 10, 3, 9]) = 6;

val number_before_reaching_sum_test_5 = number_before_reaching_sum(2, [31,28,31,30,31,30,31,31,30,31,30,31]) = 0;

val all_number_before_reaching_sum_test = number_before_reaching_sum_test_1 andalso number_before_reaching_sum_test_2 andalso number_before_reaching_sum_test_3 andalso number_before_reaching_sum_test_4 andalso number_before_reaching_sum_test_5;

(* ========================================================================= *)

val what_month_test_1 = what_month(01) = 1;

val what_month_test_2 = what_month(18) = 1;

val what_month_test_3 = what_month(31) = 1;

val what_month_test_4 = what_month(32) = 2;

val what_month_test_5 = what_month(50) = 2;

val what_month_test_6 = what_month(365) = 12;

val all_what_month_test = what_month_test_1 andalso what_month_test_2 andalso what_month_test_3 andalso what_month_test_4 andalso what_month_test_5 andalso what_month_test_6;


(* ========================================================================= *)

val month_range_test_1 = month_range(1, 2) = [1, 2];

val month_range_test_2 = month_range(2, 1) = [];

val month_range_test_3 = month_range(5, 9) = [5, 6, 7, 8, 9];

val month_range_test_4 = month_range(1, 12) = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12];

val all_month_range_test = month_range_test_1 andalso month_range_test_2 andalso month_range_test_3 andalso month_range_test_4;

(* ========================================================================= *)

val oldest_test_1 = oldest([(18,5,2019), (19,5,2019)]) = SOME (18, 5, 2019);

val oldest_test_2 = oldest([]) = NONE;

val oldest_test_3 = oldest([(18, 5, 2019), (18, 5, 2019), (18, 5, 2019)]) = SOME (18, 5, 2019);

val oldest_test_4 = oldest([(18, 5, 2019), (19, 5, 2019), (14, 12, 2000)]) = SOME (14, 12, 2000);

val oldest_test_5 = oldest([(18, 5, 2019), (19, 5, 2000), (28, 2, 2020)]) = SOME (19, 5, 2000);

val oldest_test_6 = oldest([(28, 02, 2000), (25, 12, 2000), (19, 1, 2010), (19, 5, 2010), (18,5,2019), (19,5,2019), (14,12,2000)]) = SOME (28, 2, 2000);

val all_oldest_test = oldest_test_1 andalso oldest_test_2 andalso oldest_test_3 andalso oldest_test_4 andalso oldest_test_5 andalso oldest_test_6;

(* ========================================================================= *)

val a = "=========================================================================";

val ALL_TEST = all_is_older_test andalso all_number_in_month_test andalso all_number_in_months_test andalso all_dates_in_month_test andalso all_dates_in_months_test andalso all_date_to_string_test andalso all_number_before_reaching_sum_test andalso all_what_month_test andalso all_month_range_test andalso all_oldest_test;


val a = "=========================================================================";

(* ========================================================================= *)

val number_in_months_challenge_test_1 = number_in_months_challenge([(11,1,2010), (18,1,2010)], [1,12,5,1,2]) = 2;

val number_in_months_challenge_test_2 = number_in_months_challenge([(11,1,2010), (18,1,2010), (19,1,2010), (30,1,1900), (28,02,2000), (19,5,2010), (5,12,2000), (09,12,1900), (17,12,2000)], [1,1,1,1]) = 4;

val number_in_months_challenge_test_3 = number_in_months_challenge([(11,1,2010), (18,1,2010), (19,1,2010), (30,1,1900), (28,02,2000), (19,5,2010), (5,12,2000), (09,12,1900), (17,12,2000)], [1,12,5,1,2]) = 9;


val all_number_in_months_challenge_test = number_in_months_challenge_test_1 andalso number_in_months_challenge_test_2 andalso number_in_months_challenge_test_3;

(* ========================================================================= *)


val dates_in_months_challenge_test_1 = dates_in_months_challenge([(09,12,1900), (20,1,1900), (17,12,2000) , (18,1,2010), (28,02,2000), (25,12,2000), (19,1,2010), (19,5,2010)], [12, 1, 2]) = [9,17,25,20,18,19,28];

val dates_in_months_challenge_test_2 = dates_in_months_challenge([(09,12,1900), (20,1,1900), (17,12,2000) , (18,1,2010), (28,02,2000), (25,12,2000), (19,1,2010), (19,5,2010)], [12, 1, 2, 1, 2]) = [9,17,25,20,18,19,28];

val dates_in_months_challenge_test_3 = dates_in_months_challenge([(09,12,1900), (20,1,1900), (17,12,2000) , (18,1,2010), (28,02,2000), (25,12,2000), (19,1,2010), (19,5,2010)], [12]) = [9,17,25];

val dates_in_months_challenge_test_4 = dates_in_months_challenge([], [12, 1, 2]) = [];

val dates_in_months_challenge_test_5 = dates_in_months_challenge([(09,12,1900), (20,1,1900)], []) = [];

val dates_in_months_challenge_test_6 = dates_in_months_challenge([(09,12,1900), (20,1,1900), (17,12,2000) , (18,1,2010), (28,02,2000), (25,12,2000), (19,1,2010), (19,5,2010)], [1, 1, 2, 5, 12] ) = 
[20,18,19,28,19,9,17,25];


val all_dates_in_months_challenge_test = dates_in_months_challenge_test_1 andalso dates_in_months_challenge_test_2 andalso dates_in_months_challenge_test_3 andalso dates_in_months_challenge_test_4 andalso dates_in_months_challenge_test_5 andalso dates_in_months_challenge_test_6;