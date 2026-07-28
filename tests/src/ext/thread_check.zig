const abi = @import("../abi.zig");
const clap = @import("clap_zig");
const raw = @import("raw");
const testing = @import("std").testing;

comptime {
    const Host = clap.ext.thread_check.Host;
    abi.assertStruct(Host, raw.clap_host_thread_check_t);
    abi.assertFnPtr(@FieldType(Host, "isMainThread"), @FieldType(raw.clap_host_thread_check_t, "is_main_thread"));
    abi.assertFnPtr(@FieldType(Host, "isAudioThread"), @FieldType(raw.clap_host_thread_check_t, "is_audio_thread"));
}

test "thread check identifier" {
    try testing.expectEqualStrings(raw.CLAP_EXT_THREAD_CHECK[0..], clap.ext.thread_check.id);
}
