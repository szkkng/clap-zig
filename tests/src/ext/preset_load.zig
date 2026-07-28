const abi = @import("../abi.zig");
const clap = @import("clap_zig");
const raw = @import("raw");
const testing = @import("std").testing;

comptime {
    const preset_load = clap.ext.preset_load;
    abi.assertStruct(preset_load.Plugin, raw.clap_plugin_preset_load_t);
    abi.assertFnPtr(@FieldType(preset_load.Plugin, "fromLocation"), @FieldType(raw.clap_plugin_preset_load_t, "from_location"));
    abi.assertStruct(preset_load.Host, raw.clap_host_preset_load_t);
    abi.assertFnPtr(@FieldType(preset_load.Host, "onError"), @FieldType(raw.clap_host_preset_load_t, "on_error"));
    abi.assertFnPtr(@FieldType(preset_load.Host, "loaded"), @FieldType(raw.clap_host_preset_load_t, "loaded"));
}

test "preset load identifier" {
    try testing.expectEqualStrings(raw.CLAP_EXT_PRESET_LOAD[0..], clap.ext.preset_load.id);
    try testing.expectEqualStrings(raw.CLAP_EXT_PRESET_LOAD_COMPAT[0..], clap.ext.preset_load.id_compat);
}
