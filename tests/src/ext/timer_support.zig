const abi = @import("../abi.zig");
const clap = @import("clap_zig");
const raw = @import("raw");
const testing = @import("std").testing;

comptime {
    const timer_support = clap.ext.timer_support;
    abi.assertStruct(timer_support.Plugin, raw.clap_plugin_timer_support_t);
    abi.assertFnPtr(@FieldType(timer_support.Plugin, "onTimer"), @FieldType(raw.clap_plugin_timer_support_t, "on_timer"));
    abi.assertStruct(timer_support.Host, raw.clap_host_timer_support_t);
    abi.assertFnPtr(@FieldType(timer_support.Host, "registerTimer"), @FieldType(raw.clap_host_timer_support_t, "register_timer"));
    abi.assertFnPtr(@FieldType(timer_support.Host, "unregisterTimer"), @FieldType(raw.clap_host_timer_support_t, "unregister_timer"));
}

test "timer support identifier" {
    try testing.expectEqualStrings(raw.CLAP_EXT_TIMER_SUPPORT[0..], clap.ext.timer_support.id);
}
