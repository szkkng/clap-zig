const root = @import("../root.zig");
const Id = root.Id;
const name_size = root.name_size;
const Plugin = root.Plugin;
const Host = root.Host;
const AudioPortInfo = @import("audio_ports.zig").AudioPortInfo;

pub const id = "clap.audio-ports-config";

pub const info_id = "clap.audio-ports-config-info/1";
pub const info_id_compat = "clap.audio-ports-config-info/draft-0";

pub const AudioPortsConfig = extern struct {
    id: Id,
    name: [name_size]u8,
    input_port_count: u32,
    output_port_count: u32,
    has_main_input: bool,
    main_input_channel_count: u32,
    main_input_port_type: ?[*:0]const u8,
    has_main_output: bool,
    main_output_channel_count: u32,
    main_output_port_type: ?[*:0]const u8,
};

pub const PluginAudioPortsConfig = extern struct {
    count: *const fn (plugin: *const Plugin) callconv(.c) u32,
    get: *const fn (plugin: *const Plugin, index: u32, config: *AudioPortsConfig) callconv(.c) bool,
    select: *const fn (plugin: *const Plugin, config_id: Id) callconv(.c) bool,
};

pub const PluginAudioPortsConfigInfo = extern struct {
    currentConfig: *const fn (plugin: *const Plugin) callconv(.c) Id,
    get: *const fn (plugin: *const Plugin, config_id: Id, port_index: u32, is_input: bool, info: *AudioPortInfo) callconv(.c) bool,
};

pub const HostAudioPortsConfig = extern struct {
    rescan: *const fn (host: *const Host) callconv(.c) void,
};
