const abi = @import("../abi.zig");
const clap = @import("clap_zig");
const raw = @import("raw");
const testing = @import("std").testing;

comptime {
    const configurable_audio_ports = clap.ext.configurable_audio_ports;
    abi.assertStruct(configurable_audio_ports.ConfigurationRequest, raw.clap_audio_port_configuration_request);
    abi.assertStruct(configurable_audio_ports.Plugin, raw.clap_plugin_configurable_audio_ports_t);
    abi.assertFnPtr(@FieldType(configurable_audio_ports.Plugin, "canApplyConfiguration"), @FieldType(raw.clap_plugin_configurable_audio_ports_t, "can_apply_configuration"));
    abi.assertFnPtr(@FieldType(configurable_audio_ports.Plugin, "applyConfiguration"), @FieldType(raw.clap_plugin_configurable_audio_ports_t, "apply_configuration"));
}

test "audio port config info identifiers" {
    try testing.expectEqualStrings(raw.CLAP_EXT_CONFIGURABLE_AUDIO_PORTS[0..], clap.ext.configurable_audio_ports.id);
    try testing.expectEqualStrings(raw.CLAP_EXT_CONFIGURABLE_AUDIO_PORTS_COMPAT[0..], clap.ext.configurable_audio_ports.id_compat);
}
