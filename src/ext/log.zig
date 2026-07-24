const root = @import("../root.zig");

pub const id = "clap.log";

pub const Severity = enum(i32) {
    debug = 0,
    info = 1,
    warning = 2,
    @"error" = 3,
    fatal = 4,
    host_misbehaving = 5,
    plugin_misbehaving = 6,
};

pub const Host = extern struct {
    log: *const fn (host: *const root.Host, severity: Severity, msg: [*:0]const u8) callconv(.c) void,
};
