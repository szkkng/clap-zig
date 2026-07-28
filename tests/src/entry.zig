const abi = @import("abi.zig");
const clap = @import("clap_zig");
const raw = @import("raw");

comptime {
    abi.assertStruct(clap.PluginEntry, raw.clap_plugin_entry_t);
    abi.assertFnPtr(@FieldType(clap.PluginEntry, "init"), @FieldType(raw.clap_plugin_entry_t, "init"));
    abi.assertFnPtr(@FieldType(clap.PluginEntry, "deinit"), @FieldType(raw.clap_plugin_entry_t, "deinit"));
    abi.assertFnPtr(@FieldType(clap.PluginEntry, "getFactory"), @FieldType(raw.clap_plugin_entry_t, "get_factory"));
}
