const root = @import("../root.zig");

pub const id = "clap.ambisonic/3";
pub const id_compat = "clap.ambisonic.draft/3";

pub const port_type = struct {
    pub const ambisonic = "ambisonic";
};

pub const Ordering = enum(u32) {
    fuma = 0,
    acn = 1,
};

pub const Normalization = enum(u32) {
    maxn = 0,
    sn3d = 1,
    n3d = 2,
    sn2d = 3,
    n2d = 4,
};

pub const Config = extern struct {
    ordering: Ordering,
    normalization: Normalization,
};

pub const Plugin = extern struct {
    isConfigSupported: *const fn (plugin: *const root.Plugin, config: *const Config) callconv(.c) bool,
    getConfig: *const fn (plugin: *const root.Plugin, is_input: bool, port_index: u32, config: *Config) callconv(.c) bool,
};

pub const Host = extern struct {
    changed: *const fn (host: *const root.Host) callconv(.c) void,
};
