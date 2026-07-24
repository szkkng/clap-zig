const clap = @import("clap_zig");
const raw = @import("raw");
const testing = @import("std").testing;

test "tail identifier" {
    try testing.expectEqualStrings(raw.CLAP_EXT_TAIL[0..], clap.ext.tail.id);
}
