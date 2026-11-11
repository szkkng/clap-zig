const abi = @import("../abi.zig");
const clap = @import("clap_zig");
const raw = @import("raw");
const testing = @import("std").testing;

comptime {
    const posix_fd_support = clap.ext.posix_fd_support;
    abi.assertCompatible(raw.clap_plugin_posix_fd_support, posix_fd_support.Plugin);
    abi.assertCompatible(raw.clap_host_posix_fd_support, posix_fd_support.Host);
}

test "posix fd support identifiers" {
    try testing.expectEqualStrings(raw.CLAP_EXT_POSIX_FD_SUPPORT[0..], clap.ext.posix_fd_support.id);
}

test "posix fd support flags" {
    const Flags = clap.ext.posix_fd_support.Flags;
    try testing.expectEqual(raw.CLAP_POSIX_FD_READ, @backingInt(Flags{ .read = true }));
    try testing.expectEqual(raw.CLAP_POSIX_FD_WRITE, @backingInt(Flags{ .write = true }));
    try testing.expectEqual(raw.CLAP_POSIX_FD_ERROR, @backingInt(Flags{ .@"error" = true }));
}
