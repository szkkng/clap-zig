const abi = @import("../abi.zig");
const clap = @import("clap_zig");
const raw = @import("raw");
const testing = @import("std").testing;

comptime {
    const note_name = clap.ext.note_name;
    abi.assertCompatible(raw.clap_note_name_t, note_name.NoteName);
    abi.assertCompatible(raw.clap_plugin_note_name_t, note_name.Plugin);
    abi.assertCompatible(raw.clap_host_note_name_t, note_name.Host);
}

test "note name identifier" {
    try testing.expectEqualStrings(raw.CLAP_EXT_NOTE_NAME[0..], clap.ext.note_name.id);
}
