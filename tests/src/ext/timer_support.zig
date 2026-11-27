const abi = @import("../abi.zig");
const clap = @import("clap_zig");
const raw = @import("raw");

comptime {
    const timer_support = clap.ext.timer_support;
    abi.assertCompatible(raw.clap_plugin_timer_support_t, timer_support.Plugin);
    abi.assertCompatible(raw.clap_host_timer_support_t, timer_support.Host);
}

test "timer support identifier" {
    try abi.expectEqualCString(&raw.CLAP_EXT_TIMER_SUPPORT, clap.ext.timer_support.id);
}
