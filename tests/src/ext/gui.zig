const abi = @import("../abi.zig");
const clap = @import("clap_zig");
const raw = @import("raw");
const testing = @import("std").testing;

comptime {
    const gui = clap.ext.gui;
    abi.assertStruct(gui.Window, raw.clap_window_t);
    abi.assertStruct(gui.ResizeHints, raw.clap_gui_resize_hints_t);
    abi.assertStruct(gui.Plugin, raw.clap_plugin_gui_t);
    abi.assertFnPtr(@FieldType(gui.Plugin, "isApiSupported"), @FieldType(raw.clap_plugin_gui_t, "is_api_supported"));
    abi.assertFnPtr(@FieldType(gui.Plugin, "getPreferredApi"), @FieldType(raw.clap_plugin_gui_t, "get_preferred_api"));
    abi.assertFnPtr(@FieldType(gui.Plugin, "create"), @FieldType(raw.clap_plugin_gui_t, "create"));
    abi.assertFnPtr(@FieldType(gui.Plugin, "destroy"), @FieldType(raw.clap_plugin_gui_t, "destroy"));
    abi.assertFnPtr(@FieldType(gui.Plugin, "setScale"), @FieldType(raw.clap_plugin_gui_t, "set_scale"));
    abi.assertFnPtr(@FieldType(gui.Plugin, "getSize"), @FieldType(raw.clap_plugin_gui_t, "get_size"));
    abi.assertFnPtr(@FieldType(gui.Plugin, "canResize"), @FieldType(raw.clap_plugin_gui_t, "can_resize"));
    abi.assertFnPtr(@FieldType(gui.Plugin, "getResizeHints"), @FieldType(raw.clap_plugin_gui_t, "get_resize_hints"));
    abi.assertFnPtr(@FieldType(gui.Plugin, "adjustSize"), @FieldType(raw.clap_plugin_gui_t, "adjust_size"));
    abi.assertFnPtr(@FieldType(gui.Plugin, "setSize"), @FieldType(raw.clap_plugin_gui_t, "set_size"));
    abi.assertFnPtr(@FieldType(gui.Plugin, "setParent"), @FieldType(raw.clap_plugin_gui_t, "set_parent"));
    abi.assertFnPtr(@FieldType(gui.Plugin, "setTransient"), @FieldType(raw.clap_plugin_gui_t, "set_transient"));
    abi.assertFnPtr(@FieldType(gui.Plugin, "suggestTitle"), @FieldType(raw.clap_plugin_gui_t, "suggest_title"));
    abi.assertFnPtr(@FieldType(gui.Plugin, "show"), @FieldType(raw.clap_plugin_gui_t, "show"));
    abi.assertFnPtr(@FieldType(gui.Plugin, "hide"), @FieldType(raw.clap_plugin_gui_t, "hide"));
    abi.assertStruct(gui.Host, raw.clap_host_gui_t);
    abi.assertFnPtr(@FieldType(gui.Host, "resizeHintsChanged"), @FieldType(raw.clap_host_gui_t, "resize_hints_changed"));
    abi.assertFnPtr(@FieldType(gui.Host, "requestResize"), @FieldType(raw.clap_host_gui_t, "request_resize"));
    abi.assertFnPtr(@FieldType(gui.Host, "requestShow"), @FieldType(raw.clap_host_gui_t, "request_show"));
    abi.assertFnPtr(@FieldType(gui.Host, "requestHide"), @FieldType(raw.clap_host_gui_t, "request_hide"));
    abi.assertFnPtr(@FieldType(gui.Host, "closed"), @FieldType(raw.clap_host_gui_t, "closed"));
}

test "gui identifiers" {
    try testing.expectEqualStrings(raw.CLAP_EXT_GUI[0..], clap.ext.gui.id);
    try testing.expectEqualStrings(raw.CLAP_WINDOW_API_WIN32[0..], clap.ext.gui.window_api.win32);
    try testing.expectEqualStrings(raw.CLAP_WINDOW_API_COCOA[0..], clap.ext.gui.window_api.cocoa);
    try testing.expectEqualStrings(raw.CLAP_WINDOW_API_UIKIT[0..], clap.ext.gui.window_api.uikit);
    try testing.expectEqualStrings(raw.CLAP_WINDOW_API_X11[0..], clap.ext.gui.window_api.x11);
    try testing.expectEqualStrings(raw.CLAP_WINDOW_API_WAYLAND[0..], clap.ext.gui.window_api.wayland);
}
