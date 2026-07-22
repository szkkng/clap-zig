const std = @import("std");

pub const Id = u32;

pub const invalid_id: Id = std.math.maxInt(c_uint);

test "invalid_id matches CLAP_INVALID_ID" {
    const raw = @import("raw");
    try std.testing.expectEqual(invalid_id, raw.CLAP_INVALID_ID);
}
