const abi = @import("../abi.zig");
const clap = @import("clap_zig");
const raw = @import("raw");
const testing = @import("std").testing;

comptime {
    const note_ports = clap.ext.note_ports;
    abi.assertStruct(note_ports.Info, raw.clap_note_port_info_t);
    abi.assertStruct(note_ports.Plugin, raw.clap_plugin_note_ports_t);
    abi.assertFnPtr(@FieldType(note_ports.Plugin, "count"), @FieldType(raw.clap_plugin_note_ports_t, "count"));
    abi.assertFnPtr(@FieldType(note_ports.Plugin, "get"), @FieldType(raw.clap_plugin_note_ports_t, "get"));
    abi.assertStruct(note_ports.Host, raw.clap_host_note_ports_t);
    abi.assertFnPtr(@FieldType(note_ports.Host, "supportedDialects"), @FieldType(raw.clap_host_note_ports_t, "supported_dialects"));
    abi.assertFnPtr(@FieldType(note_ports.Host, "rescan"), @FieldType(raw.clap_host_note_ports_t, "rescan"));
}

test "note ports identifier" {
    try testing.expectEqualStrings(raw.CLAP_EXT_NOTE_PORTS[0..], clap.ext.note_ports.id);
}

test "note dialects" {
    const Dialects = clap.ext.note_ports.Dialects;
    try expectFlag(Dialects, raw.CLAP_NOTE_DIALECT_CLAP, .{ .clap = true });
    try expectFlag(Dialects, raw.CLAP_NOTE_DIALECT_MIDI, .{ .midi = true });
    try expectFlag(Dialects, raw.CLAP_NOTE_DIALECT_MIDI_MPE, .{ .midi_mpe = true });
    try expectFlag(Dialects, raw.CLAP_NOTE_DIALECT_MIDI2, .{ .midi2 = true });
}

test "note dialect" {
    const Dialect = clap.ext.note_ports.Dialect;
    try testing.expectEqual(raw.CLAP_NOTE_DIALECT_CLAP, @intFromEnum(Dialect.clap));
    try testing.expectEqual(raw.CLAP_NOTE_DIALECT_MIDI, @intFromEnum(Dialect.midi));
    try testing.expectEqual(raw.CLAP_NOTE_DIALECT_MIDI_MPE, @intFromEnum(Dialect.midi_mpe));
    try testing.expectEqual(raw.CLAP_NOTE_DIALECT_MIDI2, @intFromEnum(Dialect.midi2));
}

test "hsot rescan flags" {
    const Flags = clap.ext.note_ports.Host.RescanFlags;
    try expectFlag(Flags, raw.CLAP_NOTE_PORTS_RESCAN_ALL, .{ .all = true });
    try expectFlag(Flags, raw.CLAP_NOTE_PORTS_RESCAN_NAMES, .{ .names = true });
}

fn expectFlag(comptime Flags: type, expected: anytype, actual: Flags) !void {
    try testing.expectEqual(
        @as(u32, @intCast(expected)),
        @as(u32, @bitCast(actual)),
    );
}
