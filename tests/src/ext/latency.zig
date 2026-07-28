const abi = @import("../abi.zig");
const clap = @import("clap_zig");
const raw = @import("raw");
const testing = @import("std").testing;

comptime {
    const latency = clap.ext.latency;
    abi.assertStruct(latency.Plugin, raw.clap_plugin_latency_t);
    abi.assertFnPtr(@FieldType(latency.Plugin, "get"), @FieldType(raw.clap_plugin_latency_t, "get"));
    abi.assertStruct(latency.Host, raw.clap_host_latency_t);
    abi.assertFnPtr(@FieldType(latency.Host, "changed"), @FieldType(raw.clap_host_latency_t, "changed"));
}

test "latency identifier" {
    try testing.expectEqualStrings(raw.CLAP_EXT_LATENCY[0..], clap.ext.latency.id);
}
