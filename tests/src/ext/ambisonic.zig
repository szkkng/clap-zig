const abi = @import("../abi.zig");
const clap = @import("clap_zig");
const raw = @import("raw");
const testing = @import("std").testing;

comptime {
    const ambisonic = clap.ext.ambisonic;
    abi.assertCompatible(raw.clap_ambisonic_config_t, ambisonic.Config);
    abi.assertCompatible(raw.clap_plugin_ambisonic_t, ambisonic.Plugin);
    abi.assertCompatible(raw.clap_host_ambisonic_t, ambisonic.Host);
}

test "ambisonic identifiers" {
    try testing.expectEqualStrings(raw.CLAP_EXT_AMBISONIC[0..], clap.ext.ambisonic.id);
    try testing.expectEqualStrings(raw.CLAP_EXT_AMBISONIC_COMPAT[0..], clap.ext.ambisonic.id_compat);
    try testing.expectEqualStrings(raw.CLAP_PORT_AMBISONIC[0..], clap.ext.ambisonic.port_type.ambisonic);
}

test "ambisonic ordering" {
    const Ordering = clap.ext.ambisonic.Ordering;
    try testing.expectEqual(raw.CLAP_AMBISONIC_ORDERING_FUMA, @backingInt(Ordering.fuma));
    try testing.expectEqual(raw.CLAP_AMBISONIC_ORDERING_ACN, @backingInt(Ordering.acn));
}

test "ambisonic normalization" {
    const Normalization = clap.ext.ambisonic.Normalization;
    try testing.expectEqual(raw.CLAP_AMBISONIC_NORMALIZATION_MAXN, @backingInt(Normalization.maxn));
    try testing.expectEqual(raw.CLAP_AMBISONIC_NORMALIZATION_SN3D, @backingInt(Normalization.sn3d));
    try testing.expectEqual(raw.CLAP_AMBISONIC_NORMALIZATION_N3D, @backingInt(Normalization.n3d));
    try testing.expectEqual(raw.CLAP_AMBISONIC_NORMALIZATION_SN2D, @backingInt(Normalization.sn2d));
    try testing.expectEqual(raw.CLAP_AMBISONIC_NORMALIZATION_N2D, @backingInt(Normalization.n2d));
}
