const std = @import("std");
const stdout = std.io.getStdOut();

pub fn readNextLine(reader: anytype, buffer: []u8) !?[]const u8 {
    var line = (try reader.readUntilDelimiterOrEof(
        buffer,
        '\n',
    )) orelse return null;

    if (std.builtin.Target.current.os.tag == .windows) {
        line = std.mem.trimRight(u8, line, "\r");
    }

    return line;
}

pub fn prompt(msg: []const u8) anyerror!void {
    try stdout.writer().writeAll(msg);
}