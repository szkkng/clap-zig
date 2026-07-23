const clap = @import("clap_zig");
const raw = @import("raw");
const testing = @import("std").testing;

test "factory ids" {
    try testing.expectEqualStrings(raw.CLAP_PRESET_DISCOVERY_FACTORY_ID[0..], clap.preset_discovery.Factory.id);
    try testing.expectEqualStrings(raw.CLAP_PRESET_DISCOVERY_FACTORY_ID_COMPAT[0..], clap.preset_discovery.Factory.id_compat);
}

test "location kind" {
    const Kind = clap.preset_discovery.Location.Kind;
    try testing.expectEqual(raw.CLAP_PRESET_DISCOVERY_LOCATION_FILE, @intFromEnum(Kind.file));
    try testing.expectEqual(raw.CLAP_PRESET_DISCOVERY_LOCATION_PLUGIN, @intFromEnum(Kind.plugin));
}

test "preset discovery flags" {
    const Flags = clap.preset_discovery.Flags;
    try expectFlag(Flags, raw.CLAP_PRESET_DISCOVERY_IS_FACTORY_CONTENT, Flags{ .is_factory_content = true });
    try expectFlag(Flags, raw.CLAP_PRESET_DISCOVERY_IS_USER_CONTENT, Flags{ .is_user_content = true });
    try expectFlag(Flags, raw.CLAP_PRESET_DISCOVERY_IS_DEMO_CONTENT, Flags{ .is_demo_content = true });
    try expectFlag(Flags, raw.CLAP_PRESET_DISCOVERY_IS_FAVORITE, Flags{ .is_favorite = true });
}

fn expectFlag(comptime Flags: type, expected: anytype, actual: Flags) !void {
    try testing.expectEqual(
        @as(u32, @intCast(expected)),
        @as(u32, @bitCast(actual)),
    );
}
