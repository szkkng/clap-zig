const abi = @import("../abi.zig");
const clap = @import("clap_zig");
const raw = @import("raw");
const testing = @import("std").testing;

comptime {
    const gui = clap.ext.gui;
    abi.assertCompatible(raw.clap_window_t, gui.Window);
    abi.assertCompatible(raw.clap_gui_resize_hints_t, gui.ResizeHints);
    abi.assertCompatible(raw.clap_plugin_gui_t, gui.Plugin);
    abi.assertCompatible(raw.clap_host_gui_t, gui.Host);
}

test "gui identifiers" {
    try testing.expectEqualStrings(raw.CLAP_EXT_GUI[0..], clap.ext.gui.id);
    try testing.expectEqualStrings(raw.CLAP_WINDOW_API_WIN32[0..], clap.ext.gui.window_api.win32);
    try testing.expectEqualStrings(raw.CLAP_WINDOW_API_COCOA[0..], clap.ext.gui.window_api.cocoa);
    try testing.expectEqualStrings(raw.CLAP_WINDOW_API_UIKIT[0..], clap.ext.gui.window_api.uikit);
    try testing.expectEqualStrings(raw.CLAP_WINDOW_API_X11[0..], clap.ext.gui.window_api.x11);
    try testing.expectEqualStrings(raw.CLAP_WINDOW_API_WAYLAND[0..], clap.ext.gui.window_api.wayland);
}
