module HelloWorld.Lib.K08Adventure

    open System
    
    type Golem = {
        Hp: int
        Defense: int
        Attack: int
    }
    
    type AttackType
        = Attack of int
        | Skill of int
        | Magic of int
        
    type ProgressResult = Continue of int | End of string
    
    let private rng = Random()

    let rec private selectAttack = function
        | 1 -> Attack (65 + rng.Next(0, 36))
        | 2 -> Skill (50 + rng.Next(0, 101))
        | 3 -> Magic (33 + rng.Next(0, 168))
        | _ -> selectAttack 1
        
    let rec private damagePlayer golemAttack playerHp =
        Console.WriteLine "ゴーレム：「ハハハハハ、情けないな！貴様は弱すぎる！」"
        Console.WriteLine $"ゴーレムがあなたを攻撃しました！攻撃値：{golemAttack}"
        playerHp - golemAttack
    
    let rec private battleLoop golemLevel golem playerHp =
        match golem.Hp with
        | 0 ->
            Console.WriteLine $"ゴーレムLv.{golemLevel + 1}を倒した！"
            Continue playerHp
        | _ ->
            Console.WriteLine $"ゴーレムLv.{golemLevel + 1}残りHP：{golem.Hp}"
            Console.WriteLine "武器を選択してください（１．攻撃　２．特技　３．魔法）＞"
            let baseDamage = match selectAttack (Console.ReadLine() |> Int32.Parse) with
                             | Attack dmg -> dmg
                             | Skill dmg -> dmg
                             | Magic dmg -> dmg
            let actualDamage = if baseDamage - golem.Defense <= 0 then 0 else baseDamage - golem.Defense
            Console.WriteLine $"ダメージは{actualDamage}です。"
            if actualDamage <= 0 then
                let newPlayerHp = damagePlayer golem.Attack playerHp
                if newPlayerHp <= 0 then End "あなたはゴーレムに負けました！"
                else
                    Console.WriteLine $"あなたの残りHPは：{newPlayerHp}"
                    battleLoop golemLevel golem newPlayerHp
            else
                let newGolemHp = if golem.Hp - actualDamage <= 0 then 0 else golem.Hp - actualDamage
                battleLoop golemLevel { Golem.Hp = newGolemHp; Golem.Defense = golem.Defense; Golem.Attack = golem.Attack  } playerHp
                
    let private engageBattle playerHp =
        let golemLevel = rng.Next(0, 10)
        let golem = { Golem.Hp = golemLevel * 50 + 100; Golem.Defense = golemLevel * 10 + 40; Golem.Attack = golemLevel * 10 + 30 }
        Console.WriteLine $"ゴーレムLv.{golemLevel + 1}が現れた！"
        battleLoop golemLevel golem playerHp
        
    let rec GameLoop = function
        | 0 -> "ゲームオーバー！"
        | x ->
            Console.WriteLine $"あなたのHP：{x}"
            Console.WriteLine "奥に進みますか？（１：奥に進む　０．帰る）＞"
            match (Console.ReadLine() |> Int32.Parse) with
            | 0 -> "リレ〇ト！"
            | _ -> match (engageBattle x) with
                   | End msg ->
                       Console.WriteLine msg
                       GameLoop 0
                   | Continue hp -> GameLoop hp