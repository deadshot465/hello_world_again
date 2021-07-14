module K05 (K05(..)) where

import Prelude
import Question (Question(..))

data K05 = K05

question1Loop :: (Ord a1, Fractional a1, Num a2, Show a2, Show a1) => a1 -> a2 -> String
question1Loop salary age | salary < 50.0 = question1Loop (salary * 1.035) (age + 1)
                         | otherwise = show age <> "歳で月給" <> show salary <> "万円"

instance Question K05 where
  question1 _ = do
    let salary = 19.0
    let age = 22
    putStrLn $ question1Loop salary age

  question2 _ = do
    putStrLn "placeholder"

  question3 _ = do
    putStrLn "placeholder"

  question4 _ = do
    putStrLn "placeholder"