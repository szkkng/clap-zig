const std = @import("std");
const Id = @import("id.zig").Id;
const Beattime = @import("fixedpoint.zig").Beattime;
const Sectime = @import("fixedpoint.zig").Sectime;

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

test "Header ABI compatibility" {
    comptime {
        const raw = @import("raw");
        const abi = @import("abi.zig");
        abi.assertStruct(Header, raw.clap_event_header_t);
    }
}

pub const core_event_space_id = 0;

pub const Note = extern struct {
    header: Header,
    note_id: i32,
    port_index: i16,
    channel: i16,
    key: i16,
    velocity: f64,
};

test "Note ABI compatibility" {
    comptime {
        const raw = @import("raw");
        const abi = @import("abi.zig");
        abi.assertStruct(Note, raw.clap_event_note_t);
    }
}

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

test "NoteExpression ABI compatibility" {
    comptime {
        const raw = @import("raw");
        const abi = @import("abi.zig");
        abi.assertStruct(NoteExpression, raw.clap_event_note_expression_t);
    }
}

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

test "ParamValue ABI compatibility" {
    comptime {
        const raw = @import("raw");
        const abi = @import("abi.zig");
        abi.assertStruct(ParamValue, raw.clap_event_param_value_t);
    }
}

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

test "ParamMod ABI compatibility" {
    comptime {
        const raw = @import("raw");
        const abi = @import("abi.zig");
        abi.assertStruct(ParamMod, raw.clap_event_param_mod_t);
    }
}

pub const ParamGesture = extern struct {
    header: Header,
    param_id: Id,
};

test "ParamGesture ABI compatibility" {
    comptime {
        const raw = @import("raw");
        const abi = @import("abi.zig");
        abi.assertStruct(ParamGesture, raw.clap_event_param_gesture_t);
    }
}

pub const Transport = extern struct {
    header: Header,
    flags: Flags,
    song_pos_beats: Beattime,
    song_pos_seconds: Sectime,
    tempo: f64,
    tempo_inc: f64,
    loop_start_beats: Beattime,
    loop_end_beats: Beattime,
    loop_start_seconds: Sectime,
    loop_end_seconds: Sectime,
    bar_start: Beattime,
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

test "Transport ABI compatibility" {
    comptime {
        const raw = @import("raw");
        const abi = @import("abi.zig");
        abi.assertStruct(Transport, raw.clap_event_transport_t);
    }
}

pub const Midi = extern struct {
    header: Header,
    port_index: u16,
    data: [3]u8,
};

test "Midi ABI compatibility" {
    comptime {
        const raw = @import("raw");
        const abi = @import("abi.zig");
        abi.assertStruct(Midi2, raw.clap_event_midi2_t);
    }
}

pub const MidiSysex = extern struct {
    header: Header,
    port_index: u16,
    buffer: [*]const u8,
    size: u32,
};

test "MidiSyex ABI compatibility" {
    comptime {
        const raw = @import("raw");
        const abi = @import("abi.zig");
        abi.assertStruct(MidiSysex, raw.clap_event_midi_sysex_t);
    }
}

pub const Midi2 = extern struct {
    header: Header,
    port_index: u16,
    data: [4]u32,
};

test "Midi2 ABI compatibility" {
    comptime {
        const raw = @import("raw");
        const abi = @import("abi.zig");
        abi.assertStruct(Midi2, raw.clap_event_midi2_t);
    }
}

pub const InputEvents = extern struct {
    ctx: *anyopaque,
    size: *const fn (list: *const InputEvents) callconv(.c) u32,
    get: *const fn (list: *const InputEvents, index: u32) callconv(.c) *const Header,
};

test "InputEvents ABI compatibility" {
    comptime {
        const raw = @import("raw");
        const abi = @import("abi.zig");
        abi.assertStruct(InputEvents, raw.clap_input_events_t);
        abi.assertFnPtr(@FieldType(InputEvents, "size"), @FieldType(raw.clap_input_events_t, "size"));
        abi.assertFnPtr(@FieldType(InputEvents, "get"), @FieldType(raw.clap_input_events_t, "get"));
    }
}

pub const OutputEvents = extern struct {
    ctx: *anyopaque,
    tryPush: *const fn (list: *const OutputEvents, event: *const Header) callconv(.c) bool,
};

test "OutputEvents ABI compatibility" {
    comptime {
        const raw = @import("raw");
        const abi = @import("abi.zig");
        abi.assertStruct(OutputEvents, raw.clap_output_events_t);
        abi.assertFnPtr(@FieldType(OutputEvents, "tryPush"), @FieldType(raw.clap_output_events_t, "try_push"));
    }
}
