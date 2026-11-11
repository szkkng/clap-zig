const abi = @import("../abi.zig");
const clap = @import("clap_zig");
const raw = @import("raw");
const testing = @import("std").testing;

comptime {
    const timer_support = clap.ext.timer_support;
    abi.assertCompatible(raw.clap_plugin_timer_support_t, timer_support.Plugin);
    abi.assertCompatible(raw.clap_host_timer_support_t, timer_support.Host);
}

test "timer support identifier" {
    try testing.expectEqualStrings(raw.CLAP_EXT_TIMER_SUPPORT[0..], clap.ext.timer_support.id);
}
