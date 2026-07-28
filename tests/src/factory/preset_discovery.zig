const abi = @import("../abi.zig");
const clap = @import("clap_zig");
const raw = @import("raw");
const testing = @import("std").testing;

comptime {
    const preset_discovery = clap.factory.preset_discovery;
    const MetadataReceiver = preset_discovery.MetadataReceiver;
    const RawMetadataReceiver = raw.clap_preset_discovery_metadata_receiver;

    abi.assertStruct(MetadataReceiver, RawMetadataReceiver);
    abi.assertFnPtr(@FieldType(MetadataReceiver, "onError"), @FieldType(RawMetadataReceiver, "on_error"));
    abi.assertFnPtr(@FieldType(MetadataReceiver, "beginPreset"), @FieldType(RawMetadataReceiver, "begin_preset"));
    abi.assertFnPtr(@FieldType(MetadataReceiver, "addPluginId"), @FieldType(RawMetadataReceiver, "add_plugin_id"));
    abi.assertFnPtr(@FieldType(MetadataReceiver, "setSoundpackId"), @FieldType(RawMetadataReceiver, "set_soundpack_id"));
    abi.assertFnPtr(@FieldType(MetadataReceiver, "setFlags"), @FieldType(RawMetadataReceiver, "set_flags"));
    abi.assertFnPtr(@FieldType(MetadataReceiver, "addCreator"), @FieldType(RawMetadataReceiver, "add_creator"));
    abi.assertFnPtr(@FieldType(MetadataReceiver, "setDescription"), @FieldType(RawMetadataReceiver, "set_description"));
    abi.assertFnPtr(@FieldType(MetadataReceiver, "setTimestamps"), @FieldType(RawMetadataReceiver, "set_timestamps"));
    abi.assertFnPtr(@FieldType(MetadataReceiver, "addFeature"), @FieldType(RawMetadataReceiver, "add_feature"));
    abi.assertFnPtr(@FieldType(MetadataReceiver, "addExtraInfo"), @FieldType(RawMetadataReceiver, "add_extra_info"));

    abi.assertStruct(preset_discovery.FileType, raw.clap_preset_discovery_filetype_t);
    abi.assertStruct(preset_discovery.Location, raw.clap_preset_discovery_location_t);
    abi.assertStruct(preset_discovery.Soundpack, raw.clap_preset_discovery_soundpack_t);
    abi.assertStruct(preset_discovery.Provider, raw.clap_preset_discovery_provider_t);
    abi.assertFnPtr(@FieldType(preset_discovery.Provider, "init"), @FieldType(raw.clap_preset_discovery_provider_t, "init"));
    abi.assertFnPtr(@FieldType(preset_discovery.Provider, "destroy"), @FieldType(raw.clap_preset_discovery_provider_t, "destroy"));
    abi.assertFnPtr(@FieldType(preset_discovery.Provider, "getMetadata"), @FieldType(raw.clap_preset_discovery_provider_t, "get_metadata"));
    abi.assertFnPtr(@FieldType(preset_discovery.Provider, "getExtension"), @FieldType(raw.clap_preset_discovery_provider_t, "get_extension"));
    abi.assertStruct(preset_discovery.Provider.Descriptor, raw.clap_preset_discovery_provider_descriptor_t);
    abi.assertStruct(preset_discovery.Indexer, raw.clap_preset_discovery_indexer_t);
    abi.assertFnPtr(@FieldType(preset_discovery.Indexer, "declareFiletype"), @FieldType(raw.clap_preset_discovery_indexer_t, "declare_filetype"));
    abi.assertFnPtr(@FieldType(preset_discovery.Indexer, "declareLocation"), @FieldType(raw.clap_preset_discovery_indexer_t, "declare_location"));
    abi.assertFnPtr(@FieldType(preset_discovery.Indexer, "declareSoundpack"), @FieldType(raw.clap_preset_discovery_indexer_t, "declare_soundpack"));
    abi.assertFnPtr(@FieldType(preset_discovery.Indexer, "getExtension"), @FieldType(raw.clap_preset_discovery_indexer_t, "get_extension"));
    abi.assertStruct(preset_discovery.Factory, raw.clap_preset_discovery_factory);
    abi.assertFnPtr(@FieldType(preset_discovery.Factory, "count"), @FieldType(raw.clap_preset_discovery_factory, "count"));
    abi.assertFnPtr(@FieldType(preset_discovery.Factory, "getDescriptor"), @FieldType(raw.clap_preset_discovery_factory, "get_descriptor"));
    abi.assertFnPtr(@FieldType(preset_discovery.Factory, "create"), @FieldType(raw.clap_preset_discovery_factory, "create"));
}

test "factory ids" {
    try testing.expectEqualStrings(raw.CLAP_PRESET_DISCOVERY_FACTORY_ID[0..], clap.factory.preset_discovery.Factory.id);
    try testing.expectEqualStrings(raw.CLAP_PRESET_DISCOVERY_FACTORY_ID_COMPAT[0..], clap.factory.preset_discovery.Factory.id_compat);
}

test "location kind" {
    const Kind = clap.factory.preset_discovery.Location.Kind;
    try testing.expectEqual(raw.CLAP_PRESET_DISCOVERY_LOCATION_FILE, @intFromEnum(Kind.file));
    try testing.expectEqual(raw.CLAP_PRESET_DISCOVERY_LOCATION_PLUGIN, @intFromEnum(Kind.plugin));
}

test "preset discovery flags" {
    const Flags = clap.factory.preset_discovery.Flags;
    try expectFlag(Flags, raw.CLAP_PRESET_DISCOVERY_IS_FACTORY_CONTENT, Flags{ .is_factory_content = true });
    try expectFlag(Flags, raw.CLAP_PRESET_DISCOVERY_IS_USER_CONTENT, Flags{ .is_user_content = true });
    try expectFlag(Flags, raw.CLAP_PRESET_DISCOVERY_IS_DEMO_CONTENT, Flags{ .is_demo_content = true });
    try expectFlag(Flags, raw.CLAP_PRESET_DISCOVERY_IS_FAVORITE, Flags{ .is_favorite = true });
}

fn expectFlag(comptime Flags: type, expected: anytype, actual: Flags) !void {
    try testing.expectEqual(
        @as(u32, @intCast(expected)),
        @as(u32, @bitCast(actual)),
    );
}
