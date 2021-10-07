module Extra.Rpn (log10, rpn) where
  
import Prelude

import Data.Either (Either(..))
import Data.Foldable (foldl, product, sum)
import Data.List (List(..), fromFoldable, (:))
import Data.Maybe (fromMaybe)
import Data.Number as Number
import Data.String.Regex (Regex, split)
import Data.String.Regex.Flags (RegexFlags(..))
import Data.String.Regex.Unsafe (unsafeRegex)
import Math (log, pow)

foreign import log10 :: Number -> Number

rpn :: String -> Either String Number
rpn s =
  let res = foldl (flip innerRpn) Nil $ fromFoldable $ split splitRegex s in
  case res of
    x : Nil -> Right x
    _ -> Left "Bad Input"

innerRpn :: String -> List Number -> List Number
innerRpn "+" (x : y : xs) = (y + x) : xs
innerRpn "-" (x : y : xs) = (y - x) : xs
innerRpn "*" (x : y : xs) = (y * x) : xs
innerRpn "/" (x : y : xs) = (y / x) : xs
innerRpn "^" (x : y : xs) = pow y x : xs
innerRpn "ln" (x : xs) = log x : xs
innerRpn "log10" (x : xs) = log10 x : xs
innerRpn "sum" xs = sum xs : Nil
innerRpn "prod" xs = product xs : Nil
innerRpn n xs = readFloat n : xs

readFloat :: String -> Number
readFloat = fromMaybe 0.0 <<< Number.fromString

regexFlags :: RegexFlags
regexFlags = RegexFlags
  { dotAll: false
  , global: false
  , ignoreCase: false
  , multiline: false
  , sticky: false
  , unicode: true
  }

splitRegex :: Regex
splitRegex = unsafeRegex " " regexFlags