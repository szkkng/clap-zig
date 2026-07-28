const abi = @import("../abi.zig");
const clap = @import("clap_zig");
const raw = @import("raw");
const testing = @import("std").testing;

comptime {
    const audio_ports_config = clap.ext.audio_ports_config;
    abi.assertStruct(audio_ports_config.Config, raw.clap_audio_ports_config_t);
    abi.assertStruct(audio_ports_config.Plugin, raw.clap_plugin_audio_ports_config_t);
    abi.assertFnPtr(@FieldType(audio_ports_config.Plugin, "count"), @FieldType(raw.clap_plugin_audio_ports_config_t, "count"));
    abi.assertFnPtr(@FieldType(audio_ports_config.Plugin, "get"), @FieldType(raw.clap_plugin_audio_ports_config_t, "get"));
    abi.assertFnPtr(@FieldType(audio_ports_config.Plugin, "select"), @FieldType(raw.clap_plugin_audio_ports_config_t, "select"));
    abi.assertStruct(audio_ports_config.Host, raw.clap_host_audio_ports_config_t);
    abi.assertFnPtr(@FieldType(audio_ports_config.Host, "rescan"), @FieldType(raw.clap_host_audio_ports_config_t, "rescan"));
}

test "audio port config identifier" {
    try testing.expectEqualStrings(raw.CLAP_EXT_AUDIO_PORTS_CONFIG[0..], clap.ext.audio_ports_config.id);
}
