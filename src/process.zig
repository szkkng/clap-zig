const event = @import("event.zig");
const Transport = event.Transport;
const InputEvents = event.InputEvents;
const OutputEvents = event.InputEvents;
const AudioBuffer = @import("audio_buffer.zig");

pub const Process = extern struct {
    pub const Status = enum(i32) {
        @"error" = 0,
        @"continue" = 1,
        continue_if_not_quiet = 2,
        tail = 3,
        sleep = 4,
    };

    steady_time: i64,
    frames_count: u32,
    transport: ?*const Transport,
    audio_inputs: [*]const AudioBuffer,
    audio_outputs: [*]AudioBuffer,
    audio_inputs_count: u32,
    audio_outputs_count: u32,
    in_events: *const InputEvents,
    out_events: *const OutputEvents,
};

comptime {
    const raw = @import("raw");
    const abi = @import("abi.zig");
    abi.assertStruct(Process, raw.clap_process_t);
}
