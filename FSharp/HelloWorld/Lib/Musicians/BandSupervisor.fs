module HelloWorld.Lib.Musicians.BandSupervisor

open System
open System.Collections.Generic
open System.Linq
open System.Threading.Channels
open System.Threading.Tasks
open HelloWorld.Lib.Musicians

let private delay = 750

let private addBandMember role skillLevel channel =
    let fireChannel = Channel.CreateUnbounded<int>()

    let rec loop (m: Musician) (c: Channel<string * SkillLevel>) =
        task {
            do! Task.Delay(TimeSpan.FromMilliseconds(delay))
            let playResult = m.playSound ()

            if playResult then
                do! loop m c
            else
                do! c.Writer.WriteAsync((m.Role, m.SkillLevel))
                ()
        }

    let musician = Musician(role, skillLevel, fireChannel.Reader)
    task { do! loop musician channel } |> ignore
    fireChannel.Writer

let startBand maxRetries =
    task {
        let channel = Channel.CreateUnbounded<string * SkillLevel>()
        let writers = Dictionary<string, ChannelWriter<int>>()
        writers["singer"] <- addBandMember "singer" Good channel
        writers["bass"] <- addBandMember "bass" Good channel
        writers["drum"] <- addBandMember "drum" Bad channel
        writers["guitar"] <- addBandMember "guitar" Good channel

        let rec loop (c: Channel<string * SkillLevel>) =
            function
            | 0 ->
                task {
                    printfn "The manager is mad and fired the whole band!"

                    writers.ToArray()
                    |> Array.iter (fun elem ->
                        task { do! elem.Value.WriteAsync(0) } |> ignore
                        ())

                    do! Task.Delay(TimeSpan.FromSeconds(3))
                }
            | x ->
                task {
                    let! role, skillLevel = c.Reader.ReadAsync()
                    writers.Remove(role) |> ignore
                    writers[role] <- addBandMember role skillLevel c
                    do! loop c (x - 1)
                }

        do! loop channel maxRetries
    }
