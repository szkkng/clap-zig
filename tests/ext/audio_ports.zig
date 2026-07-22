const clap = @import("clap_zig");
const raw = @import("raw");
const testing = @import("std").testing;

test "audio port identifiers" {
    try testing.expectEqualStrings(clap.ext_audio_ports, raw.CLAP_EXT_AUDIO_PORTS[0..]);
    try testing.expectEqualStrings(clap.port_mono, raw.CLAP_PORT_MONO[0..]);
    try testing.expectEqualStrings(clap.port_stereo, raw.CLAP_PORT_STEREO[0..]);
}
