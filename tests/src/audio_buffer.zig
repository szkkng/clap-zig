const abi = @import("abi.zig");
const clap = @import("clap_zig");
const raw = @import("raw");

comptime {
    abi.assertStruct(clap.AudioBuffer, raw.clap_audio_buffer_t);
}
