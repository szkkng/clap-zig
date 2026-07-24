const Plugin = @import("../root.zig").Plugin;

pub const id = "clap.audio-ports-activation/2";
pub const id_compat = "clap.audio-ports-activation/draft-2";

pub const Activation = extern struct {
    canActivateWhileProcessing: *const fn (plugin: *const Plugin) callconv(.c) bool,
    setActive: *const fn (plugin: *const Plugin, is_input: bool, port_index: u32, is_active: bool, sample_size: u32) callconv(.c) bool,
};
