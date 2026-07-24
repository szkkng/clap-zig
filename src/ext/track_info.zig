const root = @import("../root.zig");
const name_size = root.name_size;
const Color = root.Color;

pub const id = "clap.track-info/1";
pub const id_compat = "clap.track-info.draft/1";

pub const Info = extern struct {
    flags: Flags,
    name: [name_size]u8,
    color: Color,
    audio_channel_count: i32,
    audio_port_type: ?[*:0]const u8,

    pub const Flags = packed struct(u64) {
        has_track_name: bool = false,
        has_track_color: bool = false,
        has_audio_channel: bool = false,
        is_for_return_track: bool = false,
        is_for_bus: bool = false,
        is_for_master: bool = false,
        _: u58 = 0,
    };
};

pub const Plugin = extern struct {
    changed: *const fn (plugin: *const root.Plugin) callconv(.c) void,
};

pub const Host = extern struct {
    get: *const fn (host: *const root.Host, info: *Info) callconv(.c) bool,
};
