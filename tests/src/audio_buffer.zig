const abi = @import("abi.zig");
const clap = @import("clap_zig");
const raw = @import("raw");

comptime {
    abi.assertCompatible(raw.clap_audio_buffer_t, clap.AudioBuffer);
}
