const root = @import("../root.zig");
const Id = root.Id;
const Color = root.Color;

pub const id = "clap.param-indication/4";
pub const id_compat = "clap.param-indication.draft/4";

pub const AutomationState = enum(u32) {
    none = 0,
    present = 1,
    playing = 2,
    recording = 3,
    overriding = 4,
};

pub const Plugin = extern struct {
    setMapping: *const fn (
        plugin: *const root.Plugin,
        param_id: Id,
        has_mapping: bool,
        color: ?*const Color,
        label: ?[*:0]const u8,
        description: ?[*:0]const u8,
    ) callconv(.c) void,

    setAutomation: *const fn (
        plugin: *const root.Plugin,
        param_id: Id,
        automation_state: u32,
        color: ?*const Color,
    ) callconv(.c) void,
};
