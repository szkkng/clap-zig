const abi = @import("../abi.zig");
const clap = @import("clap_zig");
const raw = @import("raw");

comptime {
    abi.assertCompatible(raw.clap_host_event_registry_t, clap.ext.event_registry.Host);
}

test "event registry identifier" {
    try abi.expectEqualCString(&raw.CLAP_EXT_EVENT_REGISTRY, clap.ext.event_registry.id);
}
