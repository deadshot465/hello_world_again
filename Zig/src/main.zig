const std = @import("std");
const k01 = @import("k01/k01.zig");
const k02 = @import("k02/k02.zig");
const k03 = @import("k03/k03.zig");
const k04 = @import("k04/k04.zig");
const utility = @import("utility/utility.zig");

fn showSelections(chapter: usize) anyerror!void {
    const stdout = std.io.getStdOut();

    if (chapter < 10) {
        for ([_]u8{ 1, 2, 3, 4 }) |n| {
            try stdout.writer().print("\t{}) K0{}_{}\n", .{ n, chapter, n });
        }
        if (chapter == 9) {
            try stdout.writer().print("\t5) K0{}_5\n", .{chapter});
        }
    } else {
        for ([_]u8{ 1, 2, 3, 4 }) |n| {
            try stdout.writer().print("\t{}) K{}_{}\n", .{ n, chapter, n });
        }
    }
}

pub fn main() anyerror!void {
    const stdout = std.io.getStdOut();
    const stdin = std.io.getStdIn();
    const executables = [_]fn (usize) anyerror!void{ 
        k01.execute, k02.execute, k03.execute, k04.execute
    };

    try stdout.writeAll(
        \\実行したいプログラムを選択してください。
        \\
    );

    for (executables) |func, index| {
        if (index < 10) {
            try stdout.writer().print("{}) K0{}\t\t", .{ index + 1, index + 1 });
        }
    }
    try stdout.writer().print("\n", .{});

    var buffer: [100]u8 = undefined;
    var input = (try utility.readNextLine(stdin.reader(), &buffer)).?;

    if (std.fmt.parseUnsigned(usize, input, 10)) |choice| {
        try showSelections(choice);
        input = (try utility.readNextLine(stdin.reader(), &buffer)).?;
        if (std.fmt.parseUnsigned(usize, input, 10)) |choice2| {
            try executables[@as(usize, choice - 1)](choice2);
        } else |err| {
            std.log.err("Error: {}", .{.err});
        }
    } else |err| {
        std.log.err("Error: {}", .{err});
    }
}
