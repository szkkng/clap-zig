pub const IStream = extern struct {
    ctx: ?*anyopaque,
    read: *const fn (stream: *const IStream, buffer: *anyopaque, size: u64) callconv(.c) i64,
};

pub const OStream = extern struct {
    ctx: ?*anyopaque,
    write: *const fn (stream: *const OStream, buffer: *const anyopaque, size: u64) callconv(.c) i64,
};
