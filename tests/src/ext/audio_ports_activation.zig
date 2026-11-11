const abi = @import("../abi.zig");
const clap = @import("clap_zig");
const raw = @import("raw");
const testing = @import("std").testing;

comptime {
    abi.assertCompatible(raw.clap_plugin_audio_ports_activation_t, clap.ext.audio_ports_activation.Plugin);
}

test "audio port activation identifiers" {
    try testing.expectEqualStrings(raw.CLAP_EXT_AUDIO_PORTS_ACTIVATION[0..], clap.ext.audio_ports_activation.id);
    try testing.expectEqualStrings(raw.CLAP_EXT_AUDIO_PORTS_ACTIVATION_COMPAT[0..], clap.ext.audio_ports_activation.id_compat);
}
