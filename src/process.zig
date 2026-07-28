const Transport = @import("events.zig").Transport;
const InputEvents = @import("events.zig").InputEvents;
const OutputEvents = @import("events.zig").OutputEvents;
const AudioBuffer = @import("audio_buffer.zig").AudioBuffer;

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
