const abi = @import("../abi.zig");
const clap = @import("clap_zig");
const raw = @import("raw");
const testing = @import("std").testing;

comptime {
    abi.assertCompatible(raw.clap_plugin_param_indication_t, clap.ext.param_indication.Plugin);
}

test "param indication identifier" {
    try testing.expectEqualStrings(raw.CLAP_EXT_PARAM_INDICATION[0..], clap.ext.param_indication.id);
    try testing.expectEqualStrings(raw.CLAP_EXT_PARAM_INDICATION_COMPAT[0..], clap.ext.param_indication.id_compat);
}

test "automation state" {
    const AutomationState = clap.ext.param_indication.AutomationState;
    try testing.expectEqual(raw.CLAP_PARAM_INDICATION_AUTOMATION_NONE, @backingInt(AutomationState.none));
    try testing.expectEqual(raw.CLAP_PARAM_INDICATION_AUTOMATION_PRESENT, @backingInt(AutomationState.present));
    try testing.expectEqual(raw.CLAP_PARAM_INDICATION_AUTOMATION_PLAYING, @backingInt(AutomationState.playing));
    try testing.expectEqual(raw.CLAP_PARAM_INDICATION_AUTOMATION_RECORDING, @backingInt(AutomationState.recording));
    try testing.expectEqual(raw.CLAP_PARAM_INDICATION_AUTOMATION_OVERRIDING, @backingInt(AutomationState.overriding));
}
