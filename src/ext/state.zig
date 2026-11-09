const ClapPlugin = @import("../plugin.zig").Plugin;
const ClapHost = @import("../host.zig").Host;
const IStream = @import("../stream.zig").IStream;
const OStream = @import("../stream.zig").OStream;

pub const id = "clap.state";

pub const Plugin = extern struct {
    save: *const fn (plugin: *const ClapPlugin, stream: *const OStream) callconv(.c) bool,
    load: *const fn (plugin: *const ClapPlugin, stream: *const IStream) callconv(.c) bool,
};

pub const Host = extern struct {
    markDirty: *const fn (host: *const ClapHost) callconv(.c) void,
};
