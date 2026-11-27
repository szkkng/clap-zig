const abi = @import("../abi.zig");
const clap = @import("clap_zig");
const raw = @import("raw");

comptime {
    abi.assertCompatible(raw.clap_plugin_factory_t, clap.factory.plugin.Factory);
}

test "plugin factory id" {
    try abi.expectEqualCString(&raw.CLAP_PLUGIN_FACTORY_ID, clap.factory.plugin.id);
}
