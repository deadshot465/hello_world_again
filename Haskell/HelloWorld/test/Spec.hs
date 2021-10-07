import Prelude

import Test.HUnit (Test(TestCase, TestList, TestLabel), assertEqual, runTestTT)
import Extra.Rpn (rpn)

test1 :: Test
test1 = TestCase (assertEqual "Test Plus" (Right 5.0) $ rpn "2 3 +")

test2 :: Test
test2 = TestCase (assertEqual "Test Minus" (Right 87.0) $ rpn "90 3 -")

test3 :: Test
test3 = TestCase (assertEqual "Test Multiply" (Right (-4.0)) $ rpn "10 4 3 + 2 * -")

test4 :: Test
test4 = TestCase (assertEqual "Test Divide" (Right (-2.0)) $ rpn "10 4 3 + 2 * - 2 /")

test5 :: Test
test5 = TestCase (assertEqual "Test Bad Input" (Left "Bad Input") $ rpn "90 34 12 33 55 66 + * - +")

test6 :: Test
test6 = TestCase (assertEqual "Test Complex Input" (Right 4037.0) $ rpn "90 34 12 33 55 66 + * - + -")

test7 :: Test
test7 = TestCase (assertEqual "Test Power" (Right 8.0) $ rpn "2 3 ^")

test8 :: Test
test8 = TestCase (assertEqual "Test Sqrt" (Right $ sqrt 2.0) $ rpn "2 0.5 ^")

test9 :: Test
test9 = TestCase (assertEqual "Test Ln" (Right $ log 2.7) $ rpn "2.7 ln")

test10 :: Test
test10 = TestCase (assertEqual "Test Log10" (Right $ logBase 10 2.7) $ rpn "2.7 log10")

test11 :: Test
test11 = TestCase (assertEqual "Test Sum" (Right 50.0) $ rpn "10 10 10 20 sum")

test12 :: Test
test12 = TestCase (assertEqual "Test Sum And Divide" (Right 10.0) $ rpn "10 10 10 20 sum 5 /")

test13 :: Test
test13 = TestCase (assertEqual "Test Product" (Right 1000.0) $ rpn "10 10 20 0.5 prod")

main :: IO ()
main = do
  let testList = TestList
        [ TestLabel "Test Plus" test1
        , TestLabel "Test Minus" test2
        , TestLabel "Test Multiply" test3
        , TestLabel "Test Divide" test4
        , TestLabel "Test Bad Input" test5
        , TestLabel "Test Complex Input" test6
        , TestLabel "Test Power" test7
        , TestLabel "Test Sqrt" test8
        , TestLabel "Test Ln" test9
        , TestLabel "Test Log10" test10
        , TestLabel "Test Sum" test11
        , TestLabel "Test Sum And Divide" test12
        , TestLabel "Test Product" test13
        ]
  count <- runTestTT testList
  pure ()