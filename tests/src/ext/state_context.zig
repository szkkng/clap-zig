const abi = @import("../abi.zig");
const clap = @import("clap_zig");
const raw = @import("raw");
const testing = @import("std").testing;

comptime {
    abi.assertCompatible(raw.clap_plugin_state_context_t, clap.ext.state_context.Plugin);
}

test "state context identifier" {
    try testing.expectEqualStrings(raw.CLAP_EXT_STATE_CONTEXT[0..], clap.ext.state_context.id);
}

test "state context type" {
    const Type = clap.ext.state_context.Type;
    try testing.expectEqual(raw.CLAP_STATE_CONTEXT_FOR_PRESET, @backingInt(Type.preset));
    try testing.expectEqual(raw.CLAP_STATE_CONTEXT_FOR_DUPLICATE, @backingInt(Type.duplicate));
    try testing.expectEqual(raw.CLAP_STATE_CONTEXT_FOR_PROJECT, @backingInt(Type.project));
}
