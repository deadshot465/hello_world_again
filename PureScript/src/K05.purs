module K05 (K05(..)) where
  
import Prelude

import Data.Int (fromString)
import Effect.Aff (Aff, launchAff_)
import Effect.Class.Console (log)
import Question (class Question)
import Readline (closeAndExit, getNumber)
import Util (randomAff)

data K05 = K05

question1Loop :: Number -> Int -> String
question1Loop salary age | salary < 50.0 = question1Loop (salary * 1.035) (age + 1)
                         | otherwise = show age <> "歳で月給" <> show salary <> "万円"

question2Loop :: Int -> Aff Unit
question2Loop choice | choice == 1 = log "よし、学校へ行こう！"
                     | otherwise = do
                       log "起きろ～"
                       choice' <- getNumber "1．起きた　2．あと5分…　3．Zzzz…\t入力：" 4 fromString
                       question2Loop choice'

question3Loop :: Int -> Aff Unit
question3Loop choice | choice == 1 = do
                       log "よし、学校へ行こう！"
                       question3Loop 0
                     | otherwise = do
                       log "起きろ～"
                       choice' <- getNumber "1．起きた　2．あと5分…　3．Zzzz…\t入力：" 4 fromString
                       question3Loop choice'

type Golem = { hp :: Int, defense :: Int, attack :: Int }

inputDamage :: Int -> Aff Int
inputDamage choice = case choice of
  1 -> randomAff 0 40 >>= \n -> pure $ 60 + n
  2 -> randomAff 0 100 >>= \n -> pure $ 30 + n
  3 -> randomAff 0 180 >>= \n -> pure $ 20 + n
  _ -> do
    n <- getNumber "攻撃手段を選択してください（1．攻撃　2．特技　3．魔法）＞" 0 fromString
    inputDamage n

question4Loop :: Golem -> Int -> Aff Unit
question4Loop golem@{ hp, defense, attack } playerHp | hp == 0 && playerHp /= 0 = log "ゴーレムを倒しました！"
                                               | hp /= 0 && playerHp == 0 = log "あなたはゴーレムに負けました！ゲームオーバー！"
                                               | otherwise = do
                                                 log $ "ゴーレム残りHP：" <> show hp
                                                 damage <- inputDamage 0
                                                 log $ "基礎攻撃力は" <> show damage <> "です。"
                                                 let actualDamage = if diff <= 0 then 0 else diff where diff = damage - defense
                                                 case actualDamage of
                                                  0 -> do
                                                    log "ゴーレム：「ハハハハハ、情けないな！貴様は弱すぎる！」"
                                                    log $ "ゴーレムがあなたを攻撃しました！攻撃値：" <> show attack
                                                    let playerHp' = if diff' < 0 then 0 else diff' where diff' = playerHp - attack
                                                    log $ "あなたの残りHPは：" <> show playerHp'
                                                    question4Loop golem playerHp'
                                                  _ -> do
                                                    log $ "ダメージは" <> show actualDamage <> "です。"
                                                    let golemHp' = if diff' < 0 then 0 else diff' where diff' = hp - actualDamage
                                                    log $ "残りのHPは" <> show golemHp' <> "です。"
                                                    question4Loop golem { hp = golemHp' } playerHp

instance Question K05 where
  question1 _ = launchAff_ do
    let salary = 19.0
    let age = 22
    log $ question1Loop salary age
    closeAndExit

  question2 _ = launchAff_ do
    question2Loop 0
    closeAndExit

  question3 _ = launchAff_ do
    question3Loop 0
    closeAndExit

  question4 _ = launchAff_ do
    golemHp <- randomAff 0 200 >>= \n -> pure $ n + 300
    let golem = { hp: golemHp, defense: 80, attack: 50 }
    playerHp <- randomAff 0 100 >>= \n -> pure $ n + 200
    let { hp, defense } = golem
    log $ "ゴーレム　（HP：" <> show hp <> "　防御力：" <> show defense <> "）"
    question4Loop golem playerHp
    closeAndExit