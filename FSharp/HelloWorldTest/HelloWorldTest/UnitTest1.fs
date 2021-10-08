module HelloWorldTest

open System
open HelloWorld.Lib.Extra
open NUnit.Framework

[<SetUp>]
let Setup () =
    ()
    
let private ExpectedRoad = [
    ('b',10); ('x',30); ('a',5); ('x',20); ('b',2); ('b',8)
]

[<Test>]
let TestPlus () =
    Assert.AreEqual(5, Rpn.Rpn "2 3 +")

[<Test>]    
let TestMinus () =
    Assert.AreEqual(87, Rpn.Rpn "90 3 -")

[<Test>]    
let TestMultiply () =
    Assert.AreEqual(-4, Rpn.Rpn "10 4 3 + 2 * -")

[<Test>]    
let TestDivide () =
    Assert.AreEqual(-2.0, Rpn.Rpn "10 4 3 + 2 * - 2 /")

[<Test>]
let TestBadInput () =
    Assert.Throws<System.Exception>(fun () -> Rpn.Rpn "90 34 12 33 55 66 + * - +" |> ignore)
    |> ignore
    
[<Test>]
let TestComplexRpn1 () =
    Assert.AreEqual(4037, Rpn.Rpn "90 34 12 33 55 66 + * - + -")
    
[<Test>]
let TestPow () =
    Assert.AreEqual(8, Rpn.Rpn "2 3 ^")
    
[<Test>]
let TestSqrt () =
    Assert.AreEqual(Math.Sqrt 2.0, Rpn.Rpn "2 0.5 ^")
    
[<Test>]
let TestLn () =
    Assert.AreEqual(Math.Log 2.7, Rpn.Rpn "2.7 ln")
    
[<Test>]
let TestLog10 () =
    Assert.AreEqual(Math.Log10 2.7, Rpn.Rpn "2.7 log10")
    
[<Test>]
let TestSum () =
    Assert.AreEqual(50, Rpn.Rpn "10 10 10 20 sum")
    
[<Test>]
let TestSumAndDivide () =
    Assert.AreEqual(10.0, Rpn.Rpn "10 10 10 20 sum 5 /")
    
[<Test>]
let TestProduct () =
    Assert.AreEqual(1000.0, Rpn.Rpn "10 10 20 0.5 prod")
    
[<Test>]
let TestHeathrowToLondon () =
    Assert.AreEqual(ExpectedRoad, Road.Run)