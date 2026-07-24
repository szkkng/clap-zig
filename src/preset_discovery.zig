const UniversalPluginId = @import("root.zig").UniversalPluginId;
const Timestamp = @import("root.zig").Timestamp;
const Version = @import("root.zig").Version;

pub const Flags = packed struct(u32) {
    is_factory_content: bool = false,
    is_user_content: bool = false,
    is_demo_content: bool = false,
    is_favorite: bool = false,
    _: u28 = 0,
};

pub const MetadataReceiver = extern struct {
    receiver_data: ?*anyopaque,
    onError: *const fn (receiver: *const MetadataReceiver, os_error: i32, error_message: [*:0]const u8) callconv(.c) void,
    beginPreset: *const fn (receiver: *const MetadataReceiver, name: ?[*:0]const u8, load_key: ?[*:0]const u8) callconv(.c) bool,
    addPluginId: *const fn (receiver: *const MetadataReceiver, plugin_id: *const UniversalPluginId) callconv(.c) void,
    setSoundpackId: *const fn (receiver: *const MetadataReceiver, soundpack_id: [*:0]const u8) callconv(.c) void,
    setFlags: *const fn (receiver: *const MetadataReceiver, flags: Flags) callconv(.c) void,
    addCreator: *const fn (receiver: *const MetadataReceiver, creator: [*:0]const u8) callconv(.c) void,
    setDescription: *const fn (receiver: *const MetadataReceiver, description: [*:0]const u8) callconv(.c) void,
    setTimestamps: *const fn (receiver: *const MetadataReceiver, creation_time: Timestamp, modification_time: Timestamp) callconv(.c) void,
    addFeature: *const fn (receiver: *const MetadataReceiver, feature: [*:0]const u8) callconv(.c) void,
    addExtraInfo: *const fn (receiver: *const MetadataReceiver, key: [*:0]const u8, value: [*:0]const u8) callconv(.c) void,
};

pub const FileType = extern struct {
    name: [*:0]const u8,
    description: ?[*:0]const u8,
    file_extension: ?[*:0]const u8,
};

pub const Location = extern struct {
    flags: Flags,
    name: [*:0]const u8,
    kind: Kind,
    location: ?[*:0]const u8,

    pub const Kind = enum(u32) {
        file = 0,
        plugin = 1,
    };
};

pub const Soundpack = extern struct {
    flags: Flags,
    id: [*:0]const u8,
    name: [*:0]const u8,
    description: ?[*:0]const u8,
    homepage_url: ?[*:0]const u8,
    vendor: ?[*:0]const u8,
    image_path: ?[*:0]const u8,
    release_timestamp: Timestamp,
};

pub const Provider = extern struct {
    desc: *const Descriptor,
    provider_data: *anyopaque,
    init: *const fn (provider: *const Provider) callconv(.c) bool,
    destroy: *const fn (provider: *const Provider) callconv(.c) void,
    getMetadata: *const fn (provider: *const Provider, location_kind: Location.Kind, location: ?[*:0]const u8, metadata_receiver: *const MetadataReceiver) callconv(.c) bool,
    getExtension: *const fn (provider: *const Provider, extension_id: [*:0]const u8) callconv(.c) ?*const anyopaque,

    pub const Descriptor = extern struct {
        clap_version: Version = .current,
        id: [*:0]const u8,
        name: [*:0]const u8,
        vendor: ?[*:0]const u8,
    };
};

pub const Indexer = extern struct {
    clap_version: Version = .current,
    name: [*:0]const u8,
    vendor: ?[*:0]const u8,
    url: ?[*:0]const u8,
    version: ?[*:0]const u8,
    indexer_data: *anyopaque,
    declareFiletype: *const fn (indexer: *const Indexer, filetype: *const FileType) callconv(.c) bool,
    declareLocation: *const fn (indexer: *const Indexer, location: *const Location) callconv(.c) bool,
    declareSoundpack: *const fn (indexer: *const Indexer, soundpack: *const Soundpack) callconv(.c) bool,
    getExtension: *const fn (indexer: *const Indexer, extension_id: [*:0]const u8) callconv(.c) ?*const anyopaque,
};

pub const Factory = extern struct {
    count: *const fn (factory: *const Factory) callconv(.c) u32,
    getDescriptor: *const fn (factory: *const Factory, index: u32) callconv(.c) ?*const Provider.Descriptor,
    create: *const fn (factory: *const Factory, indexer: *const Indexer, provider_id: [*:0]const u8) callconv(.c) ?*const Provider,

    pub const id = "clap.preset-discovery-factory/2";
    pub const id_compat = "clap.preset-discovery-factory/draft-2";
};
