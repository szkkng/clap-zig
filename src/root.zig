const std = @import("std");

pub const ext = @import("ext.zig");
pub const event = @import("event.zig");
pub const preset_discovery = @import("preset_discovery.zig");

pub const Version = extern struct {
    major: u32 = 1,
    minor: u32 = 2,
    revision: u32 = 10,

    pub fn isCompatible(self: Version) bool {
        return self.major >= 1;
    }
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

    pub const Descriptor = extern struct {
        clap_version: Version = .{},
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

    pub const feature = struct {
        pub const instrument = "instrument";
        pub const audio_effect = "audio-effect";
        pub const note_effect = "note-effect";
        pub const note_detector = "note-detector";
        pub const analyzer = "analyzer";
        pub const synthesizer = "synthesizer";
        pub const sampler = "sampler";
        pub const drum = "drum";
        pub const drum_machine = "drum-machine";
        pub const filter = "filter";
        pub const phaser = "phaser";
        pub const equalizer = "equalizer";
        pub const deesser = "de-esser";
        pub const phase_vocoder = "phase-vocoder";
        pub const granular = "granular";
        pub const frequency_shifter = "frequency-shifter";
        pub const pitch_shifter = "pitch-shifter";
        pub const distortion = "distortion";
        pub const transient_shaper = "transient-shaper";
        pub const compressor = "compressor";
        pub const expander = "expander";
        pub const gate = "gate";
        pub const limiter = "limiter";
        pub const flanger = "flanger";
        pub const chorus = "chorus";
        pub const delay = "delay";
        pub const reverb = "reverb";
        pub const tremolo = "tremolo";
        pub const glitch = "glitch";
        pub const utility = "utility";
        pub const pitch_correction = "pitch-correction";
        pub const restoration = "restoration";
        pub const multi_effects = "multi-effects";
        pub const mixing = "mixing";
        pub const mastering = "mastering";
        pub const mono = "mono";
        pub const stereo = "stereo";
        pub const surround = "surround";
        pub const ambisonic = "ambisonic";
    };

    pub const Entry = extern struct {
        clap_version: Version = .{},
        init: *const fn (plugin_path: [*:0]const u8) callconv(.c) bool,
        deinit: *const fn () callconv(.c) void,
        getFactory: *const fn (factory_id: [*:0]const u8) callconv(.c) ?*const anyopaque,
    };

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
};

pub const Host = extern struct {
    clap_version: Version,
    host_data: *anyopaque,
    name: [*:0]const u8,
    vendor: [*:0]const u8,
    url: [*:0]const u8,
    version: [*:0]const u8,
    getExtension: *const fn (host: *const Host, extension_id: [*:0]const u8) callconv(.c) ?*const anyopaque,
    requestRestart: *const fn (host: *const Host) callconv(.c) void,
    requestProcess: *const fn (host: *const Host) callconv(.c) void,
    requestCallback: *const fn (host: *const Host) callconv(.c) void,
};

pub const AudioBuffer = extern struct {
    data32: ?[*][*]f32,
    data64: ?[*][*]f64,
    channel_count: u32,
    latency: u32,
    constant_mask: u64,
};

pub const Process = extern struct {
    pub const Status = enum(i32) {
        @"error" = 0,
        @"continue" = 1,
        continue_if_not_quiet = 2,
        tail = 3,
        sleep = 4,
    };

    steady_time: i64,
    frames_count: u32,
    transport: ?*const event.Transport,
    audio_inputs: [*]const AudioBuffer,
    audio_outputs: [*]AudioBuffer,
    audio_inputs_count: u32,
    audio_outputs_count: u32,
    in_events: *const event.InputEvents,
    out_events: *const event.OutputEvents,
};

pub const Id = u32;
pub const invalid_id: Id = std.math.maxInt(Id);

pub const BeatTime = i64;
pub const SecTime = i64;
pub const beat_time_factor: i64 = 1 << 31;
pub const sec_time_factor: i64 = 1 << 31;

pub const Timestamp = u64;
pub const timestamp_unknown: Timestamp = 0;

pub const UniversalPluginId = extern struct {
    abi: [*:0]const u8,
    id: [*:0]const u8,
};

pub const name_size = 256;
pub const path_size = 1024;

pub const IStream = extern struct {
    ctx: *anyopaque,
    read: *const fn (stream: *const IStream, buffer: ?*anyopaque, size: u64) callconv(.c) i64,
};

pub const OStream = extern struct {
    ctx: *anyopaque,
    write: *const fn (stream: *const OStream, buffer: ?*const anyopaque, size: u64) callconv(.c) i64,
};

pub const Color = extern struct {
    alpha: u8,
    red: u8,
    green: u8,
    blue: u8,

    pub const transparent: Color = .{
        .alpha = 0,
        .red = 0,
        .green = 0,
        .blue = 0,
    };
};
