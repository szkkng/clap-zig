const abi = @import("../abi.zig");
const clap = @import("clap_zig");
const raw = @import("raw");
const testing = @import("std").testing;

comptime {
    const Host = clap.ext.event_registry.Host;
    abi.assertStruct(Host, raw.clap_host_event_registry_t);
    abi.assertFnPtr(@FieldType(Host, "query"), @FieldType(raw.clap_host_event_registry_t, "query"));
}

test "event registry identifier" {
    try testing.expectEqualStrings(raw.CLAP_EXT_EVENT_REGISTRY[0..], clap.ext.event_registry.id);
}
