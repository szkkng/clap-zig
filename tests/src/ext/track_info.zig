const clap = @import("clap_zig");
const raw = @import("raw");
const testing = @import("std").testing;

test "track info identifier" {
    try testing.expectEqualStrings(raw.CLAP_EXT_TRACK_INFO[0..], clap.ext.track_info.id);
    try testing.expectEqualStrings(raw.CLAP_EXT_TRACK_INFO_COMPAT[0..], clap.ext.track_info.id_compat);
}

test "track info flags" {
    const Flags = clap.ext.track_info.Info.Flags;
    try expectFlag(Flags, raw.CLAP_TRACK_INFO_HAS_TRACK_NAME, .{ .has_track_name = true });
    try expectFlag(Flags, raw.CLAP_TRACK_INFO_HAS_TRACK_COLOR, .{ .has_track_color = true });
    try expectFlag(Flags, raw.CLAP_TRACK_INFO_HAS_AUDIO_CHANNEL, .{ .has_audio_channel = true });
    try expectFlag(Flags, raw.CLAP_TRACK_INFO_IS_FOR_RETURN_TRACK, .{ .is_for_return_track = true });
    try expectFlag(Flags, raw.CLAP_TRACK_INFO_IS_FOR_BUS, .{ .is_for_bus = true });
    try expectFlag(Flags, raw.CLAP_TRACK_INFO_IS_FOR_MASTER, .{ .is_for_master = true });
}

fn expectFlag(comptime Flags: type, expected: anytype, actual: Flags) !void {
    try testing.expectEqual(
        @as(u64, @intCast(expected)),
        @as(u64, @bitCast(actual)),
    );
}
