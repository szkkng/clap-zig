const root = @import("../root.zig");
const OStream = root.OStream;
const IStream = root.IStream;

pub const id = "clap.state-context/2";

pub const Type = enum(u32) {
    preset = 1,
    duplicate = 2,
    project = 3,
};

pub const Plugin = extern struct {
    save: *const fn (plugin: *const root.Plugin, stream: *const OStream, context_type: Type) callconv(.c) bool,
    load: *const fn (plugin: *const root.Plugin, stream: *const IStream, context_type: Type) callconv(.c) bool,
};
