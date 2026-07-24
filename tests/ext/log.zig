const clap = @import("clap_zig");
const raw = @import("raw");
const testing = @import("std").testing;

test "log identifier" {
    try testing.expectEqualStrings(raw.CLAP_EXT_LOG[0..], clap.ext.log.id);
}

test "log severity" {
    const Severity = clap.ext.log.Severity;
    try testing.expectEqual(raw.CLAP_LOG_DEBUG, @intFromEnum(Severity.debug));
    try testing.expectEqual(raw.CLAP_LOG_INFO, @intFromEnum(Severity.info));
    try testing.expectEqual(raw.CLAP_LOG_WARNING, @intFromEnum(Severity.warning));
    try testing.expectEqual(raw.CLAP_LOG_ERROR, @intFromEnum(Severity.@"error"));
    try testing.expectEqual(raw.CLAP_LOG_FATAL, @intFromEnum(Severity.fatal));
    try testing.expectEqual(raw.CLAP_LOG_HOST_MISBEHAVING, @intFromEnum(Severity.host_misbehaving));
    try testing.expectEqual(raw.CLAP_LOG_PLUGIN_MISBEHAVING, @intFromEnum(Severity.plugin_misbehaving));
}
