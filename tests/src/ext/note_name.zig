const clap = @import("clap_zig");
const raw = @import("raw");
const testing = @import("std").testing;

test "note name identifier" {
    try testing.expectEqualStrings(raw.CLAP_EXT_NOTE_NAME[0..], clap.ext.note_name.id);
}
