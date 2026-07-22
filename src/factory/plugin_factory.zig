const Descriptor = @import("../plugin.zig").Descriptor;
const Plugin = @import("../plugin.zig").Plugin;
const Host = @import("../host.zig").Host;

pub const Factory = extern struct {
    pub const id = "clap.plugin-factory";

    getPluginCount: *const fn (factory: *const Factory) callconv(.c) u32,

    getPluginDescriptor: *const fn (
        factory: *const Factory,
        index: u32,
    ) callconv(.c) ?*const Descriptor,

    createPlugin: *const fn (
        factory: *const Factory,
        host: *const Host,
        plugin_id: [*:0]const u8,
    ) callconv(.c) ?*const Plugin,
};
