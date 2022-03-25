namespace HelloWorld.Lib.Musicians

open System
open System.Threading.Channels
open HelloWorld.Lib.Musicians

type Musician(role: string, skillLevel: SkillLevel, reader: ChannelReader<int>) as x =
    static let firstNames =
        [| "Valerie"
           "Arnold"
           "Carlos"
           "Dorothy"
           "Keesha"
           "Phoebe"
           "Ralphie"
           "Tim"
           "Wanda"
           "Janet"
           "Leo"
           "Yuhei"
           "Carson" |]

    static let lastNames =
        [| "Frizzle"
           "Perlstein"
           "Ramon"
           "Ann"
           "Franklin"
           "Terese"
           "Tennelli"
           "Jamal"
           "Li"
           "Perlstein"
           "Fujioka"
           "Ito"
           "Hage" |]
        
    let name = Musician.pickName ()

    do printfn $"Musician {name}, playing the {role} entered the room."

    let reader = reader
    member val Name = name
    member val Role = role
    member val SkillLevel = skillLevel

    member x.playSound() =
        let isFired, _ = reader.TryRead()

        if isFired then
            printfn $"{x.Name} just got back to playing in the subway."
            false
        else
            match x.SkillLevel with
            | Good ->
                printfn $"{x.Name} produced sound!"
                true
            | Bad ->
                let rng = Random()
                let failed = rng.Next(0, 5) = 0

                if failed then
                    printfn $"{x.Name} played a false note. Uh oh."
                    printfn $"{x.Name} sucks! kicked that member out of the band! ({x.Role})"
                    false
                else
                    printfn $"{x.Name} produced sound!"
                    true

    static member pickName() =
        let rng = Random()

        let firstName =
            firstNames[rng.Next(0, Array.length firstNames)]

        let lastName =
            lastNames[rng.Next(0, Array.length lastNames)]

        $"{firstName} {lastName}"
