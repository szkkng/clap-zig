const abi = @import("../abi.zig");
const clap = @import("clap_zig");
const raw = @import("raw");
const testing = @import("std").testing;

comptime {
    const thread_pool = clap.ext.thread_pool;
    abi.assertStruct(thread_pool.Plugin, raw.clap_plugin_thread_pool_t);
    abi.assertFnPtr(@FieldType(thread_pool.Plugin, "exec"), @FieldType(raw.clap_plugin_thread_pool_t, "exec"));
    abi.assertStruct(thread_pool.Host, raw.clap_host_thread_pool_t);
    abi.assertFnPtr(@FieldType(thread_pool.Host, "requestExec"), @FieldType(raw.clap_host_thread_pool_t, "request_exec"));
}

test "thread pool identifier" {
    try testing.expectEqualStrings(raw.CLAP_EXT_THREAD_POOL[0..], clap.ext.thread_pool.id);
}
