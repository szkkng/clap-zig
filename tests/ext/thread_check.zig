const clap = @import("clap_zig");
const raw = @import("raw");
const testing = @import("std").testing;

test "thread check identifier" {
    try testing.expectEqualStrings(raw.CLAP_EXT_THREAD_CHECK[0..], clap.ext.thread_check.id);
}
