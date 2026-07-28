const abi = @import("abi.zig");
const clap = @import("clap_zig");
const raw = @import("raw");

comptime {
    abi.assertStruct(clap.UniversalPluginId, raw.clap_universal_plugin_id_t);
}
