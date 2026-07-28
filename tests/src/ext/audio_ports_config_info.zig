const abi = @import("../abi.zig");
const clap = @import("clap_zig");
const raw = @import("raw");
const testing = @import("std").testing;

comptime {
    const Plugin = clap.ext.audio_ports_config_info.Plugin;
    abi.assertStruct(Plugin, raw.clap_plugin_audio_ports_config_info_t);
    abi.assertFnPtr(@FieldType(Plugin, "currentConfig"), @FieldType(raw.clap_plugin_audio_ports_config_info_t, "current_config"));
    abi.assertFnPtr(@FieldType(Plugin, "get"), @FieldType(raw.clap_plugin_audio_ports_config_info_t, "get"));
}

test "audio port config info identifiers" {
    try testing.expectEqualStrings(raw.CLAP_EXT_AUDIO_PORTS_CONFIG_INFO[0..], clap.ext.audio_ports_config_info.id);
    try testing.expectEqualStrings(raw.CLAP_EXT_AUDIO_PORTS_CONFIG_INFO_COMPAT[0..], clap.ext.audio_ports_config_info.id_compat);
}
