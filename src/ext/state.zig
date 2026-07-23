const root = @import("../root.zig");
const Plugin = root.Plugin;
const Host = root.Host;
const IStream = root.IStream;
const OStream = root.OStream;

pub const id = "clap.state";

pub const PluginState = extern struct {
    save: *const fn (plugin: *const Plugin, stream: *const OStream) callconv(.c) bool,
    load: *const fn (plugin: *const Plugin, stream: *const IStream) callconv(.c) bool,
};

pub const HostState = extern struct {
    markDirty: *const fn (host: *const Host) callconv(.c) void,
};
