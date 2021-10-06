module HelloWorldTest

open System
open HelloWorld.Lib.Extra
open NUnit.Framework

[<SetUp>]
let Setup () =
    ()

[<Test>]
let TestPlus () =
    Assert.AreEqual(5, Rpn.rpn "2 3 +")

[<Test>]    
let TestMinus () =
    Assert.AreEqual(87, Rpn.rpn "90 3 -")

[<Test>]    
let TestMultiply () =
    Assert.AreEqual(-4, Rpn.rpn "10 4 3 + 2 * -")

[<Test>]    
let TestDivide () =
    Assert.AreEqual(-2.0, Rpn.rpn "10 4 3 + 2 * - 2 /")

[<Test>]
let TestBadInput () =
    Assert.Throws<System.Exception>(fun () -> Rpn.rpn "90 34 12 33 55 66 + * - +" |> ignore)
    |> ignore
    
[<Test>]
let TestComplexRpn1 () =
    Assert.AreEqual(4037, Rpn.rpn "90 34 12 33 55 66 + * - + -")
    
[<Test>]
let TestPow () =
    Assert.AreEqual(8, Rpn.rpn "2 3 ^")
    
[<Test>]
let TestSqrt () =
    Assert.AreEqual(Math.Sqrt 2.0, Rpn.rpn "2 0.5 ^")
    
[<Test>]
let TestLn () =
    Assert.AreEqual(Math.Log 2.7, Rpn.rpn "2.7 ln")
    
[<Test>]
let TestLog10 () =
    Assert.AreEqual(Math.Log10 2.7, Rpn.rpn "2.7 log10")
    
[<Test>]
let TestSum () =
    Assert.AreEqual(50, Rpn.rpn "10 10 10 20 sum")
    
[<Test>]
let TestSumAndDivide () =
    Assert.AreEqual(10.0, Rpn.rpn "10 10 10 20 sum 5 /")
    
[<Test>]
let TestProduct () =
    Assert.AreEqual(1000.0, Rpn.rpn "10 10 20 0.5 prod")