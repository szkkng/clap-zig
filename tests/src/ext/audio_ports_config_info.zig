const abi = @import("../abi.zig");
const clap = @import("clap_zig");
const raw = @import("raw");
const testing = @import("std").testing;

comptime {
    abi.assertCompatible(raw.clap_plugin_audio_ports_config_info_t, clap.ext.audio_ports_config_info.Plugin);
}

test "audio port config info identifiers" {
    try testing.expectEqualStrings(raw.CLAP_EXT_AUDIO_PORTS_CONFIG_INFO[0..], clap.ext.audio_ports_config_info.id);
    try testing.expectEqualStrings(raw.CLAP_EXT_AUDIO_PORTS_CONFIG_INFO_COMPAT[0..], clap.ext.audio_ports_config_info.id_compat);
}
