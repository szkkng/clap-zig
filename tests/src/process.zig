const abi = @import("abi.zig");
const clap = @import("clap_zig");
const raw = @import("raw");
const testing = @import("std").testing;

comptime {
    abi.assertStruct(clap.Process, raw.clap_process_t);
}

test "process status" {
    try testing.expectEqual(raw.CLAP_PROCESS_ERROR, @backingInt(clap.Process.Status.@"error"));
    try testing.expectEqual(raw.CLAP_PROCESS_CONTINUE, @backingInt(clap.Process.Status.@"continue"));
    try testing.expectEqual(raw.CLAP_PROCESS_CONTINUE_IF_NOT_QUIET, @backingInt(clap.Process.Status.continue_if_not_quiet));
    try testing.expectEqual(raw.CLAP_PROCESS_TAIL, @backingInt(clap.Process.Status.tail));
    try testing.expectEqual(raw.CLAP_PROCESS_SLEEP, @backingInt(clap.Process.Status.sleep));
}
