const clap = @import("clap_zig");
const raw = @import("raw");
const testing = @import("std").testing;

test "state identifier" {
    try testing.expectEqualStrings(raw.CLAP_EXT_STATE[0..], clap.ext.state.id);
}
