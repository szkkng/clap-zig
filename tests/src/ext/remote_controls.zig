const abi = @import("../abi.zig");
const clap = @import("clap_zig");
const raw = @import("raw");
const testing = @import("std").testing;

comptime {
    const remote_controls = clap.ext.remote_controls;
    abi.assertStruct(remote_controls.Page, raw.clap_remote_controls_page_t);
    abi.assertStruct(remote_controls.Plugin, raw.clap_plugin_remote_controls_t);
    abi.assertFnPtr(@FieldType(remote_controls.Plugin, "count"), @FieldType(raw.clap_plugin_remote_controls_t, "count"));
    abi.assertFnPtr(@FieldType(remote_controls.Plugin, "get"), @FieldType(raw.clap_plugin_remote_controls_t, "get"));
    abi.assertStruct(remote_controls.Host, raw.clap_host_remote_controls_t);
    abi.assertFnPtr(@FieldType(remote_controls.Host, "changed"), @FieldType(raw.clap_host_remote_controls_t, "changed"));
    abi.assertFnPtr(@FieldType(remote_controls.Host, "suggestPage"), @FieldType(raw.clap_host_remote_controls_t, "suggest_page"));
}

test "remote controls identifier" {
    try testing.expectEqualStrings(raw.CLAP_EXT_REMOTE_CONTROLS[0..], clap.ext.remote_controls.id);
    try testing.expectEqualStrings(raw.CLAP_EXT_REMOTE_CONTROLS_COMPAT[0..], clap.ext.remote_controls.id_compat);
}
