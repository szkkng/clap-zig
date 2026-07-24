const root = @import("../root.zig");

pub const id = "clap.tail";

pub const Plugin = extern struct {
    get: *const fn (plugin: *const root.Plugin) callconv(.c) u32,
};

pub const Host = extern struct {
    changed: *const fn (host: *const root.Host) callconv(.c) void,
};
