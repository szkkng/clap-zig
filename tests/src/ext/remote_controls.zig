const clap = @import("clap_zig");
const raw = @import("raw");
const testing = @import("std").testing;

test "remote controls identifier" {
    try testing.expectEqualStrings(raw.CLAP_EXT_REMOTE_CONTROLS[0..], clap.ext.remote_controls.id);
    try testing.expectEqualStrings(raw.CLAP_EXT_REMOTE_CONTROLS_COMPAT[0..], clap.ext.remote_controls.id_compat);
}
