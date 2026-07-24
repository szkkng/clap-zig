const std = @import("std");
const root = @import("root.zig");
const Id = root.Id;
const BeatTime = root.BeatTime;
const SecTime = root.SecTime;

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
