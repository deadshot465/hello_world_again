module HelloWorld.Lib.Extra.Road

open System
open System.IO
open System.Text.RegularExpressions

type Route = {
    Destination: int
    Path: (char * int) list
}

type RoutingResult = {
    A: Route
    B: Route
}

let rec private GroupValues acc input =
    match input with
    | [] -> List.rev acc
    | a :: b :: x :: xs -> GroupValues ((a, b, x) :: acc) xs
    | _ -> List.rev acc

let private ParseMap (s: string) =
    let regex = Regex(@"\s")
    regex.Split(s)
    |> List.ofArray
    |> List.filter (fun elem -> not (String.IsNullOrWhiteSpace(elem)))
    |> List.map Int32.Parse
    
let private ShortestSteps (acc: RoutingResult) elem =
    let a, b, x = elem
    let optA1 = { Route.Destination = acc.A.Destination + a; Route.Path = ('a', a) :: acc.A.Path }
    let optA2 = { Route.Destination = acc.B.Destination + b + x; Route.Path = ('x', x) :: ('b', b) :: acc.B.Path }
    let optB1 = { Route.Destination = acc.B.Destination + b; Route.Path = ('b', b) :: acc.B.Path }
    let optB2 = { Route.Destination = acc.A.Destination + a + x; Route.Path = ('x', x) :: ('a', a) :: acc.A.Path }
    { RoutingResult.A = min optA1 optA2; RoutingResult.B = min optB1 optB2 }
    
let private OptimalPath values =
    let initialRoutingResult = { RoutingResult.A = { Route.Destination = 0; Route.Path = [] }; RoutingResult.B = { Route.Destination = 0; Route.Path = [] } }
    let routingResult = List.fold ShortestSteps initialRoutingResult values
    let route = if (List.head routingResult.A.Path) <> ('x', 0) then routingResult.A
                else if (List.head routingResult.B.Path) <> ('x', 0) then routingResult.B
                else { Route.Destination = 0; Route.Path = [] }
    List.rev route.Path
    
let Run =
    File.ReadAllText("road.txt")
    |> ParseMap
    |> GroupValues []
    |> OptimalPath