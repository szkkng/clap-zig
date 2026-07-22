const std = @import("std");
const version = @import("version.zig");
const Version = version.Version;

pub const Entry = extern struct {
    clap_version: Version = .current,
    init: *const fn (plugin_path: [*:0]const u8) callconv(.c) bool,
    deinit: *const fn () callconv(.c) void,
    getFactory: *const fn (factory_id: [*:0]const u8) callconv(.c) ?*const anyopaque,
};
