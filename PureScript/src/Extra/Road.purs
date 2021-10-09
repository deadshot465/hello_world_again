module Extra.Road (run) where
  
import Prelude

import Data.Array (filter)
import Data.Foldable (class Foldable)
import Data.Generic.Rep (class Generic)
import Data.Int as Int
import Data.List (List(..), foldl, fromFoldable, head, reverse, (:))
import Data.Maybe (fromMaybe)
import Data.Show.Generic (genericShow)
import Data.String (length)
import Data.String.Regex as Regex
import Data.String.Regex.Unsafe (unsafeRegex)
import Data.Tuple (Tuple(..))
import Effect.Aff (Aff)
import Extra.Rpn (regexFlags)
import Node.Encoding (Encoding(..))
import Node.FS.Aff (readTextFile)

type Route =
  { destination :: Int
  , path :: List (Tuple Char Int)
  }

type RoutingResult =
  { a :: Route
  , b :: Route
  }

data Triple a b c = Triple a b c

derive instance Generic (Triple a b c) _

instance (Show a, Show b, Show c) => Show (Triple a b c) where
  show = genericShow

file :: String
file = "road.txt"

readInt :: String -> Int
readInt = fromMaybe 0 <<< Int.fromString

parseMap :: String -> List Int
parseMap =
  fromFoldable <<< map readInt <<< filter (\x -> x /= "" && length x > 0) <<< Regex.split (unsafeRegex "\\s" regexFlags)

groupValues :: ∀ a. List a -> List (Triple a a a) -> List (Triple a a a)
groupValues Nil acc = reverse acc
groupValues (a : b : x : xs) acc = groupValues xs (Triple a b x : acc)
groupValues _ acc = reverse acc

shortestSteps :: RoutingResult -> Triple Int Int Int -> RoutingResult
shortestSteps
  { a: { destination: destA, path: pathA }
  , b: { destination: destB, path: pathB }
  } (Triple a b x) =
  let optA1 = { destination: destA + a, path: (Tuple 'a' a) : pathA }
      optA2 = { destination: destB + b + x, path: (Tuple 'x' x) : (Tuple 'b' b) : pathB }
      optB1 = { destination: destB + b, path: (Tuple 'b' b) : pathB }
      optB2 = { destination: destA + a + x, path: (Tuple 'x' x) : (Tuple 'a' a) : pathA } in
  { a: min optA1 optA2, b: min optB1 optB2 }

initialRoutingResult :: RoutingResult
initialRoutingResult =
  { a: { destination: 0, path: Nil }
  , b: { destination: 0, path: Nil }
  }

optimalPath :: ∀ f. Foldable f => f (Triple Int Int Int) -> List (Tuple Char Int)
optimalPath values =
  let { a, b } = foldl shortestSteps initialRoutingResult values in
  let { path: resolved } = if (fromMaybe (Tuple 'x' 0) $ head a.path) /= (Tuple 'x' 0) then a
                           else if (fromMaybe (Tuple 'x' 0) $ head b.path) /= (Tuple 'x' 0) then b
                           else { destination: 0, path: Nil } in
  reverse resolved

run :: Aff (List (Tuple Char Int))
run = do
  content <- readTextFile UTF8 file
  let values = flip groupValues Nil $ parseMap content
  pure $ optimalPath values