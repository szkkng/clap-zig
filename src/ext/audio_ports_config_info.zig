const ClapPlugin = @import("../plugin.zig").Plugin;
const Id = @import("../id.zig").Id;
const Info = @import("audio_ports.zig").Info;

pub const id = "clap.audio-ports-config-info/1";
pub const id_compat = "clap.audio-ports-config-info/draft-0";

pub const Plugin = extern struct {
    currentConfig: *const fn (plugin: *const ClapPlugin) callconv(.c) Id,
    get: *const fn (plugin: *const ClapPlugin, config_id: Id, port_index: u32, is_input: bool, info: *Info) callconv(.c) bool,
};
