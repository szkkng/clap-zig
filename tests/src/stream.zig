const abi = @import("abi.zig");
const clap = @import("clap_zig");
const raw = @import("raw");

comptime {
    abi.assertStruct(clap.IStream, raw.clap_istream_t);
    abi.assertFnPtr(@FieldType(clap.IStream, "read"), @FieldType(raw.clap_istream_t, "read"));

    abi.assertStruct(clap.OStream, raw.clap_ostream_t);
    abi.assertFnPtr(@FieldType(clap.OStream, "write"), @FieldType(raw.clap_ostream_t, "write"));
}
