const clap = @import("clap_zig");
const raw = @import("raw");
const testing = @import("std").testing;

test "event registry identifier" {
    try testing.expectEqualStrings(raw.CLAP_EXT_EVENT_REGISTRY[0..], clap.ext.event_registry.id);
}
