const clap = @import("clap_zig");
const raw = @import("raw");
const testing = @import("std").testing;

test "preset load identifier" {
    try testing.expectEqualStrings(raw.CLAP_EXT_PRESET_LOAD[0..], clap.ext.preset_load.id);
    try testing.expectEqualStrings(raw.CLAP_EXT_PRESET_LOAD_COMPAT[0..], clap.ext.preset_load.id_compat);
}
