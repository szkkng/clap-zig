const abi = @import("../abi.zig");
const clap = @import("clap_zig");
const raw = @import("raw");
const testing = @import("std").testing;

comptime {
    const note_name = clap.ext.note_name;
    abi.assertStruct(note_name.NoteName, raw.clap_note_name_t);
    abi.assertStruct(note_name.Plugin, raw.clap_plugin_note_name_t);
    abi.assertFnPtr(@FieldType(note_name.Plugin, "count"), @FieldType(raw.clap_plugin_note_name_t, "count"));
    abi.assertFnPtr(@FieldType(note_name.Plugin, "get"), @FieldType(raw.clap_plugin_note_name_t, "get"));
    abi.assertStruct(note_name.Host, raw.clap_host_note_name_t);
    abi.assertFnPtr(@FieldType(note_name.Host, "changed"), @FieldType(raw.clap_host_note_name_t, "changed"));
}

test "note name identifier" {
    try testing.expectEqualStrings(raw.CLAP_EXT_NOTE_NAME[0..], clap.ext.note_name.id);
}
