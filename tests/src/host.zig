const abi = @import("abi.zig");
const clap = @import("clap_zig");
const raw = @import("raw");

comptime {
    abi.assertStruct(clap.Host, raw.clap_host_t);
    abi.assertFnPtr(@FieldType(clap.Host, "getExtension"), @FieldType(raw.clap_host_t, "get_extension"));
    abi.assertFnPtr(@FieldType(clap.Host, "requestRestart"), @FieldType(raw.clap_host_t, "request_restart"));
    abi.assertFnPtr(@FieldType(clap.Host, "requestProcess"), @FieldType(raw.clap_host_t, "request_process"));
    abi.assertFnPtr(@FieldType(clap.Host, "requestCallback"), @FieldType(raw.clap_host_t, "request_callback"));
}
