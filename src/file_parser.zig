const std = @import("std");
const fs = std.fs;
const io = std.io;
const mem = std.mem;

pub fn parseFile(pattern_to_be_searched: []const u8, file_to_be_parsed: fs.File) void {
    var buffered_reader = io.bufferedReader(file_to_be_parsed.reader());
    var reader = buffered_reader.reader();
    var line_buffer = std.ArrayList(u8).init(std.heap.page_allocator);
    const stdout = io.getStdOut().writer();

    while (true) {
        line_buffer.clearRetainingCapacity();

        reader.streamUntilDelimiter(line_buffer.writer(), '\n', null) catch break;

        const current_line = line_buffer.items;

        if (mem.indexOf(u8, current_line, pattern_to_be_searched) != null)
            stdout.print("{s}\n", .{current_line}) catch return;
    }

    line_buffer.deinit();
}
