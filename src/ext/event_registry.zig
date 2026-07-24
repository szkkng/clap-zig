const root = @import("../root.zig");

pub const id = "clap.event-registry";

pub const Host = extern struct {
    query: *const fn (host: *const root.Host, space_name: [*:0]const u8, space_id: *u16) callconv(.c) bool,
};
