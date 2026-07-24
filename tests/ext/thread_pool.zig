const clap = @import("clap_zig");
const raw = @import("raw");
const testing = @import("std").testing;

test "thread pool identifier" {
    try testing.expectEqualStrings(raw.CLAP_EXT_THREAD_POOL[0..], clap.ext.thread_pool.id);
}
