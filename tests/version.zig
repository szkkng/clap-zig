const testing = @import("std").testing;
const clap = @import("clap_zig");
const version = clap.version;
const Version = version.Version;

test "current version is less than" {
    try testing.expect(version.lt(.{ .major = 99, .minor = 0, .revision = 0 }));
    try testing.expect(version.lt(.{ .major = Version.current.major, .minor = 99, .revision = 0 }));
    try testing.expect(version.lt(.{ .major = Version.current.major, .minor = Version.current.minor, .revision = 99 }));
    try testing.expect(!version.lt(.{ .major = 0, .minor = 99, .revision = 99 }));
    try testing.expect(!version.lt(Version.current));
}

test "current version is equal" {
    try testing.expect(version.eq(Version.current));
    try testing.expect(!version.eq(.{ .major = 0, .minor = 0, .revision = 0 }));
}

test "current version is greater than or equal" {
    try testing.expect(version.ge(Version.current));
    try testing.expect(version.ge(.{ .major = 0, .minor = 0, .revision = 0 }));
    try testing.expect(!version.ge(.{ .major = 99, .minor = 0, .revision = 0 }));
}

test "version compatibility" {
    try testing.expect(version.isCompatible(.{ .major = 1, .minor = 0, .revision = 0 }));
    try testing.expect(version.isCompatible(.{ .major = 99, .minor = 0, .revision = 0 }));
    try testing.expect(!version.isCompatible(.{ .major = 0, .minor = 99, .revision = 99 }));
}
