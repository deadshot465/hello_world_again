open Extra.Road
open Extra.Rpn
open OUnit2

let expected_road = [
  ('b',10); ('x',30); ('a',5); ('x',20); ('b',2); ('b',8)
]

let test_plus _ = assert_equal 5.0 (Rpn.rpn "2.0 3.0 +")

let test_minus _ = assert_equal 87.0 (Rpn.rpn "90.0 3.0 -")

let test_multiply _ = assert_equal (-4.0) (Rpn.rpn "10 4 3 + 2 * -")

let test_divide _ = assert_equal (-2.0) (Rpn.rpn "10 4 3 + 2 * - 2 /")

let test_bad_input _ = assert_raises (Failure "Bad Input") (fun _ -> Rpn.rpn "90 34 12 33 55 66 + * - +")

let test_complex_input _ = assert_equal 4037.0 (Rpn.rpn "90 34 12 33 55 66 + * - + -")

let test_power _ = assert_equal 8.0 (Rpn.rpn "2 3 ^")

let test_sqrt _ = assert_equal (sqrt 2.0) (Rpn.rpn "2 0.5 ^")

let test_ln _ = assert_equal (log 2.7) (Rpn.rpn "2.7 ln")

let test_log10 _ = assert_equal (log10 2.7) (Rpn.rpn "2.7 log10")

let test_sum _ = assert_equal 50.0 (Rpn.rpn "10 10 10 20 sum")

let test_sum_and_divide _ = assert_equal 10.0 (Rpn.rpn "10 10 10 20 sum 5 /")

let test_product _ = assert_equal 1000.0 (Rpn.rpn "10 10 20 0.5 prod")

let test_heathrow_to_london _ = assert_equal expected_road Road.run

let suite =
  "suite" >:::
  [ "test_plus" >:: test_plus;
    "test_minus" >:: test_minus;
    "test_multiply" >:: test_multiply;
    "test_divide" >:: test_divide;
    "test_bad_input" >:: test_bad_input;
    "test_complex_input" >:: test_complex_input;
    "test_power" >:: test_power;
    "test_sqrt" >:: test_sqrt;
    "test_ln" >:: test_ln;
    "test_log10" >:: test_log10;
    "test_sum" >:: test_sum;
    "test_sum_and_divide" >:: test_sum_and_divide;
    "test_product" >:: test_product;
    "test_heathrow_to_london" >:: test_heathrow_to_london
  ]

let () =
  run_test_tt_main suite