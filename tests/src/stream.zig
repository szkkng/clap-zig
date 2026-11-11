const abi = @import("abi.zig");
const clap = @import("clap_zig");
const raw = @import("raw");

comptime {
    abi.assertCompatible(raw.clap_istream_t, clap.IStream);
    abi.assertCompatible(raw.clap_ostream_t, clap.OStream);
}
