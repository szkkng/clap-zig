const abi = @import("../abi.zig");
const clap = @import("clap_zig");
const raw = @import("raw");
const testing = @import("std").testing;

comptime {
    const state = clap.ext.state;
    abi.assertCompatible(raw.clap_plugin_state_t, state.Plugin);
    abi.assertCompatible(raw.clap_host_state_t, state.Host);
}

test "state identifier" {
    try testing.expectEqualStrings(raw.CLAP_EXT_STATE[0..], clap.ext.state.id);
}
