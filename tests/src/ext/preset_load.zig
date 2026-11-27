const abi = @import("../abi.zig");
const clap = @import("clap_zig");
const raw = @import("raw");

comptime {
    const preset_load = clap.ext.preset_load;
    abi.assertCompatible(raw.clap_plugin_preset_load_t, preset_load.Plugin);
    abi.assertCompatible(raw.clap_host_preset_load_t, preset_load.Host);
}

test "preset load identifier" {
    try abi.expectEqualCString(&raw.CLAP_EXT_PRESET_LOAD, clap.ext.preset_load.id);
    try abi.expectEqualCString(&raw.CLAP_EXT_PRESET_LOAD_COMPAT, clap.ext.preset_load.id_compat);
}
