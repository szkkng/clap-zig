const ClapPlugin = @import("../plugin.zig").Plugin;
const Id = @import("../id.zig").Id;
const Color = @import("../color.zig").Color;

pub const id = "clap.param-indication/4";
pub const id_compat = "clap.param-indication.draft/4";

pub const AutomationState = enum(u32) {
    none = 0,
    present = 1,
    playing = 2,
    recording = 3,
    overriding = 4,
    _,
};

pub const Plugin = extern struct {
    setMapping: *const fn (plugin: *const ClapPlugin, param_id: Id, has_mapping: bool, color: ?*const Color, label: ?[*:0]const u8, description: ?[*:0]const u8) callconv(.c) void,
    setAutomation: *const fn (plugin: *const ClapPlugin, param_id: Id, automation_state: AutomationState, color: ?*const Color) callconv(.c) void,
};
