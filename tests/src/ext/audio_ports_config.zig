const abi = @import("../abi.zig");
const clap = @import("clap_zig");
const raw = @import("raw");
const testing = @import("std").testing;

comptime {
    const audio_ports_config = clap.ext.audio_ports_config;
    abi.assertCompatible(raw.clap_audio_ports_config_t, audio_ports_config.Config);
    abi.assertCompatible(raw.clap_plugin_audio_ports_config_t, audio_ports_config.Plugin);
    abi.assertCompatible(raw.clap_host_audio_ports_config_t, audio_ports_config.Host);
}

test "audio port config identifier" {
    try testing.expectEqualStrings(raw.CLAP_EXT_AUDIO_PORTS_CONFIG[0..], clap.ext.audio_ports_config.id);
}
