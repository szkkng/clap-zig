const abi = @import("../abi.zig");
const clap = @import("clap_zig");
const raw = @import("raw");
const testing = @import("std").testing;

comptime {
    const state = clap.ext.state;
    abi.assertStruct(state.Plugin, raw.clap_plugin_state_t);
    abi.assertFnPtr(@FieldType(state.Plugin, "save"), @FieldType(raw.clap_plugin_state_t, "save"));
    abi.assertFnPtr(@FieldType(state.Plugin, "load"), @FieldType(raw.clap_plugin_state_t, "load"));
    abi.assertStruct(state.Host, raw.clap_host_state_t);
    abi.assertFnPtr(@FieldType(state.Host, "markDirty"), @FieldType(raw.clap_host_state_t, "mark_dirty"));
}

test "state identifier" {
    try testing.expectEqualStrings(raw.CLAP_EXT_STATE[0..], clap.ext.state.id);
}
