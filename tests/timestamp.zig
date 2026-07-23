const clap = @import("clap_zig");
const raw = @import("raw");
const testing = @import("std").testing;

test "timestamp unknown" {
    try testing.expectEqual(raw.CLAP_TIMESTAMP_UNKNOWN, clap.timestamp.unknown);
}
