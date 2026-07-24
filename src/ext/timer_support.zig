const root = @import("../root.zig");
const Id = root.Id;

pub const id = "clap.timer-support";

pub const Plugin = extern struct {
    onTimer: *const fn (plugin: *const root.Plugin, timer_id: Id) callconv(.c) void,
};

pub const Host = extern struct {
    registerTimer: *const fn (host: *const root.Host, period_ms: u32, timer_id: *Id) callconv(.c) bool,
    unregisterTimer: *const fn (host: *const root.Host, timer_id: Id) callconv(.c) bool,
};
