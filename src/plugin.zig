pub const Entry = @import("plugin/Entry.zig").Entry;

test {
    const std = @import("std");
    std.testing.refAllDecls(@This());
}
