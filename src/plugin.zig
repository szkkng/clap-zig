const std = @import("std");
const Version = @import("version.zig").Version;
const Host = @import("host.zig").Host;
const Process = @import("process.zig").Process;

pub const Entry = @import("entry.zig").Entry;
pub const feature = @import("plugin_features.zig").feature;

pub const Descriptor = extern struct {
    clap_version: Version,
    id: [*:0]const u8,
    name: [*:0]const u8,
    vendor: ?[*:0]const u8,
    url: ?[*:0]const u8,
    manual_url: ?[*:0]const u8,
    support_url: ?[*:0]const u8,
    version: ?[*:0]const u8,
    description: ?[*:0]const u8,
    features: ?[*:null]const ?[*:0]const u8,
};

test "Descriptor ABI compatibility" {
    comptime {
        const abi = @import("abi.zig");
        const raw = @import("raw");
        abi.assertStruct(Descriptor, raw.clap_plugin_descriptor_t);
    }
}

pub const Plugin = extern struct {
    desc: *const Descriptor,
    plugin_data: *anyopaque,
    init: *const fn (plugin: *const Plugin) callconv(.c) bool,
    destroy: *const fn (plugin: *const Plugin) callconv(.c) void,
    activate: *const fn (plugin: *const Plugin, sample_rate: f64, min_frames_count: u32, max_frames_count: u32) callconv(.c) bool,
    deactivate: *const fn (plugin: *const Plugin) callconv(.c) void,
    startProcessing: *const fn (plugin: *const Plugin) callconv(.c) bool,
    stopProcessing: *const fn (plugin: *const Plugin) callconv(.c) void,
    reset: *const fn (plugin: *const Plugin) callconv(.c) void,
    process: *const fn (plugin: *const Plugin, process: *const Process) callconv(.c) Process.Status,
    getExtension: *const fn (plugin: *const Plugin, id: [*:0]const u8) callconv(.c) ?*const anyopaque,
    onMainThread: *const fn (plugin: *const Plugin) callconv(.c) void,
};

test "Plugin ABI compatibility" {
    comptime {
        const abi = @import("abi.zig");
        const raw = @import("raw");
        abi.assertStruct(Plugin, raw.clap_plugin_t);
        abi.assertFnPtr(@FieldType(Plugin, "init"), @FieldType(raw.clap_plugin_t, "init"));
        abi.assertFnPtr(@FieldType(Plugin, "destroy"), @FieldType(raw.clap_plugin_t, "destroy"));
        abi.assertFnPtr(@FieldType(Plugin, "activate"), @FieldType(raw.clap_plugin_t, "activate"));
        abi.assertFnPtr(@FieldType(Plugin, "startProcessing"), @FieldType(raw.clap_plugin_t, "start_processing"));
        abi.assertFnPtr(@FieldType(Plugin, "stopProcessing"), @FieldType(raw.clap_plugin_t, "stop_processing"));
        abi.assertFnPtr(@FieldType(Plugin, "reset"), @FieldType(raw.clap_plugin_t, "reset"));
        abi.assertFnPtr(@FieldType(Plugin, "process"), @FieldType(raw.clap_plugin_t, "process"));
        abi.assertFnPtr(@FieldType(Plugin, "getExtension"), @FieldType(raw.clap_plugin_t, "get_extension"));
        abi.assertFnPtr(@FieldType(Plugin, "onMainThread"), @FieldType(raw.clap_plugin_t, "on_main_thread"));
    }
}

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

test "Factory ABI compatibility" {
    comptime {
        const abi = @import("abi.zig");
        const raw = @import("raw");

        std.debug.assert(std.mem.eql(u8, Factory.id, raw.CLAP_PLUGIN_FACTORY_ID[0..]));

        abi.assertStruct(Factory, raw.clap_plugin_factory_t);
        abi.assertFnPtr(
            @FieldType(Factory, "getPluginCount"),
            @FieldType(raw.clap_plugin_factory_t, "get_plugin_count"),
        );
        abi.assertFnPtr(
            @FieldType(Factory, "getPluginDescriptor"),
            @FieldType(raw.clap_plugin_factory_t, "get_plugin_descriptor"),
        );
        abi.assertFnPtr(
            @FieldType(Factory, "createPlugin"),
            @FieldType(raw.clap_plugin_factory_t, "create_plugin"),
        );
    }
}

test {
    std.testing.refAllDecls(@This());
}
