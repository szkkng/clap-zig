const clap = @import("clap_zig");
const raw = @import("raw");
const testing = @import("std").testing;

test "param indication identifier" {
    try testing.expectEqualStrings(raw.CLAP_EXT_PARAM_INDICATION[0..], clap.ext.param_indication.id);
    try testing.expectEqualStrings(raw.CLAP_EXT_PARAM_INDICATION_COMPAT[0..], clap.ext.param_indication.id_compat);
}

test "automation state" {
    const AutomationState = clap.ext.param_indication.AutomationState;
    try testing.expectEqual(raw.CLAP_PARAM_INDICATION_AUTOMATION_NONE, @intFromEnum(AutomationState.none));
    try testing.expectEqual(raw.CLAP_PARAM_INDICATION_AUTOMATION_PRESENT, @intFromEnum(AutomationState.present));
    try testing.expectEqual(raw.CLAP_PARAM_INDICATION_AUTOMATION_PLAYING, @intFromEnum(AutomationState.playing));
    try testing.expectEqual(raw.CLAP_PARAM_INDICATION_AUTOMATION_OVERRIDING, @intFromEnum(AutomationState.overriding));
}
