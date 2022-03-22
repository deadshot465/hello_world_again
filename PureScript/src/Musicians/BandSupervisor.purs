module Musicians.BandSupervisor where

import Prelude

import Control.Monad.Rec.Class (forever)
import Data.Array (filter, find, (:))
import Data.Either (Either(..), hush)
import Data.Maybe (fromMaybe, Maybe(..))
import Data.Traversable (sequence, traverse_)
import Data.Tuple (Tuple(..))
import Effect (Effect)
import Effect.AVar as AVar
import Effect.Aff (Aff, Fiber, Milliseconds(..), delay, killFiber, launchAff, launchAff_, message)
import Effect.Aff as Effect.Exception
import Effect.Class (liftEffect)
import Effect.Class.Console (error, log)
import Musicians.Musician (SkillLevel(..))
import Musicians.Musician as Musician
import Readline (closeAndExit)

type MusicianData a =
  { role :: String
  , fiber :: Fiber a
  , fireAVar :: AVar.AVar Int
  }

startBand :: Int -> Aff Unit
startBand maxRetries = do
  Tuple c m <- liftEffect $ do
    channel <- AVar.empty :: Effect (AVar.AVar (Tuple String Musician.SkillLevel))
    newMembers <- sequence [
      addBandMember "singer" Good channel,
      addBandMember "bass" Good channel,
      addBandMember "drum" Bad channel,
      addBandMember "guitar" Good channel
      ]
    pure $ Tuple channel newMembers
  go maxRetries m c
  where
    go :: ∀ a. Int -> Array (MusicianData a) -> AVar.AVar (Tuple String Musician.SkillLevel) -> Aff Unit
    go 0 members _ = do
      log "The manager is mad and fired the whole band!"
      traverse_ (\{fiber, fireAVar} -> do
        _ <- liftEffect $ AVar.put 0 fireAVar (pure <<< fromMaybe unit <<< hush)
        delay $ Milliseconds 500.0
        killFiber (Effect.Exception.error "") fiber) members
      delay $ Milliseconds 3000.0
      closeAndExit
    go retries members channel = do
      _ <- liftEffect $ AVar.take channel (\result -> case result of
        Left e -> error $ message e
        Right (Tuple role skillLevel) -> launchAff_ do
          case find (\{role: r} -> r == role) members of
            Nothing -> pure unit
            Just {fiber} -> killFiber (Effect.Exception.error "") fiber
          let oldMembers = filter (\{role: r} -> r /= role) members
          newMember <- liftEffect $ addBandMember role skillLevel channel
          go (retries - 1) (newMember : oldMembers) channel)
      pure unit

addBandMember :: ∀ a. String -> Musician.SkillLevel -> AVar.AVar (Tuple String SkillLevel) -> Effect (MusicianData a)
addBandMember role skillLevel channel = do
  fireAVar <- AVar.empty :: Effect (AVar.AVar Int)
  musician <- Musician.make role skillLevel fireAVar
  fiber <- launchAff $ forever $ do
    delay $ Milliseconds Musician.delay
    playResult <- liftEffect $ Musician.playSound musician
    if playResult then
      pure unit
    else do
      result <- liftEffect $ AVar.put (Tuple role skillLevel) channel (\result -> case result of
                                                  Left e -> error $ message e
                                                  Right _ -> pure unit)
      liftEffect result
  pure { role, fiber, fireAVar }