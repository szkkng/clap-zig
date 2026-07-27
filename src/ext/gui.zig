const root = @import("../root.zig");

pub const id = "clap.gui";

pub const window_api = struct {
    pub const win32 = "win32";
    pub const cocoa = "cocoa";
    pub const uikit = "uikit";
    pub const x11 = "x11";
    pub const wayland = "wayland";
};

pub const Window = extern struct {
    api: [*:0]const u8,
    specific: extern union {
        cocoa: ?*anyopaque,
        uikit: ?*anyopaque,
        x11: c_ulong,
        win32: ?*anyopaque,
        ptr: ?*anyopaque,
    },
};

pub const ResizeHints = extern struct {
    can_resize_horizontally: bool,
    can_resize_vertically: bool,
    preserve_aspect_ratio: bool,
    aspect_ratio_width: u32,
    aspect_ratio_height: u32,
};

pub const Plugin = extern struct {
    isApiSupported: *const fn (plugin: *const root.Plugin, api: [*:0]const u8, is_floating: bool) callconv(.c) bool,
    getPreferredApi: *const fn (plugin: *const root.Plugin, api: *[*:0]const u8, is_floating: *bool) callconv(.c) bool,
    create: *const fn (plugin: *const root.Plugin, api: ?[*:0]const u8, is_floating: bool) callconv(.c) bool,
    destroy: *const fn (plugin: *const root.Plugin) callconv(.c) void,
    setScale: *const fn (plugin: *const root.Plugin, scale: f64) callconv(.c) bool,
    getSize: *const fn (plugin: *const root.Plugin, width: *u32, height: *u32) callconv(.c) bool,
    canResize: *const fn (plugin: *const root.Plugin) callconv(.c) bool,
    getResizeHints: *const fn (plugin: *const root.Plugin, hints: *ResizeHints) callconv(.c) bool,
    adjustSize: *const fn (plugin: *const root.Plugin, width: *u32, height: *u32) callconv(.c) bool,
    setSize: *const fn (plugin: *const root.Plugin, width: u32, height: u32) callconv(.c) bool,
    setParent: *const fn (plugin: *const root.Plugin, window: *const Window) callconv(.c) bool,
    setTransient: *const fn (plugin: *const root.Plugin, window: *const Window) callconv(.c) bool,
    suggestTitle: *const fn (plugin: *const root.Plugin, title: [*:0]const u8) callconv(.c) void,
    show: *const fn (plugin: *const root.Plugin) callconv(.c) bool,
    hide: *const fn (plugin: *const root.Plugin) callconv(.c) bool,
};

pub const Host = extern struct {
    resizeHintsChanged: *const fn (host: *const root.Host) callconv(.c) void,
    requestResize: *const fn (host: *const root.Host, width: u32, height: u32) callconv(.c) bool,
    requestShow: *const fn (host: *const root.Host) callconv(.c) bool,
    requestHide: *const fn (host: *const root.Host) callconv(.c) bool,
    closed: *const fn (host: *const root.Host, was_destroyed: bool) callconv(.c) void,
};
