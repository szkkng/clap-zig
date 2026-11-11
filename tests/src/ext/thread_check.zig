const abi = @import("../abi.zig");
const clap = @import("clap_zig");
const raw = @import("raw");
const testing = @import("std").testing;

comptime {
    abi.assertCompatible(raw.clap_host_thread_check_t, clap.ext.thread_check.Host);
}

test "thread check identifier" {
    try testing.expectEqualStrings(raw.CLAP_EXT_THREAD_CHECK[0..], clap.ext.thread_check.id);
}
