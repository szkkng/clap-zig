pub const version = @import("version.zig");
pub const Version = version.Version;
pub const plugin = @import("plugin.zig");

test {
    const std = @import("std");
    std.testing.refAllDecls(@This());
}
