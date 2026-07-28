const abi = @import("abi.zig");
const clap = @import("clap_zig");
const raw = @import("raw");

comptime {
    abi.assertStruct(clap.Plugin.Descriptor, raw.clap_plugin_descriptor_t);
    abi.assertStruct(clap.Plugin, raw.clap_plugin_t);
    abi.assertFnPtr(@FieldType(clap.Plugin, "init"), @FieldType(raw.clap_plugin_t, "init"));
    abi.assertFnPtr(@FieldType(clap.Plugin, "destroy"), @FieldType(raw.clap_plugin_t, "destroy"));
    abi.assertFnPtr(@FieldType(clap.Plugin, "activate"), @FieldType(raw.clap_plugin_t, "activate"));
    abi.assertFnPtr(@FieldType(clap.Plugin, "deactivate"), @FieldType(raw.clap_plugin_t, "deactivate"));
    abi.assertFnPtr(@FieldType(clap.Plugin, "startProcessing"), @FieldType(raw.clap_plugin_t, "start_processing"));
    abi.assertFnPtr(@FieldType(clap.Plugin, "stopProcessing"), @FieldType(raw.clap_plugin_t, "stop_processing"));
    abi.assertFnPtr(@FieldType(clap.Plugin, "reset"), @FieldType(raw.clap_plugin_t, "reset"));
    abi.assertFnPtr(@FieldType(clap.Plugin, "process"), @FieldType(raw.clap_plugin_t, "process"));
    abi.assertFnPtr(@FieldType(clap.Plugin, "getExtension"), @FieldType(raw.clap_plugin_t, "get_extension"));
    abi.assertFnPtr(@FieldType(clap.Plugin, "onMainThread"), @FieldType(raw.clap_plugin_t, "on_main_thread"));
}
