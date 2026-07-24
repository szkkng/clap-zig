const root = @import("../root.zig");

pub const id = "clap.voice-info";

pub const Info = extern struct {
    voice_count: u32,
    voice_capacity: u32,
    flags: Flags,

    pub const Flags = packed struct(u64) {
        supports_overlapping_notes: bool = false,
        _: u63 = 0,
    };
};

pub const Plugin = extern struct {
    get: *const fn (plugin: *const root.Plugin, info: *Info) callconv(.c) bool,
};

pub const Host = extern struct {
    changed: *const fn (host: *const root.Host) callconv(.c) void,
};
