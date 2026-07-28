const abi = @import("../abi.zig");
const clap = @import("clap_zig");
const raw = @import("raw");
const testing = @import("std").testing;

comptime {
    const Factory = clap.factory.plugin.Factory;
    abi.assertStruct(Factory, raw.clap_plugin_factory_t);
    abi.assertFnPtr(@FieldType(Factory, "getPluginCount"), @FieldType(raw.clap_plugin_factory_t, "get_plugin_count"));
    abi.assertFnPtr(@FieldType(Factory, "getPluginDescriptor"), @FieldType(raw.clap_plugin_factory_t, "get_plugin_descriptor"));
    abi.assertFnPtr(@FieldType(Factory, "createPlugin"), @FieldType(raw.clap_plugin_factory_t, "create_plugin"));
}

test "plugin factory id" {
    try testing.expectEqualStrings(raw.CLAP_PLUGIN_FACTORY_ID[0..], clap.factory.plugin.Factory.id);
}
