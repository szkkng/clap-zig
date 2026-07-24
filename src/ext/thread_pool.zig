const root = @import("../root.zig");

pub const id = "clap.thread-pool";

pub const Plugin = extern struct {
    exec: *const fn (plugin: *const root.Plugin, task_index: u32) callconv(.c) void,
};

pub const Host = extern struct {
    requestExec: *const fn (host: *const root.Host, num_tasks: u32) callconv(.c) bool,
};
