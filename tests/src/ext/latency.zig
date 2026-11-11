const abi = @import("../abi.zig");
const clap = @import("clap_zig");
const raw = @import("raw");
const testing = @import("std").testing;

comptime {
    const latency = clap.ext.latency;
    abi.assertCompatible(raw.clap_plugin_latency_t, latency.Plugin);
    abi.assertCompatible(raw.clap_host_latency_t, latency.Host);
}

test "latency identifier" {
    try testing.expectEqualStrings(raw.CLAP_EXT_LATENCY[0..], clap.ext.latency.id);
}
