const root = @import("../root.zig");
const name_size = root.name_size;

pub const id = "clap.note-name";

pub const NoteName = extern struct {
    name: [name_size]u8,
    port: i16,
    key: i16,
    channel: i16,
};

pub const Plugin = extern struct {
    count: *const fn (plugin: *const root.Plugin) callconv(.c) u32,
    get: *const fn (plugin: *const root.Plugin, index: u32, note_name: *NoteName) callconv(.c) bool,
};

pub const Host = extern struct {
    changed: *const fn (host: *const root.Host) callconv(.c) void,
};
