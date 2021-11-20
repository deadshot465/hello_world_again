module HelloWorld.Lib.Shared.Enemy

open System

type Enemy = {
    Name: string
    mutable Hp: int
    Defense: int
    Attack: int
    Flee: int
    Hit: int
    Level: int
}

type EnemyType =
    Golem of Enemy
    | Goblin of Enemy
    | Slime of Enemy
    
let CalculateGolemAttack level = level * 10 + 40

let rec MakeEnemy ordinal =
    let rng = Random()
    match ordinal with
    | 0 ->
        let level = rng.Next(0, Constants.MaxGolemLevel)
        Golem {
            Enemy.Level = level
            Enemy.Attack = CalculateGolemAttack level
            Enemy.Defense = level * 10 + 40
            Enemy.Flee = Constants.GolemFlee
            Enemy.Hit = Constants.GolemHit
            Enemy.Name = "ゴーレム"
            Enemy.Hp = level * 50 + 100
        }
    | 1 ->
        let level = rng.Next(0, Constants.MaxGoblinLevel)
        Goblin {
            Enemy.Level = level
            Enemy.Attack = level * 5 + 20
            Enemy.Defense = level * 5 + 20
            Enemy.Flee = Constants.GoblinFlee
            Enemy.Hit = Constants.GoblinHit
            Enemy.Name = "ゴブリン"
            Enemy.Hp = level * 30 + 75
        }
    | 2 ->
        let level = rng.Next(0, Constants.MaxSlimeLevel)
        Slime {
            Enemy.Level = level
            Enemy.Attack = level * 2 + 10
            Enemy.Defense = level * 2 + 10
            Enemy.Flee = Constants.SlimeFlee
            Enemy.Hit = Constants.SlimeHit
            Enemy.Name = "スライム"
            Enemy.Hp = level * 10 + 50
        }
    | _ -> MakeEnemy 0