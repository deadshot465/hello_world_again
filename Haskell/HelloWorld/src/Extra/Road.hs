{-# LANGUAGE NamedFieldPuns #-}
module Extra.Road where

import Prelude

import Data.Foldable (foldl')

data Route = Route
  { destination :: Int
  , path :: [(Char, Int)]
  } deriving (Eq, Ord, Show)

data RoutingResult = RoutingResult
  { a :: Route
  , b :: Route
  } deriving (Eq, Ord, Show)

file :: String
file = "road.txt"

parseMap :: String -> [Int]
parseMap s = readInt <$> concat (words <$> lines s)

readInt :: String -> Int
readInt s = read s :: Int

groupValues :: [c] -> [(c, c, c)] -> [(c, c, c)]
groupValues [] acc = reverse acc
groupValues (a : b : x : xs) acc = groupValues xs ((a, b, x) : acc)
groupValues _ acc = reverse acc

shortestSteps :: RoutingResult -> (Int, Int, Int) -> RoutingResult
shortestSteps RoutingResult
  { a = Route
    { destination = destA
    , path = pathA
    }
  , b = Route
    { destination = destB
    , path = pathB
    }
  } (a, b, x) =
    let optA1 = Route { destination = destA + a, path = ('a', a) : pathA }
        optA2 = Route { destination = destB + b + x, path = ('x', x) : ('b', b) : pathB }
        optB1 = Route { destination = destB + b, path = ('b', b) : pathB }
        optB2 = Route { destination = destA + a + x, path = ('x', x) : ('a', a) : pathA } in
    RoutingResult
      { a = min optA1 optA2
      , b = min optB1 optB2
      }

initialRoutingResult :: RoutingResult
initialRoutingResult = RoutingResult
  { a = Route
    { destination = 0
    , path = []
    }
  , b = Route
    { destination = 0
    , path = []
    }
  }

optimalPath :: Foldable t => t (Int, Int, Int) -> [(Char, Int)]
optimalPath values =
  let RoutingResult { a, b } = foldl' shortestSteps initialRoutingResult values in
  let Route { path = resolved }
        | head (path a) /= ('x', 0) = a
        | head (path b) /= ('x', 0) = b
        | otherwise = Route { destination = 0, path = [] } in
  reverse resolved

run :: IO [(Char, Int)]
run = do
  rawString <- readFile file
  let values = flip groupValues [] $ parseMap rawString
  pure $ optimalPath values