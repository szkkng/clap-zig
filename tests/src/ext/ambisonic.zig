const abi = @import("../abi.zig");
const clap = @import("clap_zig");
const raw = @import("raw");
const testing = @import("std").testing;

comptime {
    const ambisonic = clap.ext.ambisonic;
    abi.assertStruct(ambisonic.Config, raw.clap_ambisonic_config_t);
    abi.assertStruct(ambisonic.Plugin, raw.clap_plugin_ambisonic_t);
    abi.assertFnPtr(@FieldType(ambisonic.Plugin, "isConfigSupported"), @FieldType(raw.clap_plugin_ambisonic_t, "is_config_supported"));
    abi.assertFnPtr(@FieldType(ambisonic.Plugin, "getConfig"), @FieldType(raw.clap_plugin_ambisonic_t, "get_config"));
    abi.assertStruct(ambisonic.Host, raw.clap_host_ambisonic_t);
    abi.assertFnPtr(@FieldType(ambisonic.Host, "changed"), @FieldType(raw.clap_host_ambisonic_t, "changed"));
}

test "ambisonic identifiers" {
    try testing.expectEqualStrings(raw.CLAP_EXT_AMBISONIC[0..], clap.ext.ambisonic.id);
    try testing.expectEqualStrings(raw.CLAP_EXT_AMBISONIC_COMPAT[0..], clap.ext.ambisonic.id_compat);
    try testing.expectEqualStrings(raw.CLAP_PORT_AMBISONIC[0..], clap.ext.ambisonic.port_type.ambisonic);
}

test "ambisonic ordering" {
    const Ordering = clap.ext.ambisonic.Ordering;
    try testing.expectEqual(raw.CLAP_AMBISONIC_ORDERING_FUMA, @intFromEnum(Ordering.fuma));
    try testing.expectEqual(raw.CLAP_AMBISONIC_ORDERING_ACN, @intFromEnum(Ordering.acn));
}

test "ambisonic normalization" {
    const Normalization = clap.ext.ambisonic.Normalization;
    try testing.expectEqual(raw.CLAP_AMBISONIC_NORMALIZATION_MAXN, @intFromEnum(Normalization.maxn));
    try testing.expectEqual(raw.CLAP_AMBISONIC_NORMALIZATION_SN3D, @intFromEnum(Normalization.sn3d));
    try testing.expectEqual(raw.CLAP_AMBISONIC_NORMALIZATION_N3D, @intFromEnum(Normalization.n3d));
    try testing.expectEqual(raw.CLAP_AMBISONIC_NORMALIZATION_SN2D, @intFromEnum(Normalization.sn2d));
    try testing.expectEqual(raw.CLAP_AMBISONIC_NORMALIZATION_N2D, @intFromEnum(Normalization.n2d));
}
