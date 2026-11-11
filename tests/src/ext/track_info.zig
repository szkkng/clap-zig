const abi = @import("../abi.zig");
const clap = @import("clap_zig");
const raw = @import("raw");
const testing = @import("std").testing;

comptime {
    const track_info = clap.ext.track_info;
    abi.assertCompatible(raw.clap_track_info_t, track_info.Info);
    abi.assertCompatible(raw.clap_plugin_track_info_t, track_info.Plugin);
    abi.assertCompatible(raw.clap_host_track_info_t, track_info.Host);
}

test "track info identifier" {
    try testing.expectEqualStrings(raw.CLAP_EXT_TRACK_INFO[0..], clap.ext.track_info.id);
    try testing.expectEqualStrings(raw.CLAP_EXT_TRACK_INFO_COMPAT[0..], clap.ext.track_info.id_compat);
}

test "track info flags" {
    const Flags = clap.ext.track_info.Info.Flags;
    try testing.expectEqual(raw.CLAP_TRACK_INFO_HAS_TRACK_NAME, @backingInt(Flags{ .has_track_name = true }));
    try testing.expectEqual(raw.CLAP_TRACK_INFO_HAS_TRACK_COLOR, @backingInt(Flags{ .has_track_color = true }));
    try testing.expectEqual(raw.CLAP_TRACK_INFO_HAS_AUDIO_CHANNEL, @backingInt(Flags{ .has_audio_channel = true }));
    try testing.expectEqual(raw.CLAP_TRACK_INFO_IS_FOR_RETURN_TRACK, @backingInt(Flags{ .is_for_return_track = true }));
    try testing.expectEqual(raw.CLAP_TRACK_INFO_IS_FOR_BUS, @backingInt(Flags{ .is_for_bus = true }));
    try testing.expectEqual(raw.CLAP_TRACK_INFO_IS_FOR_MASTER, @backingInt(Flags{ .is_for_master = true }));
}
