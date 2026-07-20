pub const version = @import("version.zig");
pub const Version = version.Version;

test {
    const std = @import("std");
    std.testing.refAllDecls(@This());
}
