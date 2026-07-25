const clap = @import("clap_zig");
const raw = @import("raw");
const testing = @import("std").testing;

test "timer support identifier" {
    try testing.expectEqualStrings(raw.CLAP_EXT_TIMER_SUPPORT[0..], clap.ext.timer_support.id);
}
