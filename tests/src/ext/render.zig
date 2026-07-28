const abi = @import("../abi.zig");
const clap = @import("clap_zig");
const raw = @import("raw");
const testing = @import("std").testing;

comptime {
    const Plugin = clap.ext.render.Plugin;
    abi.assertStruct(Plugin, raw.clap_plugin_render_t);
    abi.assertFnPtr(@FieldType(Plugin, "hasHardRealtimeRequirement"), @FieldType(raw.clap_plugin_render_t, "has_hard_realtime_requirement"));
    abi.assertFnPtr(@FieldType(Plugin, "set"), @FieldType(raw.clap_plugin_render_t, "set"));
}

test "render identifier" {
    try testing.expectEqualStrings(raw.CLAP_EXT_RENDER[0..], clap.ext.render.id);
}

test "render mode" {
    const Mode = clap.ext.render.Mode;
    try testing.expectEqual(raw.CLAP_RENDER_REALTIME, @intFromEnum(Mode.realtime));
    try testing.expectEqual(raw.CLAP_RENDER_OFFLINE, @intFromEnum(Mode.offline));
}
