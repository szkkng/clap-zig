const root = @import("../root.zig");
const IStream = root.IStream;
const OStream = root.OStream;

pub const id = "clap.state";

pub const Plugin = extern struct {
    save: *const fn (plugin: *const root.Plugin, stream: *const OStream) callconv(.c) bool,
    load: *const fn (plugin: *const root.Plugin, stream: *const IStream) callconv(.c) bool,
};

pub const Host = extern struct {
    markDirty: *const fn (host: *const root.Host) callconv(.c) void,
};
