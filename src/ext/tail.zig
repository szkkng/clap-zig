const ClapPlugin = @import("../plugin.zig").Plugin;
const ClapHost = @import("../host.zig").Host;

pub const id = "clap.tail";

pub const Plugin = extern struct {
    get: *const fn (plugin: *const ClapPlugin) callconv(.c) u32,
};

pub const Host = extern struct {
    changed: *const fn (host: *const ClapHost) callconv(.c) void,
};
