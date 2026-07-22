pub const Version = extern struct {
    major: u32,
    minor: u32,
    revision: u32,

    pub const current: @This() = .{
        .major = 1,
        .minor = 2,
        .revision = 10,
    };
};

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
