const Version = @import("version.zig").Version;

pub const Host = extern struct {
    clap_version: Version,
    host_data: *anyopaque,
    name: [*:0]const u8,
    vendor: [*:0]const u8,
    url: [*:0]const u8,
    version: [*:0]const u8,
    getExtension: *const fn (host: *const Host, extension_id: [*:0]const u8) callconv(.c) ?*const anyopaque,
    requestRestart: *const fn (host: *const Host) callconv(.c) void,
    requestProcess: *const fn (host: *const Host) callconv(.c) void,
    requestCallback: *const fn (host: *const Host) callconv(.c) void,
};

comptime {
    const raw = @import("raw");
    const abi = @import("abi.zig");
    abi.assertStruct(Host, raw.clap_host_t);
    abi.assertFnPtr(@FieldType(Host, "getExtension"), @FieldType(raw.clap_host_t, "get_extension"));
    abi.assertFnPtr(@FieldType(Host, "requestRestart"), @FieldType(raw.clap_host_t, "request_restart"));
    abi.assertFnPtr(@FieldType(Host, "requestProcess"), @FieldType(raw.clap_host_t, "request_process"));
    abi.assertFnPtr(@FieldType(Host, "requestCallback"), @FieldType(raw.clap_host_t, "request_callback"));
}
