const abi = @import("../abi.zig");
const clap = @import("clap_zig");
const raw = @import("raw");

comptime {
    abi.assertCompatible(raw.clap_host_thread_check_t, clap.ext.thread_check.Host);
}

test "thread check identifier" {
    try abi.expectEqualCString(&raw.CLAP_EXT_THREAD_CHECK, clap.ext.thread_check.id);
}
