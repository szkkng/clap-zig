const abi = @import("../abi.zig");
const clap = @import("clap_zig");
const raw = @import("raw");
const testing = @import("std").testing;

comptime {
    abi.assertCompatible(raw.clap_plugin_render_t, clap.ext.render.Plugin);
}

test "render identifier" {
    try testing.expectEqualStrings(raw.CLAP_EXT_RENDER[0..], clap.ext.render.id);
}

test "render mode" {
    const Mode = clap.ext.render.Mode;
    try testing.expectEqual(raw.CLAP_RENDER_REALTIME, @backingInt(Mode.realtime));
    try testing.expectEqual(raw.CLAP_RENDER_OFFLINE, @backingInt(Mode.offline));
}
