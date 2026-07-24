const clap = @import("clap_zig");
const raw = @import("raw");
const testing = @import("std").testing;

test "audio port config identifier" {
    try testing.expectEqualStrings(raw.CLAP_EXT_AUDIO_PORTS_CONFIG[0..], clap.ext.audio_ports_config.id);
}
