const root = @import("../root.zig");
const Id = root.Id;
const name_size = root.name_size;

pub const id = "clap.note-ports";

pub const Dialects = packed struct(u32) {
    clap: bool = false,
    midi: bool = false,
    midi_mpe: bool = false,
    midi2: bool = false,
    _: u28 = 0,
};

pub const Dialect = enum(u32) {
    clap = @bitCast(Dialects{ .clap = true }),
    midi = @bitCast(Dialects{ .midi = true }),
    midi_mpe = @bitCast(Dialects{ .midi_mpe = true }),
    midi2 = @bitCast(Dialects{ .midi2 = true }),
};

pub const Info = extern struct {
    id: Id,
    supported_dialects: Dialects,
    preferred_dialect: Dialect,
    name: [name_size]u8,
};

pub const Plugin = extern struct {
    count: *const fn (plugin: *const root.Plugin, is_input: bool) callconv(.c) u32,
    get: *const fn (plugin: *const root.Plugin, index: u32, is_input: bool, info: *Info) callconv(.c) bool,
};

pub const Host = extern struct {
    supportedDialects: *const fn (host: *const root.Host) callconv(.c) Dialects,
    rescan: *const fn (host: *const root.Host, flags: RescanFlags) callconv(.c) void,

    pub const RescanFlags = packed struct(u32) {
        all: bool = false,
        names: bool = false,
        _: u30 = 0,
    };
};
