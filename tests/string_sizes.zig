const clap = @import("clap_zig");
const raw = @import("raw");
const testing = @import("std").testing;

test "string size constants" {
    try testing.expectEqual(clap.name_size, raw.CLAP_NAME_SIZE);
    try testing.expectEqual(clap.path_size, raw.CLAP_PATH_SIZE);
}
