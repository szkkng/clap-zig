pub const Version = extern struct {
    major: u32,
    minor: i32,
    revision: u32,

    pub const current: @This() = .{
        .major = 1,
        .minor = 2,
        .revision = 10,
    };
};

comptime {
    const raw = @import("raw.zig");
    const abi = @import("abi.zig");
    abi.assertStruct(Version, raw.clap_version_t);
}

pub fn lt(ver: Version) bool {
    const current = Version.current;
    return (current.major < ver.major) or
        ((ver.major == current.major) and (current.minor < ver.minor)) or
        ((ver.major == current.major) and (ver.minor == current.minor) and (current.revision < ver.revision));
}

pub fn eq(ver: Version) bool {
    const current = Version.current;
    return (current.major == ver.major) and (current.minor == ver.minor) and (current.revision == ver.revision);
}

pub fn ge(ver: Version) bool {
    return !lt(ver);
}

pub fn isCompatible(ver: Version) bool {
    return ver.major >= 1;
}

const testing = @import("std").testing;

test "current version is less than" {
    try testing.expect(lt(.{ .major = 99, .minor = 0, .revision = 0 }));
    try testing.expect(lt(.{ .major = Version.current.major, .minor = 99, .revision = 0 }));
    try testing.expect(lt(.{ .major = Version.current.major, .minor = Version.current.minor, .revision = 99 }));
    try testing.expect(!lt(.{ .major = 0, .minor = 99, .revision = 99 }));
    try testing.expect(!lt(Version.current));
}

test "current version is equal" {
    try testing.expect(eq(Version.current));
    try testing.expect(!eq(.{ .major = 0, .minor = 0, .revision = 0 }));
}

test "current version is greater than or equal" {
    try testing.expect(ge(Version.current));
    try testing.expect(ge(.{ .major = 0, .minor = 0, .revision = 0 }));
    try testing.expect(!ge(.{ .major = 99, .minor = 0, .revision = 0 }));
}

test "version compatibility" {
    try testing.expect(isCompatible(.{ .major = 1, .minor = 0, .revision = 0 }));
    try testing.expect(isCompatible(.{ .major = 99, .minor = 0, .revision = 0 }));
    try testing.expect(!isCompatible(.{ .major = 0, .minor = 99, .revision = 99 }));
}
