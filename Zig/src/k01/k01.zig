const std = @import("std");

fn question_1() void {
    std.log.info("Hello World!　ようこそZig言語の世界へ！\n", .{});
}

fn question_2() void {
    std.log.info("Hello World!\n", .{});
    std.log.info("ようこそ\n", .{});
    std.log.info("Zig言語の世界へ！\n", .{});
}

fn question_3() void {
    std.log.info("整数：{}", .{ 12345 });
    std.log.info("実数：{}", .{ 123.456789 });
    std.log.info("文字：{}", .{ 'A' });
    std.log.info("文字列：{s}", .{ "ABCdef" });
}

fn question_4() void {
    std.log.info("              ##\n", .{});
    std.log.info("             #  #\n", .{});
    std.log.info("             #  #\n", .{});
    std.log.info("            #    #\n", .{});
    std.log.info("           #      #\n", .{});
    std.log.info("         ##        ##\n", .{});
    std.log.info("       ##            ##\n", .{});
    std.log.info("    ###                ###\n", .{});
    std.log.info(" ###       ##    ##       ###\n", .{});
    std.log.info("##        #  #  #  #        ##\n", .{});
    std.log.info("##         ##    ##         ##\n", .{});
    std.log.info(" ##     #            #     ##\n", .{});
    std.log.info("  ###     ##########     ###\n", .{});
    std.log.info("     ###              ###\n", .{});
    std.log.info("        ##############\n", .{});
}

pub fn k01(num: i32) void {
    switch (num) {
        1 => question_1(),
        2 => question_2(),
        3 => question_3(),
        4 => question_4(),
        else => {}
    }
}