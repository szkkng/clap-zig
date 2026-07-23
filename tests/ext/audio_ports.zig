const clap = @import("clap_zig");
const raw = @import("raw");
const testing = @import("std").testing;

test "audio port identifiers" {
    try testing.expectEqualStrings(raw.CLAP_EXT_AUDIO_PORTS[0..], clap.ext.audio_ports.id);
    try testing.expectEqualStrings(raw.CLAP_PORT_MONO[0..], clap.ext.audio_ports.port_type.mono);
    try testing.expectEqualStrings(raw.CLAP_PORT_STEREO[0..], clap.ext.audio_ports.port_type.stereo);
}

test "audio port info flags" {
    const Flags = clap.ext.audio_ports.Info.Flags;
    try expectFlag(Flags, raw.CLAP_AUDIO_PORT_IS_MAIN, Flags{ .is_main = true });
    try expectFlag(Flags, raw.CLAP_AUDIO_PORT_SUPPORTS_64BITS, Flags{ .supports_64bits = true });
    try expectFlag(Flags, raw.CLAP_AUDIO_PORT_PREFERS_64BITS, Flags{ .prefers_64bits = true });
    try expectFlag(Flags, raw.CLAP_AUDIO_PORT_REQUIRES_COMMON_SAMPLE_SIZE, Flags{ .requires_common_sample_size = true });
}

test "audio port rescan flags" {
    const Flags = clap.ext.audio_ports.HostPorts.RescanFlags;
    try expectFlag(Flags, raw.CLAP_AUDIO_PORTS_RESCAN_NAMES, Flags{ .names = true });
    try expectFlag(Flags, raw.CLAP_AUDIO_PORTS_RESCAN_FLAGS, Flags{ .flags = true });
    try expectFlag(Flags, raw.CLAP_AUDIO_PORTS_RESCAN_CHANNEL_COUNT, Flags{ .channel_count = true });
    try expectFlag(Flags, raw.CLAP_AUDIO_PORTS_RESCAN_PORT_TYPE, Flags{ .port_type = true });
    try expectFlag(Flags, raw.CLAP_AUDIO_PORTS_RESCAN_IN_PLACE_PAIR, Flags{ .in_place_pair = true });
    try expectFlag(Flags, raw.CLAP_AUDIO_PORTS_RESCAN_LIST, Flags{ .list = true });
}

fn expectFlag(comptime Flags: type, expected: anytype, actual: Flags) !void {
    try testing.expectEqual(
        @as(u32, @intCast(expected)),
        @as(u32, @bitCast(actual)),
    );
}
