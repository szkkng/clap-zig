const Id = @import("../root.zig").Id;
const name_size = @import("../root.zig").name_size;
const root = @import("../root.zig");
const Plugin = root.Plugin;
const Host = root.Host;

pub const id = "clap.audio-ports";
pub const port_type = struct {
    pub const mono = "mono";
    pub const stereo = "stereo";
};

pub const AudioPortInfo = extern struct {
    id: Id,
    name: [name_size]u8,
    flags: Flags,
    channel_count: u32,
    port_type: ?[*:0]const u8,
    in_place_pair: Id,

    pub const Flags = packed struct(u32) {
        is_main: bool = false,
        supports_64bits: bool = false,
        prefers_64bits: bool = false,
        requires_common_sample_size: bool = false,
        _: u28 = 0,
    };
};

pub const PluginAudioPorts = extern struct {
    count: *const fn (plugin: *const Plugin, is_input: bool) callconv(.c) u32,
    get: *const fn (plugin: *const Plugin, index: u32, is_input: bool, info: *AudioPortInfo) callconv(.c) bool,
};

pub const HostAudioPorts = extern struct {
    isRescanFlagSupported: *const fn (host: *const Host, flag: RescanFlag) callconv(.c) bool,
    rescan: *const fn (host: *const Host, flags: RescanFlags) callconv(.c) void,

    pub const RescanFlag = enum(u32) {
        names = @bitCast(RescanFlags{ .names = true }),
        flags = @bitCast(RescanFlags{ .flags = true }),
        channel_count = @bitCast(RescanFlags{ .channel_count = true }),
        port_type = @bitCast(RescanFlags{ .port_type = true }),
        in_place_pair = @bitCast(RescanFlags{ .in_place_pair = true }),
        list = @bitCast(RescanFlags{ .list = true }),
    };

    pub const RescanFlags = packed struct(u32) {
        names: bool = false,
        flags: bool = false,
        channel_count: bool = false,
        port_type: bool = false,
        in_place_pair: bool = false,
        list: bool = false,
        _: u26 = 0,
    };
};
