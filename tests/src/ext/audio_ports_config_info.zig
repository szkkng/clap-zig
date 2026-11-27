const abi = @import("../abi.zig");
const clap = @import("clap_zig");
const raw = @import("raw");

comptime {
    abi.assertCompatible(raw.clap_plugin_audio_ports_config_info_t, clap.ext.audio_ports_config_info.Plugin);
}

test "audio port config info identifiers" {
    try abi.expectEqualCString(&raw.CLAP_EXT_AUDIO_PORTS_CONFIG_INFO, clap.ext.audio_ports_config_info.id);
    try abi.expectEqualCString(&raw.CLAP_EXT_AUDIO_PORTS_CONFIG_INFO_COMPAT, clap.ext.audio_ports_config_info.id_compat);
}
