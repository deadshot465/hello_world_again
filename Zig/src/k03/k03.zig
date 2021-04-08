const std = @import("std");
const golem = @import("../structs/golem.zig");
const utility = @import("../utility/utility.zig");

fn question_1() anyerror!void {
    const stdin = std.io.getStdIn();

    try utility.prompt("年齢を入力してください。＞");
    var buffer: [100]u8 = undefined;
    var input = (try utility.readNextLine(stdin.reader(), &buffer)).?;
    const age = try std.fmt.parseInt(i32, input, 10);

    if (age < 20) {
        std.log.info("未成年なので購入できません。", .{});
    }
}

fn question_2() anyerror!void {
    const stdin = std.io.getStdIn();

    try utility.prompt("身長を入力してください。＞");
    var buffer: [100]u8 = undefined;
    var input = (try utility.readNextLine(stdin.reader(), &buffer)).?;
    const height = (try std.fmt.parseFloat(f32, input)) / 100.0;

    try utility.prompt("体重を入力してください。＞");
    input = (try utility.readNextLine(stdin.reader(), &buffer)).?;
    const weight = try std.fmt.parseFloat(f32, input);

    const standard = height * height * 22.0;
    std.log.info("あなたの標準体重は{}です。", .{standard});

    if (weight > standard and (weight - standard) / standard * 100.0 > 14.0) {
        std.log.info("太り気味です。", .{});
    } else if (weight < standard and (weight - standard) / standard * 100.0 < -14.0) {
        std.log.info("痩せ気味です。", .{});
    } else {
        std.log.info("普通ですね。", .{});
    }
}

fn question_3() anyerror!void {
    const stdin = std.io.getStdIn();

    var prng = std.rand.DefaultPrng.init(blk: {
        var seed: u64 = undefined;
        try std.os.getrandom(std.mem.asBytes(&seed));
        break :blk seed;
    });
    const rand = &prng.random;

    const rand_num = rand.intRangeAtMost(i32, 0, 99);
    std.log.info("０から９９の範囲の数値が決定されました。", .{});
    try utility.prompt("決められた数値を予想し、この数値よりも大きな値を入力してください＞");
    var buffer: [100]u8 = undefined;
    var input = (try utility.readNextLine(stdin.reader(), &buffer)).?;
    const guess = try std.fmt.parseInt(i32, input, 10);

    std.log.info("決められた数値は{}です。", .{rand_num});
    if (guess > rand_num) {
        std.log.info("正解です。", .{});
    } else {
        std.log.info("不正解です。", .{});
    }
}

fn question_4() anyerror!void {
    const stdin = std.io.getStdIn();

    var prng = std.rand.DefaultPrng.init(blk: {
        var seed: u64 = undefined;
        try std.os.getrandom(std.mem.asBytes(&seed));
        break :blk seed;
    });
    const rand = &prng.random;

    const rand_num = rand.intRangeAtMost(i32, 0, 99);
    std.log.info("０から９９の範囲の数値が決定されました。", .{});
    try utility.prompt("決められた数値を予想し、この数値よりも大きな値を入力してください＞");
    var buffer: [100]u8 = undefined;
    var input = (try utility.readNextLine(stdin.reader(), &buffer)).?;
    const guess = try std.fmt.parseInt(i32, input, 10);

    std.log.info("決められた数値は{}です。", .{rand_num});

    if (guess < 0 or guess > 99) {
        std.log.info("反則です！", .{});
    } else if (guess > rand_num and guess - rand_num <= 10) {
        std.log.info("大正解です！", .{});
    } else if (guess < rand_num and rand_num - guess <= 10) {
        std.log.info("惜しい！", .{});
    } else if (guess == rand_num) {
        std.log.info("お見事！", .{});
    } else {
        if (guess > rand_num) {
            std.log.info("正解です。", .{});
        } else {
            std.log.info("不正解です。", .{});
        }
    }
}

pub fn k03(num: usize) anyerror!void {
    switch (num) {
        1 => try question_1(),
        2 => try question_2(),
        3 => try question_3(),
        4 => try question_4(),
        else => {},
    }
}
