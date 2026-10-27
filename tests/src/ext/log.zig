const abi = @import("../abi.zig");
const clap = @import("clap_zig");
const raw = @import("raw");
const testing = @import("std").testing;

comptime {
    const Host = clap.ext.log.Host;
    abi.assertStruct(Host, raw.clap_host_log_t);
    abi.assertFnPtr(@FieldType(Host, "log"), @FieldType(raw.clap_host_log_t, "log"));
}

test "log identifier" {
    try testing.expectEqualStrings(raw.CLAP_EXT_LOG[0..], clap.ext.log.id);
}

test "log severity" {
    const Severity = clap.ext.log.Severity;
    try testing.expectEqual(raw.CLAP_LOG_DEBUG, @backingInt(Severity.debug));
    try testing.expectEqual(raw.CLAP_LOG_INFO, @backingInt(Severity.info));
    try testing.expectEqual(raw.CLAP_LOG_WARNING, @backingInt(Severity.warning));
    try testing.expectEqual(raw.CLAP_LOG_ERROR, @backingInt(Severity.@"error"));
    try testing.expectEqual(raw.CLAP_LOG_FATAL, @backingInt(Severity.fatal));
    try testing.expectEqual(raw.CLAP_LOG_HOST_MISBEHAVING, @backingInt(Severity.host_misbehaving));
    try testing.expectEqual(raw.CLAP_LOG_PLUGIN_MISBEHAVING, @backingInt(Severity.plugin_misbehaving));
}
