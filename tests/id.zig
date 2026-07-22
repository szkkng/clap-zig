const std = @import("std");
const clap = @import("clap_zig");
const raw = @import("raw");

test "invalid_id matches CLAP_INVALID_ID" {
    try std.testing.expectEqual(raw.CLAP_INVALID_ID, clap.invalid_id);
}
