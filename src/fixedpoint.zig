pub const Beattime = i64;
pub const Sectime = i64;

pub const beattime_factor: i64 = 1 << 31;
pub const sectime_factor: i64 = 1 << 31;

test "fixed-point factors" {
    const testing = @import("std").testing;
    const raw = @import("raw");

    try testing.expectEqual(raw.CLAP_BEATTIME_FACTOR, beattime_factor);
    try testing.expectEqual(raw.CLAP_SECTIME_FACTOR, sectime_factor);
}
