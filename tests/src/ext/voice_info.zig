const abi = @import("../abi.zig");
const clap = @import("clap_zig");
const raw = @import("raw");
const testing = @import("std").testing;

comptime {
    const voice_info = clap.ext.voice_info;
    abi.assertStruct(voice_info.Info, raw.clap_voice_info_t);
    abi.assertStruct(voice_info.Plugin, raw.clap_plugin_voice_info_t);
    abi.assertFnPtr(@FieldType(voice_info.Plugin, "get"), @FieldType(raw.clap_plugin_voice_info_t, "get"));
    abi.assertStruct(voice_info.Host, raw.clap_host_voice_info_t);
    abi.assertFnPtr(@FieldType(voice_info.Host, "changed"), @FieldType(raw.clap_host_voice_info_t, "changed"));
}

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
