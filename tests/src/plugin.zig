const abi = @import("abi.zig");
const clap = @import("clap_zig");
const raw = @import("raw");

comptime {
    abi.assertCompatible(raw.clap_plugin_descriptor_t, clap.Plugin.Descriptor);
    abi.assertCompatible(raw.clap_plugin_t, clap.Plugin);
}
