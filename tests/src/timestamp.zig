const clap = @import("clap_zig");
const raw = @import("raw");
const std = @import("std");
const assert = std.debug.assert;
const testing = std.testing;

comptime {
    assert(clap.Timestamp == raw.clap_timestamp);
}

test "timestamp unknown" {
    try testing.expectEqual(raw.CLAP_TIMESTAMP_UNKNOWN, clap.timestamp_unknown);
}
