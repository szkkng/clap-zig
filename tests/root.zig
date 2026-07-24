const raw = @import("raw");
const clap = @import("clap_zig");
const testing = @import("std").testing;

test {
    _ = @import("abi.zig");
    _ = @import("ext/audio_ports.zig");
    _ = @import("ext/audio_ports_config.zig");
    _ = @import("ext/audio_ports_activation.zig");
    _ = @import("ext/configurable_audio_ports.zig");
    _ = @import("ext/event_registry.zig");
    _ = @import("ext/params.zig");
    _ = @import("ext/render.zig");
    _ = @import("ext/state.zig");
    _ = @import("ext/state_context.zig");
    _ = @import("ext/latency.zig");
    _ = @import("ext/log.zig");
    _ = @import("ext/tail.zig");
}

test "factory ids" {
    try testing.expectEqualStrings(raw.CLAP_PRESET_DISCOVERY_FACTORY_ID[0..], clap.preset_discovery.Factory.id);
    try testing.expectEqualStrings(raw.CLAP_PRESET_DISCOVERY_FACTORY_ID_COMPAT[0..], clap.preset_discovery.Factory.id_compat);
}

test "location kind" {
    const Kind = clap.preset_discovery.Location.Kind;
    try testing.expectEqual(raw.CLAP_PRESET_DISCOVERY_LOCATION_FILE, @intFromEnum(Kind.file));
    try testing.expectEqual(raw.CLAP_PRESET_DISCOVERY_LOCATION_PLUGIN, @intFromEnum(Kind.plugin));
}

test "preset discovery flags" {
    const Flags = clap.preset_discovery.Flags;
    try expectFlag(Flags, raw.CLAP_PRESET_DISCOVERY_IS_FACTORY_CONTENT, Flags{ .is_factory_content = true });
    try expectFlag(Flags, raw.CLAP_PRESET_DISCOVERY_IS_USER_CONTENT, Flags{ .is_user_content = true });
    try expectFlag(Flags, raw.CLAP_PRESET_DISCOVERY_IS_DEMO_CONTENT, Flags{ .is_demo_content = true });
    try expectFlag(Flags, raw.CLAP_PRESET_DISCOVERY_IS_FAVORITE, Flags{ .is_favorite = true });
}

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

test "string size constants" {
    try testing.expectEqual(raw.CLAP_NAME_SIZE, clap.name_size);
    try testing.expectEqual(raw.CLAP_PATH_SIZE, clap.path_size);
}

test "fixed-point factors" {
    try testing.expectEqual(raw.CLAP_BEATTIME_FACTOR, clap.beat_time_factor);
    try testing.expectEqual(raw.CLAP_SECTIME_FACTOR, clap.sec_time_factor);
}

test "invalid_id matches CLAP_INVALID_ID" {
    try testing.expectEqual(raw.CLAP_INVALID_ID, clap.invalid_id);
}

test "timestamp unknown" {
    try testing.expectEqual(raw.CLAP_TIMESTAMP_UNKNOWN, clap.timestamp_unknown);
}

test "plugin factory id" {
    const Factory = clap.Plugin.Factory;
    try testing.expectEqualStrings(raw.CLAP_PLUGIN_FACTORY_ID[0..], Factory.id);
}

