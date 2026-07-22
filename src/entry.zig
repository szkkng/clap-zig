const std = @import("std");
const version = @import("../version.zig");
const Version = version.Version;

pub const Entry = extern struct {
    clap_version: Version = .current,
    init: *const fn (plugin_path: [*:0]const u8) callconv(.c) bool,
    deinit: *const fn () callconv(.c) void,
    getFactory: *const fn (factory_id: [*:0]const u8) callconv(.c) ?*const anyopaque,
};

test "Entry ABI compatibility" {
    comptime {
        const abi = @import("../abi.zig");
        const raw = @import("raw");
        abi.assertStruct(Entry, raw.clap_plugin_entry_t);
        abi.assertFnPtr(
            @FieldType(Entry, "init"),
            @FieldType(raw.clap_plugin_entry_t, "init"),
        );
        abi.assertFnPtr(
            @FieldType(Entry, "deinit"),
            @FieldType(raw.clap_plugin_entry_t, "deinit"),
        );
        abi.assertFnPtr(
            @FieldType(Entry, "getFactory"),
            @FieldType(raw.clap_plugin_entry_t, "get_factory"),
        );
    }
}
