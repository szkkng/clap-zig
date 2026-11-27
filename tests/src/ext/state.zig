const abi = @import("../abi.zig");
const clap = @import("clap_zig");
const raw = @import("raw");

comptime {
    const state = clap.ext.state;
    abi.assertCompatible(raw.clap_plugin_state_t, state.Plugin);
    abi.assertCompatible(raw.clap_host_state_t, state.Host);
}

test "state identifier" {
    try abi.expectEqualCString(&raw.CLAP_EXT_STATE, clap.ext.state.id);
}
