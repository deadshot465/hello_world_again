module Musicians.Musician
  ( Musician
  , SkillLevel(..)
  , delay
  , firstNames
  , lastNames
  , make
  , pickName
  , playSound
  )
  where

import Prelude

import Data.Array (length, (!!))
import Data.Maybe (fromMaybe, Maybe(..))
import Effect (Effect)
import Effect.AVar (AVar)
import Effect.AVar as AVar
import Effect.Class.Console (log)
import Effect.Random (randomInt)

data SkillLevel
  = Good
  | Bad

type Musician =
  { name :: String
  , role :: String
  , skillLevel :: SkillLevel
  , receiver :: AVar Int
  }

firstNames :: Array String
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

lastNames :: Array String
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

delay :: Number
delay = 750.0

pickName ∷ Effect String
pickName = do
  firstName <- (randomInt 0 $ length firstNames - 1) >>= \n -> pure $ fromMaybe "" $ firstNames !! n
  lastName <- (randomInt 0 $ length lastNames - 1) >>= \n -> pure $ fromMaybe "" $ lastNames !! n
  pure $ firstName <> " " <> lastName

make :: String -> SkillLevel -> AVar Int -> Effect Musician
make role skillLevel receiver = do
  name <- pickName
  let musician = { name, role, skillLevel, receiver }
  log $ "Musician " <> name <> ", playing the " <> role <> " entered the room."
  pure musician

playSound :: Musician -> Effect Boolean
playSound { name, role, skillLevel, receiver } = do
  isFired <- AVar.tryTake receiver
  case isFired of
    Just _ -> do
      log $ name <> " just got back to playing in the subway."
      pure false
    Nothing -> case skillLevel of
      Good -> do
        log $ name <> " produced sound!"
        pure true
      Bad -> do
        failed <- randomInt 0 5 >>= \n -> pure $ n == 0
        if failed then do
          log $ name <> " played a false note. Uh oh."
          log $ name <> " sucks! kicked that member out of the band! (" <> role <> ")"
          pure false
        else do
          log $ name <> " produced sound!"
          pure true