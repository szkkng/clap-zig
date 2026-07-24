const std = @import("std");

pub const ext = @import("ext.zig");

pub const Version = extern struct {
    major: u32,
    minor: u32,
    revision: u32,

    pub const current: Version = .{
        .major = 1,
        .minor = 2,
        .revision = 10,
    };

    pub fn isCompatible(self: Version) bool {
        return self.major >= 1;
    }
};

pub const Plugin = extern struct {
    desc: *const Descriptor,
    plugin_data: ?*anyopaque,
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
        clap_version: Version = .current,
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
        clap_version: Version = .current,
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
    host_data: ?*anyopaque,
    name: [*:0]const u8,
    vendor: ?[*:0]const u8,
    url: ?[*:0]const u8,
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

pub const event = struct {
    pub const core_event_space_id = 0;

    pub const Header = extern struct {
        size: u32,
        time: u32,
        space_id: u16,
        type: Type,
        flags: Flags,

        pub const Type = enum(u16) {
            note_on = 0,
            note_off = 1,
            note_choke = 2,
            note_end = 3,
            note_expression = 4,
            param_value = 5,
            param_mod = 6,
            param_gesture_begin = 7,
            param_gesture_end = 8,
            transport = 9,
            midi = 10,
            midi_sysex = 11,
            midi2 = 12,
            _,
        };

        pub const Flags = packed struct(u32) {
            is_live: bool = false,
            dont_record: bool = false,
            _: u30 = 0,
        };
    };

    pub const Note = extern struct {
        header: Header,
        note_id: i32,
        port_index: i16,
        channel: i16,
        key: i16,
        velocity: f64,
    };

    pub const NoteExpression = extern struct {
        header: Header,
        expression_id: @This().Id,
        note_id: i32,
        port_index: i16,
        channel: i16,
        key: i16,
        value: f64,

        pub const Id = enum(i32) {
            volume = 0,
            pan = 1,
            tuning = 2,
            vibrato = 3,
            expression = 4,
            brightness = 5,
            pressure = 6,
        };
    };

    pub const ParamValue = extern struct {
        header: Header,
        param_id: Id,
        cookie: ?*anyopaque,
        note_id: i32,
        port_index: i16,
        channel: i16,
        key: i16,
        value: f64,
    };

    pub const ParamMod = extern struct {
        header: Header,
        param_id: Id,
        cookie: ?*anyopaque,
        note_id: i32,
        port_index: i16,
        channel: i16,
        key: i16,
        amount: f64,
    };

    pub const ParamGesture = extern struct {
        header: Header,
        param_id: Id,
    };

    pub const Transport = extern struct {
        header: Header,
        flags: Flags,
        song_pos_beats: BeatTime,
        song_pos_seconds: SecTime,
        tempo: f64,
        tempo_inc: f64,
        loop_start_beats: BeatTime,
        loop_end_beats: BeatTime,
        loop_start_seconds: SecTime,
        loop_end_seconds: SecTime,
        bar_start: BeatTime,
        bar_number: i32,
        tsig_num: u16,
        tsig_denom: u16,

        pub const Flags = packed struct(u32) {
            has_tempo: bool = false,
            has_beats_timeline: bool = false,
            has_seconds_timeline: bool = false,
            has_time_signature: bool = false,
            is_playing: bool = false,
            is_recording: bool = false,
            is_loop_active: bool = false,
            is_within_pre_roll: bool = false,
            _: u24 = 0,
        };
    };

    pub const Midi = extern struct {
        header: Header,
        port_index: u16,
        data: [3]u8,
    };

    pub const MidiSysex = extern struct {
        header: Header,
        port_index: u16,
        buffer: [*]const u8,
        size: u32,
    };

    pub const Midi2 = extern struct {
        header: Header,
        port_index: u16,
        data: [4]u32,
    };

    pub const InputEvents = extern struct {
        ctx: ?*anyopaque,
        size: *const fn (list: *const InputEvents) callconv(.c) u32,
        get: *const fn (list: *const InputEvents, index: u32) callconv(.c) *const Header,
    };

    pub const OutputEvents = extern struct {
        ctx: ?*anyopaque,
        tryPush: *const fn (list: *const OutputEvents, event: *const Header) callconv(.c) bool,
    };
};

pub const preset_discovery = struct {
    pub const Flags = packed struct(u32) {
        is_factory_content: bool = false,
        is_user_content: bool = false,
        is_demo_content: bool = false,
        is_favorite: bool = false,
        _: u28 = 0,
    };

    pub const MetadataReceiver = extern struct {
        receiver_data: ?*anyopaque,
        onError: *const fn (receiver: *const MetadataReceiver, os_error: i32, error_message: [*:0]const u8) callconv(.c) void,
        beginPreset: *const fn (receiver: *const MetadataReceiver, name: ?[*:0]const u8, load_key: ?[*:0]const u8) callconv(.c) bool,
        addPluginId: *const fn (receiver: *const MetadataReceiver, plugin_id: *const UniversalPluginId) callconv(.c) void,
        setSoundpackId: *const fn (receiver: *const MetadataReceiver, soundpack_id: [*:0]const u8) callconv(.c) void,
        setFlags: *const fn (receiver: *const MetadataReceiver, flags: Flags) callconv(.c) void,
        addCreator: *const fn (receiver: *const MetadataReceiver, creator: [*:0]const u8) callconv(.c) void,
        setDescription: *const fn (receiver: *const MetadataReceiver, description: [*:0]const u8) callconv(.c) void,
        setTimestamps: *const fn (receiver: *const MetadataReceiver, creation_time: Timestamp, modification_time: Timestamp) callconv(.c) void,
        addFeature: *const fn (receiver: *const MetadataReceiver, feature: [*:0]const u8) callconv(.c) void,
        addExtraInfo: *const fn (receiver: *const MetadataReceiver, key: [*:0]const u8, value: [*:0]const u8) callconv(.c) void,
    };

    pub const FileType = extern struct {
        name: [*:0]const u8,
        description: ?[*:0]const u8,
        file_extension: ?[*:0]const u8,
    };

    pub const Location = extern struct {
        flags: Flags,
        name: [*:0]const u8,
        kind: Kind,
        location: ?[*:0]const u8,

        pub const Kind = enum(u32) {
            file = 0,
            plugin = 1,
        };
    };

    pub const Soundpack = extern struct {
        flags: Flags,
        id: [*:0]const u8,
        name: [*:0]const u8,
        description: ?[*:0]const u8,
        homepage_url: ?[*:0]const u8,
        vendor: ?[*:0]const u8,
        image_path: ?[*:0]const u8,
        release_timestamp: Timestamp,
    };

    pub const Provider = extern struct {
        desc: *const Descriptor,
        provider_data: *anyopaque,
        init: *const fn (provider: *const Provider) callconv(.c) bool,
        destroy: *const fn (provider: *const Provider) callconv(.c) void,
        getMetadata: *const fn (provider: *const Provider, location_kind: Location.Kind, location: ?[*:0]const u8, metadata_receiver: *const MetadataReceiver) callconv(.c) bool,
        getExtension: *const fn (provider: *const Provider, extension_id: [*:0]const u8) callconv(.c) ?*const anyopaque,

        pub const Descriptor = extern struct {
            clap_version: Version = .current,
            id: [*:0]const u8,
            name: [*:0]const u8,
            vendor: ?[*:0]const u8,
        };
    };

    pub const Indexer = extern struct {
        clap_version: Version = .current,
        name: [*:0]const u8,
        vendor: ?[*:0]const u8,
        url: ?[*:0]const u8,
        version: ?[*:0]const u8,
        indexer_data: ?*anyopaque,
        declareFiletype: *const fn (indexer: *const Indexer, filetype: *const FileType) callconv(.c) bool,
        declareLocation: *const fn (indexer: *const Indexer, location: *const Location) callconv(.c) bool,
        declareSoundpack: *const fn (indexer: *const Indexer, soundpack: *const Soundpack) callconv(.c) bool,
        getExtension: *const fn (indexer: *const Indexer, extension_id: [*:0]const u8) callconv(.c) ?*const anyopaque,
    };

    pub const Factory = extern struct {
        count: *const fn (factory: *const Factory) callconv(.c) u32,
        getDescriptor: *const fn (factory: *const Factory, index: u32) callconv(.c) ?*const Provider.Descriptor,
        create: *const fn (factory: *const Factory, indexer: *const Indexer, provider_id: [*:0]const u8) callconv(.c) ?*const Provider,

        pub const id = "clap.preset-discovery-factory/2";
        pub const id_compat = "clap.preset-discovery-factory/draft-2";
    };
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
    ctx: ?*anyopaque,
    read: *const fn (stream: *const IStream, buffer: *anyopaque, size: u64) callconv(.c) i64,
};

pub const OStream = extern struct {
    ctx: ?*anyopaque,
    write: *const fn (stream: *const OStream, buffer: *const anyopaque, size: u64) callconv(.c) i64,
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
