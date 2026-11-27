const abi = @import("../abi.zig");
const clap = @import("clap_zig");
const raw = @import("raw");

comptime {
    const latency = clap.ext.latency;
    abi.assertCompatible(raw.clap_plugin_latency_t, latency.Plugin);
    abi.assertCompatible(raw.clap_host_latency_t, latency.Host);
}

test "latency identifier" {
    try abi.expectEqualCString(&raw.CLAP_EXT_LATENCY, clap.ext.latency.id);
}
