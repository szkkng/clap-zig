const clap = @import("clap_zig");
const raw = @import("raw");
const testing = @import("std").testing;

test "gui identifiers" {
    try testing.expectEqualStrings(raw.CLAP_EXT_GUI[0..], clap.ext.gui.id);
    try testing.expectEqualStrings(raw.CLAP_WINDOW_API_WIN32[0..], clap.ext.gui.window_api.win32);
    try testing.expectEqualStrings(raw.CLAP_WINDOW_API_COCOA[0..], clap.ext.gui.window_api.cocoa);
    try testing.expectEqualStrings(raw.CLAP_WINDOW_API_UIKIT[0..], clap.ext.gui.window_api.uikit);
    try testing.expectEqualStrings(raw.CLAP_WINDOW_API_X11[0..], clap.ext.gui.window_api.x11);
    try testing.expectEqualStrings(raw.CLAP_WINDOW_API_WAYLAND[0..], clap.ext.gui.window_api.wayland);
}
