const root = @import("../root.zig");
const name_size = root.name_size;
const path_size = root.path_size;
const Plugin = root.Plugin;
const Host = root.Host;
const Id = root.Id;
const InputEvents = root.event.InputEvents;
const OutputEvents = root.event.OutputEvents;

pub const id = "clap.params";

pub const ParamInfo = extern struct {
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

pub const PluginParams = extern struct {
    count: *const fn (plugin: *const Plugin) callconv(.c) u32,
    getInfo: *const fn (plugin: *const Plugin, param_index: u32, param_info: *ParamInfo) callconv(.c) bool,
    getValue: *const fn (plugin: *const Plugin, param_id: Id, out_value: *f64) callconv(.c) bool,
    valueToText: *const fn (plugin: *const Plugin, param_id: Id, value: f64, out_buffer: [*:0]u8, out_buffer_capacity: u32) callconv(.c) bool,
    textToValue: *const fn (plugin: *const Plugin, param_id: Id, param_value_text: [*:0]const u8, out_value: *f64) callconv(.c) bool,
    flush: *const fn (plugin: *const Plugin, in: *const InputEvents, out: *const OutputEvents) callconv(.c) void,
};

pub const HostParams = extern struct {
    rescan: *const fn (host: *const Host, flags: RescanFlags) callconv(.c) void,
    clear: *const fn (host: *const Host, param_id: Id, flags: ClearFlags) callconv(.c) void,
    requestFlush: *const fn (host: *const Host) callconv(.c) void,

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
