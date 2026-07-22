const testing = @import("std").testing;
const clap = @import("clap_zig");
const raw = @import("raw");
const Factory = clap.plugin.Factory;

test "plugin factory id" {
    try testing.expectEqualStrings(raw.CLAP_PLUGIN_FACTORY_ID[0..], Factory.id);
}
