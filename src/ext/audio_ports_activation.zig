const ClapPlugin = @import("../plugin.zig").Plugin;

pub const id = "clap.audio-ports-activation/2";
pub const id_compat = "clap.audio-ports-activation/draft-2";

pub const Plugin = extern struct {
    canActivateWhileProcessing: *const fn (plugin: *const ClapPlugin) callconv(.c) bool,
    setActive: *const fn (plugin: *const ClapPlugin, is_input: bool, port_index: u32, is_active: bool, sample_size: u32) callconv(.c) bool,
};