test "plugin feature IDs" {
    const feature = clap.Plugin.feature;
    try testing.expectEqualStrings(raw.CLAP_PLUGIN_FEATURE_INSTRUMENT, feature.instrument);
    try testing.expectEqualStrings(raw.CLAP_PLUGIN_FEATURE_AUDIO_EFFECT, feature.audio_effect);
    try testing.expectEqualStrings(raw.CLAP_PLUGIN_FEATURE_NOTE_EFFECT, feature.note_effect);
    try testing.expectEqualStrings(raw.CLAP_PLUGIN_FEATURE_NOTE_DETECTOR, feature.note_detector);
    try testing.expectEqualStrings(raw.CLAP_PLUGIN_FEATURE_ANALYZER, feature.analyzer);
    try testing.expectEqualStrings(raw.CLAP_PLUGIN_FEATURE_SYNTHESIZER, feature.synthesizer);
    try testing.expectEqualStrings(raw.CLAP_PLUGIN_FEATURE_SAMPLER, feature.sampler);
    try testing.expectEqualStrings(raw.CLAP_PLUGIN_FEATURE_DRUM, feature.drum);
    try testing.expectEqualStrings(raw.CLAP_PLUGIN_FEATURE_DRUM_MACHINE, feature.drum_machine);
    try testing.expectEqualStrings(raw.CLAP_PLUGIN_FEATURE_FILTER, feature.filter);
    try testing.expectEqualStrings(raw.CLAP_PLUGIN_FEATURE_PHASER, feature.phaser);
    try testing.expectEqualStrings(raw.CLAP_PLUGIN_FEATURE_EQUALIZER, feature.equalizer);
    try testing.expectEqualStrings(raw.CLAP_PLUGIN_FEATURE_DEESSER, feature.deesser);
    try testing.expectEqualStrings(raw.CLAP_PLUGIN_FEATURE_PHASE_VOCODER, feature.phase_vocoder);
    try testing.expectEqualStrings(raw.CLAP_PLUGIN_FEATURE_GRANULAR, feature.granular);
    try testing.expectEqualStrings(raw.CLAP_PLUGIN_FEATURE_FREQUENCY_SHIFTER, feature.frequency_shifter);
    try testing.expectEqualStrings(raw.CLAP_PLUGIN_FEATURE_PITCH_SHIFTER, feature.pitch_shifter);
    try testing.expectEqualStrings(raw.CLAP_PLUGIN_FEATURE_DISTORTION, feature.distortion);
    try testing.expectEqualStrings(raw.CLAP_PLUGIN_FEATURE_TRANSIENT_SHAPER, feature.transient_shaper);
    try testing.expectEqualStrings(raw.CLAP_PLUGIN_FEATURE_COMPRESSOR, feature.compressor);
    try testing.expectEqualStrings(raw.CLAP_PLUGIN_FEATURE_EXPANDER, feature.expander);
    try testing.expectEqualStrings(raw.CLAP_PLUGIN_FEATURE_GATE, feature.gate);
    try testing.expectEqualStrings(raw.CLAP_PLUGIN_FEATURE_LIMITER, feature.limiter);
    try testing.expectEqualStrings(raw.CLAP_PLUGIN_FEATURE_FLANGER, feature.flanger);
    try testing.expectEqualStrings(raw.CLAP_PLUGIN_FEATURE_CHORUS, feature.chorus);
    try testing.expectEqualStrings(raw.CLAP_PLUGIN_FEATURE_DELAY, feature.delay);
    try testing.expectEqualStrings(raw.CLAP_PLUGIN_FEATURE_REVERB, feature.reverb);
    try testing.expectEqualStrings(raw.CLAP_PLUGIN_FEATURE_TREMOLO, feature.tremolo);
    try testing.expectEqualStrings(raw.CLAP_PLUGIN_FEATURE_GLITCH, feature.glitch);
    try testing.expectEqualStrings(raw.CLAP_PLUGIN_FEATURE_UTILITY, feature.utility);
    try testing.expectEqualStrings(raw.CLAP_PLUGIN_FEATURE_PITCH_CORRECTION, feature.pitch_correction);
    try testing.expectEqualStrings(raw.CLAP_PLUGIN_FEATURE_RESTORATION, feature.restoration);
    try testing.expectEqualStrings(raw.CLAP_PLUGIN_FEATURE_MULTI_EFFECTS, feature.multi_effects);
    try testing.expectEqualStrings(raw.CLAP_PLUGIN_FEATURE_MIXING, feature.mixing);
    try testing.expectEqualStrings(raw.CLAP_PLUGIN_FEATURE_MASTERING, feature.mastering);
    try testing.expectEqualStrings(raw.CLAP_PLUGIN_FEATURE_MONO, feature.mono);
    try testing.expectEqualStrings(raw.CLAP_PLUGIN_FEATURE_STEREO, feature.stereo);
    try testing.expectEqualStrings(raw.CLAP_PLUGIN_FEATURE_SURROUND, feature.surround);
    try testing.expectEqualStrings(raw.CLAP_PLUGIN_FEATURE_AMBISONIC, feature.ambisonic);
}
