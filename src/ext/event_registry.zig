const ClapHost = @import("../host.zig").Host;

pub const id = "clap.event-registry";

pub const Host = extern struct {
    query: *const fn (host: *const ClapHost, space_name: [*:0]const u8, space_id: *u16) callconv(.c) bool,
};
