const std = @import("std");
const fs = std.fs;
const process = std.process;
const file_parser = @import("./file_parser.zig");

pub fn main() void {
    const allocator = std.heap.page_allocator;
    const args = process.argsAlloc(allocator) catch return;
    const pattern_to_be_searched = args[1];
    const file_to_be_parsed_name = args[2];
    const file_to_be_parsed = fs.cwd().openFile(file_to_be_parsed_name, .{}) catch return;

    file_parser.parseFile(pattern_to_be_searched, file_to_be_parsed);

    file_to_be_parsed.close();
    process.argsFree(allocator, args);
}
