const clap = @import("clap_zig");
const raw = @import("raw");
const testing = @import("std").testing;

test "string size constants" {
    try testing.expectEqual(raw.CLAP_NAME_SIZE, clap.name_size);
    try testing.expectEqual(raw.CLAP_PATH_SIZE, clap.path_size);
}
