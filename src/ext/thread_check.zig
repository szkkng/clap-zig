const root = @import("../root.zig");

pub const id = "clap.thread-check";

pub const Host = extern struct {
    isMainThread: *const fn (host: *const root.Host) callconv(.c) bool,
    isAudioThread: *const fn (host: *const root.Host) callconv(.c) bool,
};
