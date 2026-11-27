const abi = @import("../abi.zig");
const clap = @import("clap_zig");
const raw = @import("raw");

comptime {
    const thread_pool = clap.ext.thread_pool;
    abi.assertCompatible(raw.clap_plugin_thread_pool_t, thread_pool.Plugin);
    abi.assertCompatible(raw.clap_host_thread_pool_t, thread_pool.Host);
}

test "thread pool identifier" {
    try abi.expectEqualCString(&raw.CLAP_EXT_THREAD_POOL, clap.ext.thread_pool.id);
}
