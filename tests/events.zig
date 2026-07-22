const clap = @import("clap_zig");
const raw = @import("raw");
const testing = @import("std").testing;

test "event header type" {
    const Type = clap.event.Header.Type;
    try testing.expectEqual(raw.CLAP_EVENT_NOTE_ON, @intFromEnum(Type.note_on));
    try testing.expectEqual(raw.CLAP_EVENT_NOTE_OFF, @intFromEnum(Type.note_off));
    try testing.expectEqual(raw.CLAP_EVENT_NOTE_END, @intFromEnum(Type.note_end));
    try testing.expectEqual(raw.CLAP_EVENT_NOTE_EXPRESSION, @intFromEnum(Type.note_expression));
    try testing.expectEqual(raw.CLAP_EVENT_PARAM_VALUE, @intFromEnum(Type.param_value));
    try testing.expectEqual(raw.CLAP_EVENT_PARAM_MOD, @intFromEnum(Type.param_mod));
    try testing.expectEqual(raw.CLAP_EVENT_PARAM_GESTURE_BEGIN, @intFromEnum(Type.param_gesture_begin));
    try testing.expectEqual(raw.CLAP_EVENT_PARAM_GESTURE_END, @intFromEnum(Type.param_gesture_end));
    try testing.expectEqual(raw.CLAP_EVENT_TRANSPORT, @intFromEnum(Type.transport));
    try testing.expectEqual(raw.CLAP_EVENT_MIDI, @intFromEnum(Type.midi));
    try testing.expectEqual(raw.CLAP_EVENT_MIDI_SYSEX, @intFromEnum(Type.midi_sysex));
    try testing.expectEqual(raw.CLAP_EVENT_MIDI2, @intFromEnum(Type.midi2));
}

test "note expression id" {
    const Id = clap.event.NoteExpression.Id;
    try testing.expectEqual(raw.CLAP_NOTE_EXPRESSION_VOLUME, @intFromEnum(Id.volume));
    try testing.expectEqual(raw.CLAP_NOTE_EXPRESSION_PAN, @intFromEnum(Id.pan));
    try testing.expectEqual(raw.CLAP_NOTE_EXPRESSION_TUNING, @intFromEnum(Id.tuning));
    try testing.expectEqual(raw.CLAP_NOTE_EXPRESSION_VIBRATO, @intFromEnum(Id.vibrato));
    try testing.expectEqual(raw.CLAP_NOTE_EXPRESSION_EXPRESSION, @intFromEnum(Id.expression));
    try testing.expectEqual(raw.CLAP_NOTE_EXPRESSION_BRIGHTNESS, @intFromEnum(Id.brightness));
    try testing.expectEqual(raw.CLAP_NOTE_EXPRESSION_PRESSURE, @intFromEnum(Id.pressure));
}

test "transport flags" {
    const Flags = clap.event.Transport.Flags;
    try expectFlag(Flags, raw.CLAP_TRANSPORT_HAS_TEMPO, Flags{ .has_tempo = true });
    try expectFlag(Flags, raw.CLAP_TRANSPORT_HAS_BEATS_TIMELINE, Flags{ .has_beats_timeline = true });
    try expectFlag(Flags, raw.CLAP_TRANSPORT_HAS_SECONDS_TIMELINE, Flags{ .has_seconds_timeline = true });
    try expectFlag(Flags, raw.CLAP_TRANSPORT_HAS_TIME_SIGNATURE, Flags{ .has_time_signature = true });
    try expectFlag(Flags, raw.CLAP_TRANSPORT_IS_PLAYING, Flags{ .is_playing = true });
    try expectFlag(Flags, raw.CLAP_TRANSPORT_IS_RECORDING, Flags{ .is_recording = true });
    try expectFlag(Flags, raw.CLAP_TRANSPORT_IS_LOOP_ACTIVE, Flags{ .is_loop_active = true });
    try expectFlag(Flags, raw.CLAP_TRANSPORT_IS_WITHIN_PRE_ROLL, Flags{ .is_within_pre_roll = true });
}

fn expectFlag(comptime Flags: type, expected: anytype, actual: Flags) !void {
    try testing.expectEqual(
        @as(u32, @intCast(expected)),
        @as(u32, @bitCast(actual)),
    );
}
