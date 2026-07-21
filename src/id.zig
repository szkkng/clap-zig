const std = @import("std");

pub const ID = u32;

pub const invalid_id: ID = std.math.maxInt(c_uint);

comptime {
    const raw = @import("raw");
    std.debug.assert(invalid_id == raw.CLAP_INVALID_ID);
}
