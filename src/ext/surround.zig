const root = @import("../root.zig");

pub const id = "clap.surround/4";
pub const id_compat = "clap.surround.draft/4";

pub const port_type = struct {
    pub const surround = "surround";
};

pub const ChannelMask = packed struct(u64) {
    fl: bool = false,
    fr: bool = false,
    fc: bool = false,
    lfe: bool = false,
    bl: bool = false,
    br: bool = false,
    flc: bool = false,
    frc: bool = false,
    bc: bool = false,
    sl: bool = false,
    sr: bool = false,
    tc: bool = false,
    tfl: bool = false,
    tfc: bool = false,
    tfr: bool = false,
    tbl: bool = false,
    tbc: bool = false,
    tbr: bool = false,
    tsl: bool = false,
    tsr: bool = false,
    _: u44 = 0,
};

pub const Channel = enum(u8) {
    fl = 0,
    fr = 1,
    fc = 2,
    lfe = 3,
    bl = 4,
    br = 5,
    flc = 6,
    frc = 7,
    bc = 8,
    sl = 9,
    sr = 10,
    tc = 11,
    tfl = 12,
    tfc = 13,
    tfr = 14,
    tbl = 15,
    tbc = 16,
    tbr = 17,
    tsl = 18,
    tsr = 19,
};

pub const Plugin = extern struct {
    isChannelMaskSupported: *const fn (plugin: *const root.Plugin, channel_mask: ChannelMask) callconv(.c) bool,
    getChannelMap: *const fn (plugin: *const root.Plugin, is_input: bool, port_index: u32, channel_map: [*]Channel, channel_map_capacity: u32) callconv(.c) u32,
};

pub const Host = extern struct {
    changed: *const fn (host: *const root.Host) callconv(.c) void,
};
