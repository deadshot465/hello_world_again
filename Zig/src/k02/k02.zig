const std = @import("std");
const golem = @import("../structs/golem.zig");
const utility = @import("../utility/utility.zig");

fn question_1() anyerror!void {
    const seisuu = 3;
    const jissuu = 2.6;
    const moji = 'A';
    std.log.info("変数seisuuの値は{}", .{seisuu});
    std.log.info("変数jissuuの値は{}", .{jissuu});
    std.log.info("変数mojiの値は{}", .{moji});
}

fn question_2() anyerror!void {
    const stdin = std.io.getStdIn();

    try utility.prompt("一つ目の整数は？");
    var buffer: [100]u8 = undefined;
    var input = (try utility.readNextLine(stdin.reader(), &buffer)).?;
    const number1 = try std.fmt.parseInt(i32, input, 10);

    try utility.prompt("二つ目の整数は？");
    input = (try utility.readNextLine(stdin.reader(), &buffer)).?;
    const number2 = try std.fmt.parseInt(i32, input, 10);

    std.log.info("{}÷{}={}...{}", .{ number1, number2, @divTrunc(number1, number2), @rem(number1, number2) });
}

fn question_3() anyerror!void {
    const stdin = std.io.getStdIn();

    try utility.prompt("一つ目の商品の値段は？");
    var buffer: [100]u8 = undefined;
    var input = (try utility.readNextLine(stdin.reader(), &buffer)).?;
    const priceA = try std.fmt.parseInt(i32, input, 10);
    try utility.prompt("個数は？");
    input = (try utility.readNextLine(stdin.reader(), &buffer)).?;
    const amountA = try std.fmt.parseInt(i32, input, 10);

    try utility.prompt("二つ目の商品の値段は？");
    input = (try utility.readNextLine(stdin.reader(), &buffer)).?;
    const priceB = try std.fmt.parseInt(i32, input, 10);
    try utility.prompt("個数は？");
    input = (try utility.readNextLine(stdin.reader(), &buffer)).?;
    const amountB = try std.fmt.parseInt(i32, input, 10);

    const total: f32 = @intToFloat(f32, priceA * amountA + priceB * amountB) * 1.08;

    std.log.info("お支払いは税込み￥{}", .{total});
}

fn question_4() anyerror!void {
    var golem_instance = golem.Golem{ .hp = 300, .defense = 80, .attack = 50 };

    std.log.info("ゴーレム　（HP：{}　防御力：{}）", .{ golem_instance.hp, golem_instance.defense });
    std.log.info("HP：{}", .{golem_instance.hp});

    const stdin = std.io.getStdIn();

    try utility.prompt("今回の攻撃の値を入力してください＞");
    var buffer: [100]u8 = undefined;
    var input = (try utility.readNextLine(stdin.reader(), &buffer)).?;
    var damage = try std.fmt.parseInt(i32, input, 10);

    if (damage - golem_instance.defense > 0) {
        damage = damage - golem_instance.defense;
    } else {
        damage = 0;
    }

    std.log.info("ダメージは{}です。", .{damage});
    golem_instance.hp -= damage;
    std.log.info("残りのHPは{}です。", .{golem_instance.hp});
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
