const abi = @import("../abi.zig");
const clap = @import("clap_zig");
const raw = @import("raw");

comptime {
    const remote_controls = clap.ext.remote_controls;
    abi.assertCompatible(raw.clap_remote_controls_page_t, remote_controls.Page);
    abi.assertCompatible(raw.clap_plugin_remote_controls_t, remote_controls.Plugin);
    abi.assertCompatible(raw.clap_host_remote_controls_t, remote_controls.Host);
}

test "remote controls identifier" {
    try abi.expectEqualCString(&raw.CLAP_EXT_REMOTE_CONTROLS, clap.ext.remote_controls.id);
    try abi.expectEqualCString(&raw.CLAP_EXT_REMOTE_CONTROLS_COMPAT, clap.ext.remote_controls.id_compat);
}
