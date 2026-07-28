const abi = @import("../abi.zig");
const clap = @import("clap_zig");
const raw = @import("raw");
const testing = @import("std").testing;

comptime {
    const params = clap.ext.params;
    abi.assertStruct(params.Info, raw.clap_param_info_t);
    abi.assertStruct(params.Plugin, raw.clap_plugin_params_t);
    abi.assertFnPtr(@FieldType(params.Plugin, "count"), @FieldType(raw.clap_plugin_params_t, "count"));
    abi.assertFnPtr(@FieldType(params.Plugin, "getInfo"), @FieldType(raw.clap_plugin_params_t, "get_info"));
    abi.assertFnPtr(@FieldType(params.Plugin, "getValue"), @FieldType(raw.clap_plugin_params_t, "get_value"));
    abi.assertFnPtr(@FieldType(params.Plugin, "valueToText"), @FieldType(raw.clap_plugin_params_t, "value_to_text"));
    abi.assertFnPtr(@FieldType(params.Plugin, "textToValue"), @FieldType(raw.clap_plugin_params_t, "text_to_value"));
    abi.assertFnPtr(@FieldType(params.Plugin, "flush"), @FieldType(raw.clap_plugin_params_t, "flush"));
    abi.assertStruct(params.Host, raw.clap_host_params_t);
    abi.assertFnPtr(@FieldType(params.Host, "rescan"), @FieldType(raw.clap_host_params_t, "rescan"));
    abi.assertFnPtr(@FieldType(params.Host, "clear"), @FieldType(raw.clap_host_params_t, "clear"));
    abi.assertFnPtr(@FieldType(params.Host, "requestFlush"), @FieldType(raw.clap_host_params_t, "request_flush"));
}

test "params identifier" {
    try testing.expectEqualStrings(raw.CLAP_EXT_PARAMS[0..], clap.ext.params.id);
}

test "param info flags" {
    const Flags = clap.ext.params.Info.Flags;
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
    const Flags = clap.ext.params.Host.RescanFlags;
    try expectFlag(Flags, raw.CLAP_PARAM_RESCAN_VALUES, Flags{ .values = true });
    try expectFlag(Flags, raw.CLAP_PARAM_RESCAN_TEXT, Flags{ .text = true });
    try expectFlag(Flags, raw.CLAP_PARAM_RESCAN_INFO, Flags{ .info = true });
    try expectFlag(Flags, raw.CLAP_PARAM_RESCAN_ALL, Flags{ .all = true });
}

test "host params clear flags" {
    const Flags = clap.ext.params.Host.ClearFlags;
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
