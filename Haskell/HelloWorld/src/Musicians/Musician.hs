{-# LANGUAGE NamedFieldPuns #-}
module Musicians.Musician where

import Prelude
import Utility (getRandomInt)
import Control.Concurrent (MVar, tryTakeMVar)

data SkillLevel
  = Good
  | Bad

data Musician = Musician
  {
    name :: String
  , role :: String
  , skillLevel :: SkillLevel
  , receiver :: MVar Int
  }

firstNames :: [String]
firstNames =
  [ "Valerie"
  , "Arnold"
  , "Carlos"
  , "Dorothy"
  , "Keesha"
  , "Phoebe"
  , "Ralphie"
  , "Tim"
  , "Wanda"
  , "Janet"
  , "Leo"
  , "Yuhei"
  , "Carson"
  ]

lastNames :: [String]
lastNames =
  [ "Frizzle"
  , "Perlstein"
  , "Ramon"
  , "Ann"
  , "Franklin"
  , "Terese"
  , "Tennelli"
  , "Jamal"
  , "Li"
  , "Perlstein"
  , "Fujioka"
  , "Ito"
  , "Hage"
  ]

delay :: Int
delay = 750000

pickName :: IO String
pickName = do
  firstName <- getRandomInt (length firstNames) >>= \n -> pure $ firstNames !! n
  lastName <- getRandomInt (length lastNames) >>= \n -> pure $ lastNames !! n
  pure (firstName ++ " " ++ lastName)

make :: String -> SkillLevel -> MVar Int -> IO Musician
make role skillLevel receiver = do
  name <- pickName
  let musician = Musician { name, role, skillLevel, receiver }
  putStrLn $ "Musician " ++ name ++ ", playing the " ++ role ++ " entered the room."
  pure musician

playSound :: Musician -> IO Bool
playSound Musician{ name, role, skillLevel, receiver } = do
  isFired <- tryTakeMVar receiver
  case isFired of
    Just _ -> do
      putStrLn $ name ++ " just got back to playing in the subway."
      pure False
    Nothing -> case skillLevel of
      Good -> do
        putStrLn $ name ++ " produced sound!"
        pure True
      Bad -> do
        failed <- getRandomInt 5 >>= \n -> pure $ n == 0
        if failed then do
          putStrLn $ name ++ " played a false note. Uh oh."
          putStrLn $ name ++ " sucks! kicked that member out of the band! (" ++ role ++ ")"
          pure False
        else do
          putStrLn $ name ++ " produced sound!"
          pure True