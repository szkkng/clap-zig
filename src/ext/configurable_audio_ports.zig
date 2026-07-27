const root = @import("../root.zig");

pub const id = "clap.configurable-audio-ports/1";
pub const id_compat = "clap.configurable-audio-ports.draft1";

pub const ConfigurationRequest = extern struct {
    is_input: bool,
    port_index: u32,
    channel_count: u32,
    port_type: ?[*:0]const u8,
    port_details: ?*const anyopaque,
};

pub const Plugin = extern struct {
    canApplyConfiguration: *const fn (plugin: *const root.Plugin, requests: [*]const ConfigurationRequest, request_count: u32) callconv(.c) bool,
    applyConfiguration: *const fn (plugin: *const root.Plugin, requests: [*]const ConfigurationRequest, request_count: u32) callconv(.c) bool,
};
