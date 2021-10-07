module Extra.Rpn where

import Prelude

import Data.Foldable ( Foldable(foldl') )
import GHC.Float ( powerFloat )

rpn :: String -> Either String Float
rpn input =
  let res : xs = foldl' (flip innerRpn) [] $ words input in
  case xs of
    [] -> Right res
    _ -> Left "Bad Input"

innerRpn :: String -> [Float] -> [Float]
innerRpn "+" (x : y : xs) = (y + x) : xs
innerRpn "-" (x : y : xs) = (y - x) : xs
innerRpn "*" (x : y : xs) = (y * x) : xs
innerRpn "/" (x : y : xs) = (y / x) : xs
innerRpn "^" (x : y : xs) = powerFloat y x : xs
innerRpn "ln" (x : xs) = log x : xs
innerRpn "log10" (x : xs) = logBase 10 x : xs
innerRpn "sum" xs = [sum xs]
innerRpn "prod" xs = [product xs]
innerRpn n xs = readFloat n : xs

readFloat :: String -> Float
readFloat s = read s :: Float