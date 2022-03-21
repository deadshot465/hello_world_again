module Musicians.BandSupervisor where

import Prelude
import Control.Concurrent (newEmptyMVar, MVar, forkIO, threadDelay, killThread, myThreadId, putMVar, takeMVar)
import Musicians.Musician (Musician(Musician), delay, SkillLevel(Good, Bad))
import qualified Musicians.Musician as Musician
import Control.Monad (forever)
import Data.Foldable (traverse_)
  
startBand :: (Eq t, Num t) => t -> IO ()
startBand maxRetries = do
  channel <- newEmptyMVar :: IO (MVar (String, Musician.SkillLevel))
  newMembers <- sequence [
        addBandMember "singer" Good channel,
        addBandMember "bass" Good channel,
        addBandMember "drum" Bad channel,
        addBandMember "guitar" Good channel
        ]
  go maxRetries newMembers channel
  where
    go 0 members _ = do
      putStrLn "The manager is mad and fired the whole band!"
      traverse_ (`putMVar` 0) members
      threadDelay 3000000
    go maxRetries members channel = do
      (role, skillLevel) <- takeMVar channel
      newMember <- addBandMember role skillLevel channel
      go (maxRetries - 1) (newMember : members) channel

addBandMember
  :: String
  -> Musician.SkillLevel
  -> MVar (String, Musician.SkillLevel)
  -> IO (MVar Int)
addBandMember role skillLevel channel = do
  fireMVar <- newEmptyMVar :: IO (MVar Int)
  musician <- Musician.make role skillLevel fireMVar
  _ <- forkIO $ forever $ do
    threadDelay delay
    playResult <- Musician.playSound musician
    if playResult then
      pure ()
    else do
      putMVar channel (role, skillLevel)
      id <- myThreadId
      killThread id
  pure fireMVar