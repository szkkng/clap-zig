const abi = @import("../abi.zig");
const clap = @import("clap_zig");
const raw = @import("raw");
const testing = @import("std").testing;

comptime {
    const preset_discovery = clap.factory.preset_discovery;
    abi.assertCompatible(raw.clap_preset_discovery_metadata_receiver, preset_discovery.MetadataReceiver);
    abi.assertCompatible(raw.clap_preset_discovery_filetype_t, preset_discovery.FileType);
    abi.assertCompatible(raw.clap_preset_discovery_location_t, preset_discovery.Location);
    abi.assertCompatible(raw.clap_preset_discovery_soundpack_t, preset_discovery.Soundpack);
    abi.assertCompatible(raw.clap_preset_discovery_provider_t, preset_discovery.Provider);
    abi.assertCompatible(raw.clap_preset_discovery_provider_descriptor_t, preset_discovery.Provider.Descriptor);
    abi.assertCompatible(raw.clap_preset_discovery_indexer_t, preset_discovery.Indexer);
    abi.assertCompatible(raw.clap_preset_discovery_factory, preset_discovery.Factory);
}

test "factory ids" {
    try testing.expectEqualStrings(raw.CLAP_PRESET_DISCOVERY_FACTORY_ID[0..], clap.factory.preset_discovery.id);
    try testing.expectEqualStrings(raw.CLAP_PRESET_DISCOVERY_FACTORY_ID_COMPAT[0..], clap.factory.preset_discovery.id_compat);
}

test "location kind" {
    const Kind = clap.factory.preset_discovery.Location.Kind;
    try testing.expectEqual(raw.CLAP_PRESET_DISCOVERY_LOCATION_FILE, @backingInt(Kind.file));
    try testing.expectEqual(raw.CLAP_PRESET_DISCOVERY_LOCATION_PLUGIN, @backingInt(Kind.plugin));
}

test "preset discovery flags" {
    const Flags = clap.factory.preset_discovery.Flags;
    try testing.expectEqual(raw.CLAP_PRESET_DISCOVERY_IS_FACTORY_CONTENT, @backingInt(Flags{ .is_factory_content = true }));
    try testing.expectEqual(raw.CLAP_PRESET_DISCOVERY_IS_USER_CONTENT, @backingInt(Flags{ .is_user_content = true }));
    try testing.expectEqual(raw.CLAP_PRESET_DISCOVERY_IS_DEMO_CONTENT, @backingInt(Flags{ .is_demo_content = true }));
    try testing.expectEqual(raw.CLAP_PRESET_DISCOVERY_IS_FAVORITE, @backingInt(Flags{ .is_favorite = true }));
}
