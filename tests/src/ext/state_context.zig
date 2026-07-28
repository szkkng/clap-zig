const abi = @import("../abi.zig");
const clap = @import("clap_zig");
const raw = @import("raw");
const testing = @import("std").testing;

comptime {
    const Plugin = clap.ext.state_context.Plugin;
    abi.assertStruct(Plugin, raw.clap_plugin_state_context_t);
    abi.assertFnPtr(@FieldType(Plugin, "save"), @FieldType(raw.clap_plugin_state_context_t, "save"));
    abi.assertFnPtr(@FieldType(Plugin, "load"), @FieldType(raw.clap_plugin_state_context_t, "load"));
}

test "state context identifier" {
    try testing.expectEqualStrings(raw.CLAP_EXT_STATE_CONTEXT[0..], clap.ext.state_context.id);
}

test "state context type" {
    const Type = clap.ext.state_context.Type;
    try testing.expectEqual(raw.CLAP_STATE_CONTEXT_FOR_PRESET, @intFromEnum(Type.preset));
    try testing.expectEqual(raw.CLAP_STATE_CONTEXT_FOR_DUPLICATE, @intFromEnum(Type.duplicate));
    try testing.expectEqual(raw.CLAP_STATE_CONTEXT_FOR_PROJECT, @intFromEnum(Type.project));
}
