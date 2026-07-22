const clap = @import("clap_zig");
const raw = @import("raw");
const testing = @import("std").testing;

test "fixed-point factors" {
    try testing.expectEqual(raw.CLAP_BEATTIME_FACTOR, clap.beattime_factor);
    try testing.expectEqual(raw.CLAP_SECTIME_FACTOR, clap.sectime_factor);
}
