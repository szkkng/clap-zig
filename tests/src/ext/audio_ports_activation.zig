const abi = @import("../abi.zig");
const clap = @import("clap_zig");
const raw = @import("raw");

comptime {
    abi.assertCompatible(raw.clap_plugin_audio_ports_activation_t, clap.ext.audio_ports_activation.Plugin);
}

test "audio port activation identifiers" {
    try abi.expectEqualCString(&raw.CLAP_EXT_AUDIO_PORTS_ACTIVATION, clap.ext.audio_ports_activation.id);
    try abi.expectEqualCString(&raw.CLAP_EXT_AUDIO_PORTS_ACTIVATION_COMPAT, clap.ext.audio_ports_activation.id_compat);
}
