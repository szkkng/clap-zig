const ClapPlugin = @import("../plugin.zig").Plugin;
const OStream = @import("../stream.zig").OStream;
const IStream = @import("../stream.zig").IStream;

pub const id = "clap.state-context/2";

pub const Type = enum(u32) {
    preset = 1,
    duplicate = 2,
    project = 3,
    _,
};

pub const Plugin = extern struct {
    save: *const fn (plugin: *const ClapPlugin, stream: *const OStream, context_type: Type) callconv(.c) bool,
    load: *const fn (plugin: *const ClapPlugin, stream: *const IStream, context_type: Type) callconv(.c) bool,
};
