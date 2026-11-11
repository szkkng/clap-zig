const abi = @import("../abi.zig");
const clap = @import("clap_zig");
const raw = @import("raw");
const testing = @import("std").testing;

comptime {
    abi.assertCompatible(raw.clap_plugin_factory_t, clap.factory.plugin.Factory);
}

test "plugin factory id" {
    try testing.expectEqualStrings(raw.CLAP_PLUGIN_FACTORY_ID[0..], clap.factory.plugin.id);
}
