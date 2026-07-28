const abi = @import("../abi.zig");
const clap = @import("clap_zig");
const raw = @import("raw");
const testing = @import("std").testing;

comptime {
    const tail = clap.ext.tail;
    abi.assertStruct(tail.Plugin, raw.clap_plugin_tail_t);
    abi.assertFnPtr(@FieldType(tail.Plugin, "get"), @FieldType(raw.clap_plugin_tail_t, "get"));
    abi.assertStruct(tail.Host, raw.clap_host_tail_t);
    abi.assertFnPtr(@FieldType(tail.Host, "changed"), @FieldType(raw.clap_host_tail_t, "changed"));
}

test "tail identifier" {
    try testing.expectEqualStrings(raw.CLAP_EXT_TAIL[0..], clap.ext.tail.id);
}
