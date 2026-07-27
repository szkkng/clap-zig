const root = @import("../root.zig");
const Id = root.Id;
const Info = @import("audio_ports.zig").Info;

pub const id = "clap.audio-ports-config-info/1";
pub const id_compat = "clap.audio-ports-config-info/draft-0";

pub const Plugin = extern struct {
    currentConfig: *const fn (plugin: *const root.Plugin) callconv(.c) Id,
    get: *const fn (plugin: *const root.Plugin, config_id: Id, port_index: u32, is_input: bool, info: *Info) callconv(.c) bool,
};
