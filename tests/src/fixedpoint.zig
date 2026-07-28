const clap = @import("clap_zig");
const raw = @import("raw");
const std = @import("std");
const assert = std.debug.assert;
const testing = std.testing;

comptime {
    assert(clap.BeatTime == raw.clap_beattime);
    assert(clap.SecTime == raw.clap_sectime);
}

test "fixed-point factors" {
    try testing.expectEqual(raw.CLAP_BEATTIME_FACTOR, clap.beat_time_factor);
    try testing.expectEqual(raw.CLAP_SECTIME_FACTOR, clap.sec_time_factor);
}
