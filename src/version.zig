pub const Version = extern struct {
    major: u32,
    minor: u32,
    revision: u32,

    pub const current: Version = .{
        .major = 1,
        .minor = 2,
        .revision = 10,
    };

    pub fn isCompatible(self: Version) bool {
        return self.major >= 1;
    }
};
