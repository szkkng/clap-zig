const abi = @import("../abi.zig");
const clap = @import("clap_zig");
const raw = @import("raw");
const testing = @import("std").testing;

comptime {
    const configurable_audio_ports = clap.ext.configurable_audio_ports;
    abi.assertCompatible(raw.clap_audio_port_configuration_request, configurable_audio_ports.ConfigurationRequest);
    abi.assertCompatible(raw.clap_plugin_configurable_audio_ports_t, configurable_audio_ports.Plugin);
}

test "audio port config info identifiers" {
    try testing.expectEqualStrings(raw.CLAP_EXT_CONFIGURABLE_AUDIO_PORTS[0..], clap.ext.configurable_audio_ports.id);
    try testing.expectEqualStrings(raw.CLAP_EXT_CONFIGURABLE_AUDIO_PORTS_COMPAT[0..], clap.ext.configurable_audio_ports.id_compat);
}
