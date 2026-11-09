const ClapPlugin = @import("../plugin.zig").Plugin;
const ClapHost = @import("../host.zig").Host;

pub const id = "clap.posix-fd-support";

pub const Flags = packed struct(u32) {
    read: bool = false,
    write: bool = false,
    @"error": bool = false,
    _: u29 = 0,
};

pub const Plugin = extern struct {
    onFd: *const fn (plugin: *const ClapPlugin, fd: c_int, flags: Flags) callconv(.c) void,
};

pub const Host = extern struct {
    registerFd: *const fn (host: *const ClapHost, fd: c_int, flags: Flags) callconv(.c) bool,
    modifyFd: *const fn (host: *const ClapHost, fd: c_int, flags: Flags) callconv(.c) bool,
    unregisterFd: *const fn (host: *const ClapHost, fd: c_int) callconv(.c) bool,
};
