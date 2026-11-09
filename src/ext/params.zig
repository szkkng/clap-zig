const ClapPlugin = @import("../plugin.zig").Plugin;
const ClapHost = @import("../host.zig").Host;
const name_size = @import("../string_sizes.zig").name_size;
const path_size = @import("../string_sizes.zig").path_size;
const Id = @import("../id.zig").Id;
const InputEvents = @import("../events.zig").InputEvents;
const OutputEvents = @import("../events.zig").OutputEvents;

pub const id = "clap.params";

pub const Info = extern struct {
    id: Id,
    flags: Flags,
    cookie: ?*anyopaque,
    name: [name_size]u8,
    module: [path_size]u8,
    min_value: f64,
    max_value: f64,
    default_value: f64,

    pub const Flags = packed struct(u32) {
        is_stepped: bool = false,
        is_periodic: bool = false,
        is_hidden: bool = false,
        is_readonly: bool = false,
        is_bypass: bool = false,
        is_automatable: bool = false,
        is_automatable_per_note_id: bool = false,
        is_automatable_per_key: bool = false,
        is_automatable_per_channel: bool = false,
        is_automatable_per_port: bool = false,
        is_modulatable: bool = false,
        is_modulatable_per_note_id: bool = false,
        is_modulatable_per_key: bool = false,
        is_modulatable_per_channel: bool = false,
        is_modulatable_per_port: bool = false,
        requires_process: bool = false,
        is_enum: bool = false,
        _: u15 = 0,
    };
};

pub const Plugin = extern struct {
    count: *const fn (plugin: *const ClapPlugin) callconv(.c) u32,
    getInfo: *const fn (plugin: *const ClapPlugin, param_index: u32, param_info: *Info) callconv(.c) bool,
    getValue: *const fn (plugin: *const ClapPlugin, param_id: Id, out_value: *f64) callconv(.c) bool,
    valueToText: *const fn (plugin: *const ClapPlugin, param_id: Id, value: f64, out_buffer: [*]u8, out_buffer_capacity: u32) callconv(.c) bool,
    textToValue: *const fn (plugin: *const ClapPlugin, param_id: Id, param_value_text: [*:0]const u8, out_value: *f64) callconv(.c) bool,
    flush: *const fn (plugin: *const ClapPlugin, in: *const InputEvents, out: *const OutputEvents) callconv(.c) void,
};

pub const Host = extern struct {
    rescan: *const fn (host: *const ClapHost, flags: RescanFlags) callconv(.c) void,
    clear: *const fn (host: *const ClapHost, param_id: Id, flags: ClearFlags) callconv(.c) void,
    requestFlush: *const fn (host: *const ClapHost) callconv(.c) void,

    pub const RescanFlags = packed struct(u32) {
        values: bool = false,
        text: bool = false,
        info: bool = false,
        all: bool = false,
        _: u28 = 0,
    };

    pub const ClearFlags = packed struct(u32) {
        all: bool = false,
        automations: bool = false,
        modulations: bool = false,
        _: u29 = 0,
    };
};
