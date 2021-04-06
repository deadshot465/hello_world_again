const std = @import("std");
const k01 = @import("k01/k01.zig");
const utility = @import("utility/utility.zig");

fn showSelections(chapter: i32) anyerror!void {
    const stdout = std.io.getStdOut();

    if (chapter < 10) {
        for ([_]u8{ 1, 2, 3, 4 }) |n| {
            try stdout.writer().print("\t{}) K0{}_{}\n", .{ n, chapter, n });
        }
        if (chapter == 9) {
            try stdout.writer().print("\t5) K0{}_5\n", .{ chapter });
        }
    }
    else {
        for ([_]u8{ 1, 2, 3, 4 }) |n| {
            try stdout.writer().print("\t{}) K{}_{}\n", .{ n, chapter, n });
        }
    }
}

pub fn main() anyerror!void {
    const stdout = std.io.getStdOut();
    const stdin = std.io.getStdIn();
    const executables = [_]fn(i32) void{ k01.k01 };

    try stdout.writeAll(
        \\実行したいプログラムを選択してください。
        \\
    );

    for (executables) |func, index| {
        if (index < 10) {
            try stdout.writer().print("{}) K0{}\t\t", .{index + 1, index + 1});
        }
    }
    try stdout.writer().print("\n", .{});

    var buffer: [100]u8 = undefined;
    const input = (try utility.readNextLine(stdin.reader(), &buffer)).?;
    // Can't even get this to work.
    const chapter = (try std.fmt.parseInt(i32, input, 10));
    showSelections(chapter);
}
