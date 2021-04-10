const std = @import("std");
const golem = @import("../structs/golem.zig");
const utility = @import("../utility/utility.zig");

fn question_1() anyerror!void {
    const stdin = std.io.getStdIn();

    try utility.prompt("年齢を入力してください。＞");
    var buffer: [100]u8 = undefined;
    var input = (try utility.readNextLine(stdin.reader(), &buffer)).?;
    const age = try std.fmt.parseInt(i32, input, 10);

    if (age < 3 or age >= 70) {
        std.log.info("入場料金無料です。", .{});
    } else {
        std.log.info("通常料金です。", .{});
    }
}

fn question_2() anyerror!void {
    const stdin = std.io.getStdIn();

    try utility.prompt("性別を選択してください。（０：男性　１：女性）＞");
    var buffer: [100]u8 = undefined;
    var input = (try utility.readNextLine(stdin.reader(), &buffer)).?;
    const gender = try std.fmt.parseInt(i32, input, 10);

    switch (gender) {
        0 => std.log.info("あら、格好良いですね。", .{}),
        1 => std.log.info("あら、モデルさんみたいですね。", .{}),
        else => std.log.info("そんな選択肢はありません。", .{})
    }
}

fn question_3() anyerror!void {
    const stdin = std.io.getStdIn();

    try utility.prompt("年齢を入力してください。＞");
    var buffer: [100]u8 = undefined;
    var input = (try utility.readNextLine(stdin.reader(), &buffer)).?;
    const age = try std.fmt.parseInt(i32, input, 10);

    if (age < 3 or age >= 70) {
        std.log.info("入場料金無料です。", .{});
    } else if (age >= 3 and age <= 15) {
        std.log.info("子供料金で半額です。", .{});
    } else if (age >= 60 and age < 70) {
        std.log.info("シニア割引で一割引きです。", .{});
    } else {
        std.log.info("通常料金です。", .{});
    }
}

fn question_4() anyerror!void {
    std.log.info("＊＊＊おみくじプログラム＊＊＊", .{});

    const stdin = std.io.getStdIn();

    try utility.prompt("おみくじを引きますか　（はい：１　いいえ：０）＞");
    var buffer: [100]u8 = undefined;
    var input = (try utility.readNextLine(stdin.reader(), &buffer)).?;
    const choice = try std.fmt.parseInt(i32, input, 10);

    if (choice >= 1) {
        var prng = std.rand.DefaultPrng.init(blk: {
            var seed: u64 = undefined;
            try std.os.getrandom(std.mem.asBytes(&seed));
            break :blk seed;
        });
        const rand = &prng.random;

        switch (rand.intRangeAtMost(i32, 0, 4)) {
            0 => std.log.info("大吉　とってもいいことがありそう！！", .{}),
            1 => std.log.info("中吉　きっといいことあるんじゃないかな", .{}),
            2 => std.log.info("小吉　少しぐらいはいいことあるかもね", .{}),
            3 => std.log.info("凶　今日はおとなしくておいた方がいいかも", .{}),
            4 => std.log.info("大凶　これじゃやばくない？早く家に帰った方がいいかも", .{}),
            else => {}
        }
    }
}

pub fn execute(num: usize) anyerror!void {
    switch (num) {
        1 => try question_1(),
        2 => try question_2(),
        3 => try question_3(),
        4 => try question_4(),
        else => {},
    }
}
