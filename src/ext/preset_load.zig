const root = @import("../root.zig");
const Location = root.preset_discovery.Location;

pub const id = "clap.preset-load/2";
pub const id_compat = "clap.preset-load.draft/2";

pub const Plugin = extern struct {
    fromLocation: *const fn (
        plugin: *const root.Plugin,
        location_kind: Location.Kind,
        location: ?[*:0]const u8,
        load_key: ?[*:0]const u8,
    ) callconv(.c) bool,
};

pub const Host = extern struct {
    onError: *const fn (
        host: *const root.Host,
        location_kind: Location.Kind,
        location: ?[*:0]const u8,
        load_key: ?[*:0]const u8,
        os_error: i32,
        msg: [*:0]const u8,
    ) callconv(.c) void,

    loaded: *const fn (
        host: *const root.Host,
        location_kind: Location.Kind,
        location: ?[*:0]const u8,
        load_key: ?[*:0]const u8,
    ) callconv(.c) void,
};
