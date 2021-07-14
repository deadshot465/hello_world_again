module Question where

import Prelude

class Question a where
  question1 :: a -> IO ()
  question2 :: a -> IO ()
  question3 :: a -> IO ()
  question4 :: a -> IO ()

execute :: (Eq a1, Num a1, Question a2) => a2 -> a1 -> IO ()
execute k n = case n of
  1 -> question1 k
  2 -> question2 k
  3 -> question3 k
  4 -> question4 k
  _ -> putStrLn "Unsupported"