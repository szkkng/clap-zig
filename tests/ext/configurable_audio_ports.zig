const clap = @import("clap_zig");
const raw = @import("raw");
const testing = @import("std").testing;

test "audio port config info identifiers" {
    try testing.expectEqualStrings(raw.CLAP_EXT_CONFIGURABLE_AUDIO_PORTS[0..], clap.ext.configurable_audio_ports.id);
    try testing.expectEqualStrings(raw.CLAP_EXT_CONFIGURABLE_AUDIO_PORTS_COMPAT[0..], clap.ext.configurable_audio_ports.id_compat);
}
