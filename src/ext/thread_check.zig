const ClapHost = @import("../host.zig").Host;

pub const id = "clap.thread-check";

pub const Host = extern struct {
    isMainThread: *const fn (host: *const ClapHost) callconv(.c) bool,
    isAudioThread: *const fn (host: *const ClapHost) callconv(.c) bool,
};
