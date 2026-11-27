const abi = @import("../abi.zig");
const clap = @import("clap_zig");
const raw = @import("raw");

comptime {
    const tail = clap.ext.tail;
    abi.assertCompatible(raw.clap_plugin_tail_t, tail.Plugin);
    abi.assertCompatible(raw.clap_host_tail_t, tail.Host);
}

test "tail identifier" {
    try abi.expectEqualCString(&raw.CLAP_EXT_TAIL, clap.ext.tail.id);
}
