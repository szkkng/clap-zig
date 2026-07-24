const clap = @import("clap_zig");
const raw = @import("raw");
const testing = @import("std").testing;

test "voice info identifier" {
    try testing.expectEqualStrings(raw.CLAP_EXT_VOICE_INFO[0..], clap.ext.voice_info.id);
}

test "voice info flags" {
    const Flags = clap.ext.voice_info.Info.Flags;
    try testing.expectEqual(
        @as(u64, @intCast(raw.CLAP_VOICE_INFO_SUPPORTS_OVERLAPPING_NOTES)),
        @as(u64, @bitCast(Flags{ .supports_overlapping_notes = true })),
    );
}
