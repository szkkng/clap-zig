const std = @import("std");
const Version = @import("version.zig").Version;
const Host = @import("host.zig").Host;
const Process = @import("process.zig").Process;

pub const Entry = @import("entry.zig").Entry;
pub const Factory = @import("factory/plugin_factory.zig").Factory;
pub const feature = @import("plugin_features.zig").feature;
pub const AudioPorts = @import("ext/audio_ports.zig").PluginAudioPorts;

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
