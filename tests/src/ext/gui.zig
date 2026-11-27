const abi = @import("../abi.zig");
const clap = @import("clap_zig");
const raw = @import("raw");

comptime {
    const gui = clap.ext.gui;
    abi.assertCompatible(raw.clap_window_t, gui.Window);
    abi.assertCompatible(raw.clap_gui_resize_hints_t, gui.ResizeHints);
    abi.assertCompatible(raw.clap_plugin_gui_t, gui.Plugin);
    abi.assertCompatible(raw.clap_host_gui_t, gui.Host);
}

test "gui identifiers" {
    try abi.expectEqualCString(&raw.CLAP_EXT_GUI, clap.ext.gui.id);
    try abi.expectEqualCString(&raw.CLAP_WINDOW_API_WIN32, clap.ext.gui.window_api.win32);
    try abi.expectEqualCString(&raw.CLAP_WINDOW_API_COCOA, clap.ext.gui.window_api.cocoa);
    try abi.expectEqualCString(&raw.CLAP_WINDOW_API_UIKIT, clap.ext.gui.window_api.uikit);
    try abi.expectEqualCString(&raw.CLAP_WINDOW_API_X11, clap.ext.gui.window_api.x11);
    try abi.expectEqualCString(&raw.CLAP_WINDOW_API_WAYLAND, clap.ext.gui.window_api.wayland);
}
