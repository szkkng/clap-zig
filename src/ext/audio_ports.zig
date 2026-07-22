const Plugin = @import("../plugin.zig").Plugin;
const Id = @import("../id.zig").Id;
const name_size = @import("../string_sizes.zig").name_size;
const Host = @import("../host.zig").Host;

pub const ext_audio_ports = "clap.audio-ports";
pub const port_mono = "mono";
pub const port_stereo = "stereo";

pub const AudioPortInfo = extern struct {
    pub const Flags = packed struct(u32) {
        /// This port is the main audio input or output.
        /// There can be only one main input and main output.
        /// Main port must be at index 0.
        is_main: bool = false,

        /// This port can be used with 64 bits audio
        supports_64bits: bool = false,

        /// 64 bits audio is preferred with this port
        prefers_64bits: bool = false,

        /// This port must be used with the same sample size as all the other ports which have this flag.
        /// In other words if all ports have this flag then the plugin may either be used entirely with
        /// 64 bits audio or 32 bits audio, but it can't be mixed.
        requires_common_sample_size: bool = false,

        _: u28 = 0,
    };

    id: Id,
    name: [name_size]u8,
    flags: Flags,
    channel_count: u32,
    port_type: ?[*:0]const u8,
    in_place_pair: Id,
};

pub const PluginAudioPorts = extern struct {
    count: *const fn (plugin: *const Plugin, is_input: bool) callconv(.c) u32,
    get: *const fn (plugin: *const Plugin, index: u32, is_input: bool, info: *AudioPortInfo) callconv(.c) bool,
};

pub const HostAudioPorts = extern struct {
    pub const RescanFlags = packed struct(u32) {
        /// The ports name did change, the host can scan them right away.
        names: bool = false,

        /// [!active] The flags did change
        flags: bool = false,

        /// [!active] The channel_count did change
        channel_count: bool = false,

        /// [!active] The port type did change
        port_type: bool = false,

        /// [!active] The in-place pair did change, this requires.
        in_place_pair: bool = false,

        /// [!active] The list of ports have changed: entries have been removed/added.
        list: bool = false,

        _: u26 = 0,
    };

    isRescanFlagSupported: *const fn (host: *const Host, flag: RescanFlags) callconv(.c) bool,
    rescan: *const fn (host: *const Host, flags: RescanFlags) callconv(.c) void,
};
