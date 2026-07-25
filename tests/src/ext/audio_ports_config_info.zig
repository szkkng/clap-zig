const clap = @import("clap_zig");
const raw = @import("raw");
const testing = @import("std").testing;

test "audio port config info identifiers" {
    try testing.expectEqualStrings(raw.CLAP_EXT_AUDIO_PORTS_CONFIG_INFO[0..], clap.ext.audio_ports_config_info.id);
    try testing.expectEqualStrings(raw.CLAP_EXT_AUDIO_PORTS_CONFIG_INFO_COMPAT[0..], clap.ext.audio_ports_config_info.id_compat);
}
