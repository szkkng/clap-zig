const clap = @import("clap_zig");
const raw = @import("raw");
const std = @import("std");
const assert = std.debug.assert;
const testing = std.testing;

comptime {
    assert(clap.Id == raw.clap_id);
}

test "invalid_id matches CLAP_INVALID_ID" {
    try testing.expectEqual(raw.CLAP_INVALID_ID, clap.invalid_id);
}
