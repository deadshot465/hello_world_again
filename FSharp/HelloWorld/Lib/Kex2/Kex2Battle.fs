module HelloWorld.Lib.Kex2.Kex2Battle

open System
open HelloWorld.Lib.Shared
open HelloWorld.Lib.Shared.Enemy
open Microsoft.FSharp.Core

type AttackMethod =
    Attack of (int * int)
    | Skill of (int * int)
    | Magic of (int * int)
    
type ProgressResult = Continue of Player | End of string

let rec private SelectAttack choice =
    let rng = Random()
    match choice with
    | 1 -> Attack (rng.Next(0, 41), Constants.AttackHit)
    | 2 -> Skill (rng.Next(0, 101), Constants.SkillHit)
    | 3 -> Magic (rng.Next(0, 181), Constants.MagicHit)
    | _ -> SelectAttack 1
    
let private CheckHitOrMiss hit = Random().Next(0, 101) < hit

let private ExtractEnemyData = function
    | Golem e -> e
    | Goblin e -> e
    | Slime e -> e

let private DamageEnemy attackMethod (enemy: Enemy) =
    let dmg, hit = match attackMethod with
                        | Attack item -> item
                        | Skill item -> item
                        | Magic item -> item
    let hitOrMiss = CheckHitOrMiss hit
    if hitOrMiss then
        let actualDamage = if dmg - enemy.Defense < 0 then 0 else dmg - enemy.Defense
        printfn $"{actualDamage}のダメージ！"
        let newEnemyHp = if enemy.Hp - actualDamage < 0 then 0 else enemy.Hp - actualDamage
        enemy.Hp <- newEnemyHp
        enemy
    else
        printfn "攻撃を外した！"
        enemy
        
let private DamagePlayer enemy (player: Player) =
    let hitOrMiss = CheckHitOrMiss enemy.Hit
    if hitOrMiss then
        let injury = if enemy.Attack - player.Defense < 0 then 0 else enemy.Attack - player.Defense
        printfn $"{injury}のダメージ！"
        let newPlayerHp = if player.Hp - injury < 0 then 0 else player.Hp - injury
        player.Hp <- newPlayerHp
        player
    else
        printfn "攻撃を外した！"
        player
        
let rec private BattleLoop enemy player =
    if enemy.Hp <= 0 then
        printfn $"{enemy.Name}Lv.${enemy.Level + 1}を倒した！"
        Continue player
    else
        match player.Hp with
        | x when x <= 0 ->
            printfn $"あなたは{enemy.Name}に負けました！"
            End "ゲームオーバー！"
        | _ ->
            printfn $"{enemy.Name} 残りHP：{enemy.Hp}"
            printf "武器を選択してください（１．攻撃　２．特技　３．魔法）＞"
            let choice = ref 0
            let userInput = Console.ReadLine()
            let parseResult = Int32.TryParse(userInput, choice)
            if not parseResult then
                BattleLoop enemy player
            else
                let attackMethod = SelectAttack choice.Value
                let newEnemy = DamageEnemy attackMethod enemy
                printfn $"{enemy.Name}の攻撃！"
                let newPlayer = DamagePlayer enemy player
                if newPlayer.Hp > 0 then
                    printfn $"プレイヤー残りHP：{newPlayer.Hp}"
                    BattleLoop newEnemy newPlayer
                else
                    BattleLoop newEnemy newPlayer
                    
let private EngageBattle enemy player =
    printfn $"{enemy.Name}Lv.{enemy.Level}が現れた！"
    BattleLoop enemy player
    
let GameLoop player =
    let rec innerLoop (player': Player) kills = function
        | 0 -> $"リ〇ミト！\n戦闘回数：{kills}回　残りHP：{player'.Hp}"
        | _ when player'.Hp <= 0 -> innerLoop player' kills 0
        | _ ->
            printfn $"\n現HP：{player'.Hp}"
            printf "奥に進みますか？（１：奥に進む　０．帰る）＞"
            let choice = ref 0
            let userInput = Console.ReadLine()
            let parseResult = Int32.TryParse(userInput, choice)
            if not parseResult then
                innerLoop player' kills 1
            else
                match choice.Value with
                | 0 -> innerLoop player' kills choice.Value
                | _ ->
                    let ordinal = Random().Next(0, 3)
                    let enemy = MakeEnemy ordinal
                    match EngageBattle (ExtractEnemyData enemy) player' with
                    | End s ->
                        Console.WriteLine s
                        player'.Hp <- 0
                        innerLoop player' kills 0
                    | Continue p -> innerLoop p (kills + 1) 1
    innerLoop player 0 1