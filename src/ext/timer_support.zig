const ClapPlugin = @import("../plugin.zig").Plugin;
const ClapHost = @import("../host.zig").Host;
const Id = @import("../id.zig").Id;

pub const id = "clap.timer-support";

pub const Plugin = extern struct {
    onTimer: *const fn (plugin: *const ClapPlugin, timer_id: Id) callconv(.c) void,
};

pub const Host = extern struct {
    registerTimer: *const fn (host: *const ClapHost, period_ms: u32, timer_id: *Id) callconv(.c) bool,
    unregisterTimer: *const fn (host: *const ClapHost, timer_id: Id) callconv(.c) bool,
};
