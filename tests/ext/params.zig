const clap = @import("clap_zig");
const raw = @import("raw");
const testing = @import("std").testing;

test "params identifier" {
    try testing.expectEqualStrings(raw.CLAP_EXT_PARAMS[0..], clap.ext.params.id);
}

test "param info flags" {
    const Flags = clap.ext.params.ParamInfo.Flags;
    try expectFlag(Flags, raw.CLAP_PARAM_IS_STEPPED, Flags{ .is_stepped = true });
    try expectFlag(Flags, raw.CLAP_PARAM_IS_PERIODIC, Flags{ .is_periodic = true });
    try expectFlag(Flags, raw.CLAP_PARAM_IS_HIDDEN, Flags{ .is_hidden = true });
    try expectFlag(Flags, raw.CLAP_PARAM_IS_READONLY, Flags{ .is_readonly = true });
    try expectFlag(Flags, raw.CLAP_PARAM_IS_BYPASS, Flags{ .is_bypass = true });
    try expectFlag(Flags, raw.CLAP_PARAM_IS_AUTOMATABLE, Flags{ .is_automatable = true });
    try expectFlag(Flags, raw.CLAP_PARAM_IS_AUTOMATABLE_PER_NOTE_ID, Flags{ .is_automatable_per_note_id = true });
    try expectFlag(Flags, raw.CLAP_PARAM_IS_AUTOMATABLE_PER_KEY, Flags{ .is_automatable_per_key = true });
    try expectFlag(Flags, raw.CLAP_PARAM_IS_AUTOMATABLE_PER_CHANNEL, Flags{ .is_automatable_per_channel = true });
    try expectFlag(Flags, raw.CLAP_PARAM_IS_AUTOMATABLE_PER_PORT, Flags{ .is_automatable_per_port = true });
    try expectFlag(Flags, raw.CLAP_PARAM_IS_MODULATABLE, Flags{ .is_modulatable = true });
    try expectFlag(Flags, raw.CLAP_PARAM_IS_MODULATABLE_PER_NOTE_ID, Flags{ .is_modulatable_per_note_id = true });
    try expectFlag(Flags, raw.CLAP_PARAM_IS_MODULATABLE_PER_KEY, Flags{ .is_modulatable_per_key = true });
    try expectFlag(Flags, raw.CLAP_PARAM_IS_MODULATABLE_PER_CHANNEL, Flags{ .is_modulatable_per_channel = true });
    try expectFlag(Flags, raw.CLAP_PARAM_IS_MODULATABLE_PER_PORT, Flags{ .is_modulatable_per_port = true });
    try expectFlag(Flags, raw.CLAP_PARAM_REQUIRES_PROCESS, Flags{ .requires_process = true });
    try expectFlag(Flags, raw.CLAP_PARAM_IS_ENUM, Flags{ .is_enum = true });
}

test "host params rescan flags" {
    const Flags = clap.ext.params.HostParams.RescanFlags;
    try expectFlag(Flags, raw.CLAP_PARAM_RESCAN_VALUES, Flags{ .values = true });
    try expectFlag(Flags, raw.CLAP_PARAM_RESCAN_TEXT, Flags{ .text = true });
    try expectFlag(Flags, raw.CLAP_PARAM_RESCAN_INFO, Flags{ .info = true });
    try expectFlag(Flags, raw.CLAP_PARAM_RESCAN_ALL, Flags{ .all = true });
}

test "host params clear flags" {
    const Flags = clap.ext.params.HostParams.ClearFlags;
    try expectFlag(Flags, raw.CLAP_PARAM_CLEAR_ALL, Flags{ .all = true });
    try expectFlag(Flags, raw.CLAP_PARAM_CLEAR_AUTOMATIONS, Flags{ .automations = true });
    try expectFlag(Flags, raw.CLAP_PARAM_CLEAR_MODULATIONS, Flags{ .modulations = true });
}

fn expectFlag(comptime Flags: type, expected: anytype, actual: Flags) !void {
    try testing.expectEqual(
        @as(u32, @intCast(expected)),
        @as(u32, @bitCast(actual)),
    );
}
