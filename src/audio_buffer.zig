pub const AudioBuffer = extern struct {
    data32: ?[*][*]f32,
    data64: ?[*][*]f64,
    channel_count: u32,
    latency: u32,
    constant_mask: u64,
};

test "AudioBuffer ABI compatibility" {
    comptime {
        const raw = @import("raw");
        const abi = @import("abi.zig");
        abi.assertStruct(AudioBuffer, raw.clap_audio_buffer_t);
    }
}
