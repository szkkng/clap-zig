const Plugin = @import("../root.zig").Plugin;
const Host = @import("../root.zig").Host;
const Descriptor = Plugin.Descriptor;

pub const Factory = extern struct {
    getPluginCount: *const fn (factory: *const Factory) callconv(.c) u32,
    getPluginDescriptor: *const fn (factory: *const Factory, index: u32) callconv(.c) ?*const Descriptor,
    createPlugin: *const fn (factory: *const Factory, host: *const Host, plugin_id: [*:0]const u8) callconv(.c) ?*const Plugin,

    pub const id = "clap.plugin-factory";
};
