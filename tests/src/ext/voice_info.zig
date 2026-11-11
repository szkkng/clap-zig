const abi = @import("../abi.zig");
const clap = @import("clap_zig");
const raw = @import("raw");
const testing = @import("std").testing;

comptime {
    const voice_info = clap.ext.voice_info;
    abi.assertCompatible(raw.clap_voice_info_t, voice_info.Info);
    abi.assertCompatible(raw.clap_plugin_voice_info_t, voice_info.Plugin);
    abi.assertCompatible(raw.clap_host_voice_info_t, voice_info.Host);
}

test "voice info identifier" {
    try testing.expectEqualStrings(raw.CLAP_EXT_VOICE_INFO[0..], clap.ext.voice_info.id);
}

test "voice info flags" {
    const Flags = clap.ext.voice_info.Info.Flags;
    try testing.expectEqual(
        @as(u64, @intCast(raw.CLAP_VOICE_INFO_SUPPORTS_OVERLAPPING_NOTES)),
        @backingInt(Flags{ .supports_overlapping_notes = true }),
    );
}
