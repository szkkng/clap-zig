const root = @import("../root.zig");

pub const id = "clap.render";

pub const Mode = enum(i32) {
    realtime = 0,
    offline = 1,
};

pub const Plugin = extern struct {
    hasHardRealtimeRequirement: *const fn (plugin: *const root.Plugin) callconv(.c) bool,
    set: *const fn (plugin: *const root.Plugin, mode: Mode) callconv(.c) bool,
};
