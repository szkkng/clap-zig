const clap = @import("clap_zig");
const raw = @import("raw");
const testing = @import("std").testing;

test "posix fd support identifiers" {
    try testing.expectEqualStrings(raw.CLAP_EXT_POSIX_FD_SUPPORT[0..], clap.ext.posix_fd_support.id);
}

test "posix fd support flags" {
    const Flags = clap.ext.posix_fd_support.Flags;
    try expectFlag(Flags, raw.CLAP_POSIX_FD_READ, .{ .read = true });
    try expectFlag(Flags, raw.CLAP_POSIX_FD_WRITE, .{ .write = true });
    try expectFlag(Flags, raw.CLAP_POSIX_FD_ERROR, .{ .@"error" = true });
}

fn expectFlag(comptime Flags: type, expected: anytype, actual: Flags) !void {
    try testing.expectEqual(
        @as(u32, @intCast(expected)),
        @as(u32, @bitCast(actual)),
    );
}
