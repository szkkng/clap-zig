const Id = @import("../id.zig").Id;
const ClapPlugin = @import("../plugin.zig").Plugin;
const ClapHost = @import("../host.zig").Host;
const name_size = @import("../string_sizes.zig").name_size;

pub const id = "clap.audio-ports";

pub const port_type = struct {
    pub const mono = "mono";
    pub const stereo = "stereo";
};

pub const Info = extern struct {
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

pub const Plugin = extern struct {
    count: *const fn (plugin: *const ClapPlugin, is_input: bool) callconv(.c) u32,
    get: *const fn (plugin: *const ClapPlugin, index: u32, is_input: bool, info: *Info) callconv(.c) bool,
};

pub const Host = extern struct {
    isRescanFlagSupported: *const fn (host: *const ClapHost, flag: RescanFlag) callconv(.c) bool,
    rescan: *const fn (host: *const ClapHost, flags: RescanFlags) callconv(.c) void,

    pub const RescanFlag = enum(u32) {
        names = @backingInt(RescanFlags{ .names = true }),
        flags = @backingInt(RescanFlags{ .flags = true }),
        channel_count = @backingInt(RescanFlags{ .channel_count = true }),
        port_type = @backingInt(RescanFlags{ .port_type = true }),
        in_place_pair = @backingInt(RescanFlags{ .in_place_pair = true }),
        list = @backingInt(RescanFlags{ .list = true }),
        _,
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
