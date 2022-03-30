use "hw3.sml";

(* == == == == == == == == == == == == == == == == == == == == == == == == == == == == == == == == == == == == == *)

val only_lowercase_1 = only_lowercase([ "One", "two", "three", "F", "fif" ]) = [ "two", "three", "fif" ];

val only_lowercase_2 = only_lowercase([ "One", "two", "three", "F", "fif", "Se" ]) = [ "two", "three", "fif" ];

val only_lowercase_3 = only_lowercase([ "One", "two", "three", "F", "fif", "s" ]) = [ "two", "three", "fif", "s" ];

val all_only_lowercase = only_lowercase_1 andalso only_lowercase_2 andalso only_lowercase_3;

(* == == == == == == == == == == == == == == == == == == == == == == == == == == == == == == == == == == == == == *)
val newline = #"\n"


val longest_string1_1 = longest_string1([ "One", "two", "three", "F", "fif" ]) = "three";

val longest_string1_2 = longest_string1([ "Onee", "two", "thr", "F", "fif" ]) = "Onee";

val longest_string1_3 = longest_string1([ "One", "two", "thr", "For", "fif" ]) = "One";

val longest_string1_4 = longest_string1([ "On", "two", "thr", "For", "fif" ]) = "two";

val all_longest_string1 = longest_string1_1 andalso longest_string1_2 andalso longest_string1_3 andalso  longest_string1_4;

(* == == == == == == == == == == == == == == == == == == == == == == == == == == == == == == == == == == == == == *)
val newline = #"\n"



val longest_string2_1 = longest_string2([ "One", "two", "three", "F", "fif" ]) = "three";

val longest_string2_2 = longest_string2([ "Onee", "two", "thr", "F", "fif" ]) = "Onee";

val longest_string2_3 = longest_string2([ "One", "two", "thr", "For", "fif" ]) = "fif";

val longest_string2_4 = longest_string2([ "On", "two", "thr", "For", "fif" ]) = "fif";

val all_longest_string2 = longest_string2_1 andalso longest_string2_2 andalso longest_string2_3 andalso  longest_string2_4;

(* val longest_string2_1 = longest_string2([ "One", "two", "three", "F", "fif" ]);

val longest_string2_2 = longest_string2([ "Onee", "two", "thr", "F", "fif" ]);

val longest_string2_3 = longest_string2([ "One", "two", "thr", "For", "fif" ]);

val longest_string2_4 = longest_string2([ "On", "two", "thr", "For", "fif" ]); *)
