const ClapPlugin = @import("../plugin.zig").Plugin;
const ClapHost = @import("../host.zig").Host;
const name_size = @import("../string_sizes.zig").name_size;

pub const id = "clap.note-name";

pub const NoteName = extern struct {
    name: [name_size]u8,
    port: i16,
    key: i16,
    channel: i16,
};

pub const Plugin = extern struct {
    count: *const fn (plugin: *const ClapPlugin) callconv(.c) u32,
    get: *const fn (plugin: *const ClapPlugin, index: u32, note_name: *NoteName) callconv(.c) bool,
};

pub const Host = extern struct {
    changed: *const fn (host: *const ClapHost) callconv(.c) void,
};
