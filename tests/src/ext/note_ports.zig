const clap = @import("clap_zig");
const raw = @import("raw");
const testing = @import("std").testing;

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
