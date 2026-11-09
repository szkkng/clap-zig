const ClapPlugin = @import("../plugin.zig").Plugin;

pub const id = "clap.render";

pub const Mode = enum(i32) {
    realtime = 0,
    offline = 1,
    _,
};

pub const Plugin = extern struct {
    hasHardRealtimeRequirement: *const fn (plugin: *const ClapPlugin) callconv(.c) bool,
    set: *const fn (plugin: *const ClapPlugin, mode: Mode) callconv(.c) bool,
};
