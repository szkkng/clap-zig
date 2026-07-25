const clap = @import("clap_zig");
const raw = @import("raw");
const testing = @import("std").testing;

test "latency identifier" {
    try testing.expectEqualStrings(raw.CLAP_EXT_LATENCY[0..], clap.ext.latency.id);
}
