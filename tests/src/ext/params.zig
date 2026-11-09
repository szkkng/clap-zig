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
    try testing.expectEqual(raw.CLAP_PARAM_IS_STEPPED, @backingInt(Flags{ .is_stepped = true }));
    try testing.expectEqual(raw.CLAP_PARAM_IS_PERIODIC, @backingInt(Flags{ .is_periodic = true }));
    try testing.expectEqual(raw.CLAP_PARAM_IS_HIDDEN, @backingInt(Flags{ .is_hidden = true }));
    try testing.expectEqual(raw.CLAP_PARAM_IS_READONLY, @backingInt(Flags{ .is_readonly = true }));
    try testing.expectEqual(raw.CLAP_PARAM_IS_BYPASS, @backingInt(Flags{ .is_bypass = true }));
    try testing.expectEqual(raw.CLAP_PARAM_IS_AUTOMATABLE, @backingInt(Flags{ .is_automatable = true }));
    try testing.expectEqual(raw.CLAP_PARAM_IS_AUTOMATABLE_PER_NOTE_ID, @backingInt(Flags{ .is_automatable_per_note_id = true }));
    try testing.expectEqual(raw.CLAP_PARAM_IS_AUTOMATABLE_PER_KEY, @backingInt(Flags{ .is_automatable_per_key = true }));
    try testing.expectEqual(raw.CLAP_PARAM_IS_AUTOMATABLE_PER_CHANNEL, @backingInt(Flags{ .is_automatable_per_channel = true }));
    try testing.expectEqual(raw.CLAP_PARAM_IS_AUTOMATABLE_PER_PORT, @backingInt(Flags{ .is_automatable_per_port = true }));
    try testing.expectEqual(raw.CLAP_PARAM_IS_MODULATABLE, @backingInt(Flags{ .is_modulatable = true }));
    try testing.expectEqual(raw.CLAP_PARAM_IS_MODULATABLE_PER_NOTE_ID, @backingInt(Flags{ .is_modulatable_per_note_id = true }));
    try testing.expectEqual(raw.CLAP_PARAM_IS_MODULATABLE_PER_KEY, @backingInt(Flags{ .is_modulatable_per_key = true }));
    try testing.expectEqual(raw.CLAP_PARAM_IS_MODULATABLE_PER_CHANNEL, @backingInt(Flags{ .is_modulatable_per_channel = true }));
    try testing.expectEqual(raw.CLAP_PARAM_IS_MODULATABLE_PER_PORT, @backingInt(Flags{ .is_modulatable_per_port = true }));
    try testing.expectEqual(raw.CLAP_PARAM_REQUIRES_PROCESS, @backingInt(Flags{ .requires_process = true }));
    try testing.expectEqual(raw.CLAP_PARAM_IS_ENUM, @backingInt(Flags{ .is_enum = true }));
}

test "host params rescan flags" {
    const Flags = clap.ext.params.Host.RescanFlags;
    try testing.expectEqual(raw.CLAP_PARAM_RESCAN_VALUES, @backingInt(Flags{ .values = true }));
    try testing.expectEqual(raw.CLAP_PARAM_RESCAN_TEXT, @backingInt(Flags{ .text = true }));
    try testing.expectEqual(raw.CLAP_PARAM_RESCAN_INFO, @backingInt(Flags{ .info = true }));
    try testing.expectEqual(raw.CLAP_PARAM_RESCAN_ALL, @backingInt(Flags{ .all = true }));
}

test "host params clear flags" {
    const Flags = clap.ext.params.Host.ClearFlags;
    try testing.expectEqual(raw.CLAP_PARAM_CLEAR_ALL, @backingInt(Flags{ .all = true }));
    try testing.expectEqual(raw.CLAP_PARAM_CLEAR_AUTOMATIONS, @backingInt(Flags{ .automations = true }));
    try testing.expectEqual(raw.CLAP_PARAM_CLEAR_MODULATIONS, @backingInt(Flags{ .modulations = true }));
}
