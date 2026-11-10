const abi = @import("abi.zig");
const clap = @import("clap_zig");
const raw = @import("raw");
const testing = @import("std").testing;

comptime {
    abi.assertStruct(clap.event.Header, raw.clap_event_header_t);
    abi.assertStruct(clap.event.Note, raw.clap_event_note_t);
    abi.assertStruct(clap.event.NoteExpression, raw.clap_event_note_expression_t);
    abi.assertStruct(clap.event.ParamValue, raw.clap_event_param_value_t);
    abi.assertStruct(clap.event.ParamMod, raw.clap_event_param_mod_t);
    abi.assertStruct(clap.event.ParamGesture, raw.clap_event_param_gesture_t);
    abi.assertStruct(clap.event.Transport, raw.clap_event_transport_t);
    abi.assertStruct(clap.event.Midi, raw.clap_event_midi_t);
    abi.assertStruct(clap.event.MidiSysex, raw.clap_event_midi_sysex_t);
    abi.assertStruct(clap.event.Midi2, raw.clap_event_midi2_t);

    abi.assertStruct(clap.event.InputEvents, raw.clap_input_events_t);
    abi.assertFnPtr(@FieldType(clap.event.InputEvents, "size"), @FieldType(raw.clap_input_events_t, "size"));
    abi.assertFnPtr(@FieldType(clap.event.InputEvents, "get"), @FieldType(raw.clap_input_events_t, "get"));

    abi.assertStruct(clap.event.OutputEvents, raw.clap_output_events_t);
    abi.assertFnPtr(@FieldType(clap.event.OutputEvents, "tryPush"), @FieldType(raw.clap_output_events_t, "try_push"));
}

test "core event space id" {
    try testing.expectEqual(raw.CLAP_CORE_EVENT_SPACE_ID, clap.event.core.space_id);
}

test "event header type" {
    const Type = clap.event.core.Type;
    try testing.expectEqual(raw.CLAP_EVENT_NOTE_ON, @backingInt(Type.note_on));
    try testing.expectEqual(raw.CLAP_EVENT_NOTE_OFF, @backingInt(Type.note_off));
    try testing.expectEqual(raw.CLAP_EVENT_NOTE_CHOKE, @backingInt(Type.note_choke));
    try testing.expectEqual(raw.CLAP_EVENT_NOTE_END, @backingInt(Type.note_end));
    try testing.expectEqual(raw.CLAP_EVENT_NOTE_EXPRESSION, @backingInt(Type.note_expression));
    try testing.expectEqual(raw.CLAP_EVENT_PARAM_VALUE, @backingInt(Type.param_value));
    try testing.expectEqual(raw.CLAP_EVENT_PARAM_MOD, @backingInt(Type.param_mod));
    try testing.expectEqual(raw.CLAP_EVENT_PARAM_GESTURE_BEGIN, @backingInt(Type.param_gesture_begin));
    try testing.expectEqual(raw.CLAP_EVENT_PARAM_GESTURE_END, @backingInt(Type.param_gesture_end));
    try testing.expectEqual(raw.CLAP_EVENT_TRANSPORT, @backingInt(Type.transport));
    try testing.expectEqual(raw.CLAP_EVENT_MIDI, @backingInt(Type.midi));
    try testing.expectEqual(raw.CLAP_EVENT_MIDI_SYSEX, @backingInt(Type.midi_sysex));
    try testing.expectEqual(raw.CLAP_EVENT_MIDI2, @backingInt(Type.midi2));
}

test "event header flags" {
    const Flags = clap.event.Header.Flags;
    try testing.expectEqual(raw.CLAP_EVENT_IS_LIVE, @backingInt(Flags{ .is_live = true }));
    try testing.expectEqual(raw.CLAP_EVENT_DONT_RECORD, @backingInt(Flags{ .dont_record = true }));
}

test "note expression id" {
    const Id = clap.event.NoteExpression.Id;
    try testing.expectEqual(raw.CLAP_NOTE_EXPRESSION_VOLUME, @backingInt(Id.volume));
    try testing.expectEqual(raw.CLAP_NOTE_EXPRESSION_PAN, @backingInt(Id.pan));
    try testing.expectEqual(raw.CLAP_NOTE_EXPRESSION_TUNING, @backingInt(Id.tuning));
    try testing.expectEqual(raw.CLAP_NOTE_EXPRESSION_VIBRATO, @backingInt(Id.vibrato));
    try testing.expectEqual(raw.CLAP_NOTE_EXPRESSION_EXPRESSION, @backingInt(Id.expression));
    try testing.expectEqual(raw.CLAP_NOTE_EXPRESSION_BRIGHTNESS, @backingInt(Id.brightness));
    try testing.expectEqual(raw.CLAP_NOTE_EXPRESSION_PRESSURE, @backingInt(Id.pressure));
}

test "transport flags" {
    const Flags = clap.event.Transport.Flags;
    try testing.expectEqual(raw.CLAP_TRANSPORT_HAS_TEMPO, @backingInt(Flags{ .has_tempo = true }));
    try testing.expectEqual(raw.CLAP_TRANSPORT_HAS_BEATS_TIMELINE, @backingInt(Flags{ .has_beats_timeline = true }));
    try testing.expectEqual(raw.CLAP_TRANSPORT_HAS_SECONDS_TIMELINE, @backingInt(Flags{ .has_seconds_timeline = true }));
    try testing.expectEqual(raw.CLAP_TRANSPORT_HAS_TIME_SIGNATURE, @backingInt(Flags{ .has_time_signature = true }));
    try testing.expectEqual(raw.CLAP_TRANSPORT_IS_PLAYING, @backingInt(Flags{ .is_playing = true }));
    try testing.expectEqual(raw.CLAP_TRANSPORT_IS_RECORDING, @backingInt(Flags{ .is_recording = true }));
    try testing.expectEqual(raw.CLAP_TRANSPORT_IS_LOOP_ACTIVE, @backingInt(Flags{ .is_loop_active = true }));
    try testing.expectEqual(raw.CLAP_TRANSPORT_IS_WITHIN_PRE_ROLL, @backingInt(Flags{ .is_within_pre_roll = true }));
}
