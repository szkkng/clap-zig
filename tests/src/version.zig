const abi = @import("abi.zig");
const clap = @import("clap_zig");
const raw = @import("raw");
const testing = @import("std").testing;

comptime {
    abi.assertStruct(clap.Version, raw.clap_version_t);
}

test "current version" {
    try testing.expectEqual(raw.CLAP_VERSION_MAJOR, clap.Version.current.major);
    try testing.expectEqual(raw.CLAP_VERSION_MINOR, clap.Version.current.minor);
    try testing.expectEqual(raw.CLAP_VERSION_REVISION, clap.Version.current.revision);
}

test "version compatibility" {
    const versions = [_]clap.Version{
        .{ .major = 0, .minor = 99, .revision = 99 },
        .{ .major = 1, .minor = 0, .revision = 0 },
        .{ .major = 2, .minor = 0, .revision = 0 },
    };

    for (versions) |version| {
        try testing.expectEqual(
            raw.clap_version_is_compatible(.{
                .major = version.major,
                .minor = version.minor,
                .revision = version.revision,
            }),
            version.isCompatible(),
        );
    }
}
