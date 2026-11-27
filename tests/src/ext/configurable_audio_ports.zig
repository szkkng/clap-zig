const abi = @import("../abi.zig");
const clap = @import("clap_zig");
const raw = @import("raw");

comptime {
    const configurable_audio_ports = clap.ext.configurable_audio_ports;
    abi.assertCompatible(raw.clap_audio_port_configuration_request, configurable_audio_ports.ConfigurationRequest);
    abi.assertCompatible(raw.clap_plugin_configurable_audio_ports_t, configurable_audio_ports.Plugin);
}

test "audio port config info identifiers" {
    try abi.expectEqualCString(&raw.CLAP_EXT_CONFIGURABLE_AUDIO_PORTS, clap.ext.configurable_audio_ports.id);
    try abi.expectEqualCString(&raw.CLAP_EXT_CONFIGURABLE_AUDIO_PORTS_COMPAT, clap.ext.configurable_audio_ports.id_compat);
}
