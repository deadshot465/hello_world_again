const std = @import("std");

fn question_1() anyerror!void {
    std.log.info("Hello World!　ようこそZig言語の世界へ！", .{});
}

fn question_2() anyerror!void {
    std.log.info("Hello World!", .{});
    std.log.info("ようこそ", .{});
    std.log.info("Zig言語の世界へ！", .{});
}

fn question_3() anyerror!void {
    std.log.info("整数：{}", .{12345});
    std.log.info("実数：{}", .{123.456789});
    std.log.info("文字：{}", .{'A'});
    std.log.info("文字列：{s}", .{"ABCdef"});
}

fn question_4() anyerror!void {
    std.log.info("              ##", .{});
    std.log.info("             #  #", .{});
    std.log.info("             #  #", .{});
    std.log.info("            #    #", .{});
    std.log.info("           #      #", .{});
    std.log.info("         ##        ##", .{});
    std.log.info("       ##            ##", .{});
    std.log.info("    ###                ###", .{});
    std.log.info(" ###       ##    ##       ###", .{});
    std.log.info("##        #  #  #  #        ##", .{});
    std.log.info("##         ##    ##         ##", .{});
    std.log.info(" ##     #            #     ##", .{});
    std.log.info("  ###     ##########     ###", .{});
    std.log.info("     ###              ###", .{});
    std.log.info("        ##############", .{});
}

pub fn k01(num: usize) anyerror!void {
    switch (num) {
        1 => try question_1(),
        2 => try question_2(),
        3 => try question_3(),
        4 => try question_4(),
        else => {},
    }
}
