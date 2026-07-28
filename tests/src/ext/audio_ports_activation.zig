const abi = @import("../abi.zig");
const clap = @import("clap_zig");
const raw = @import("raw");
const testing = @import("std").testing;

comptime {
    const Plugin = clap.ext.audio_ports_activation.Plugin;
    abi.assertStruct(Plugin, raw.clap_plugin_audio_ports_activation_t);
    abi.assertFnPtr(@FieldType(Plugin, "canActivateWhileProcessing"), @FieldType(raw.clap_plugin_audio_ports_activation_t, "can_activate_while_processing"));
    abi.assertFnPtr(@FieldType(Plugin, "setActive"), @FieldType(raw.clap_plugin_audio_ports_activation_t, "set_active"));
}

test "audio port activation identifiers" {
    try testing.expectEqualStrings(raw.CLAP_EXT_AUDIO_PORTS_ACTIVATION[0..], clap.ext.audio_ports_activation.id);
    try testing.expectEqualStrings(raw.CLAP_EXT_AUDIO_PORTS_ACTIVATION_COMPAT[0..], clap.ext.audio_ports_activation.id_compat);
}
