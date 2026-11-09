const ClapPlugin = @import("../plugin.zig").Plugin;
const ClapHost = @import("../host.zig").Host;

pub const id = "clap.thread-pool";

pub const Plugin = extern struct {
    exec: *const fn (plugin: *const ClapPlugin, task_index: u32) callconv(.c) void,
};

pub const Host = extern struct {
    requestExec: *const fn (host: *const ClapHost, num_tasks: u32) callconv(.c) bool,
};
