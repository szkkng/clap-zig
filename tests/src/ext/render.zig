const clap = @import("clap_zig");
const raw = @import("raw");
const testing = @import("std").testing;

test "render identifier" {
    try testing.expectEqualStrings(raw.CLAP_EXT_RENDER[0..], clap.ext.render.id);
}

test "render mode" {
    const Mode = clap.ext.render.Mode;
    try testing.expectEqual(raw.CLAP_RENDER_REALTIME, @intFromEnum(Mode.realtime));
    try testing.expectEqual(raw.CLAP_RENDER_OFFLINE, @intFromEnum(Mode.offline));
}
