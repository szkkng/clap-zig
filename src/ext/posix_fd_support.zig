const root = @import("../root.zig");

pub const id = "clap.posix-fd-support";

pub const Flags = packed struct(u32) {
    read: bool = false,
    write: bool = false,
    @"error": bool = false,
    _: u29 = 0,
};

pub const Plugin = extern struct {
    onFd: *const fn (plugin: *const root.Plugin, fd: c_int, flags: Flags) callconv(.c) void,
};

pub const Host = extern struct {
    registerFd: *const fn (host: *const root.Host, fd: c_int, flags: Flags) callconv(.c) bool,
    modifyFd: *const fn (host: *const root.Host, fd: c_int, flags: Flags) callconv(.c) bool,
    unregisterFd: *const fn (host: *const root.Host, fd: c_int) callconv(.c) bool,
};
