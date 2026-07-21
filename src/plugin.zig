pub const Entry = @import("plugin/Entry.zig").Entry;
const Version = @import("version.zig").Version;

pub const Descriptor = extern struct {
    clap_version: Version,
    id: [*:0]const u8,
    name: [*:0]const u8,
    vendor: ?[*:0]const u8,
    url: ?[*:0]const u8,
    manual_url: ?[*:0]const u8,
    support_url: ?[*:0]const u8,
    version: ?[*:0]const u8,
    description: ?[*:0]const u8,
    features: ?[*:null]const ?[*:0]const u8,
};

comptime {
    abi.assertStruct(Descriptor, raw.clap_plugin_descriptor_t);
}

pub const Descriptor = extern struct {
    clap_version: Version,
    id: [*:0]const u8,
    name: [*:0]const u8,
    vendor: [*:0]const u8,
    url: [*:0]const u8,
    manual_url: [*:0]const u8,
    support_url: [*:0]const u8,
    version: [*:0]const u8,
    description: [*:0]const u8,
    features: [*:null]const ?[*:0]const u8,
};

comptime {
    abi.assertStruct(Descriptor, raw.clap_plugin_descriptor_t);
}


test {
    const std = @import("std");
    std.testing.refAllDecls(@This());
}
