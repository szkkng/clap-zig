const std = @import("std");
const clap = @import("clap_zig");
const raw = @import("raw");
const Factory = clap.plugin.Factory;

test "plugin factory id" {
    std.debug.assert(std.mem.eql(u8, Factory.id, raw.CLAP_PLUGIN_FACTORY_ID[0..]));
}
