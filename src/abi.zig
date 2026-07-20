const std = @import("std");
const assert = std.debug.assert;

pub fn assertStruct(comptime ZigType: type, comptime CType: type) void {
    const zig_type_info = @typeInfo(ZigType);
    const zig_struct = switch (zig_type_info) {
        .@"struct" => |s| s,
        else => @compileError("Not a struct"),
    };
    assert(zig_struct.layout == .@"extern");

    const c_type_info = @typeInfo(CType);
    const c_struct = switch (c_type_info) {
        .@"struct" => |s| s,
        else => @compileError("Not a struct"),
    };
    assert(c_struct.layout == .@"extern");

    assert(@sizeOf(ZigType) == @sizeOf(CType));
    assert(@alignOf(ZigType) == @alignOf(CType));
    assert(zig_struct.field_types.len == c_struct.field_types.len);

    inline for (
        zig_struct.field_types,
        zig_struct.field_names,
        c_struct.field_types,
        c_struct.field_names,
    ) |zig_field_type, zig_field_name, c_field_type, c_field_name| {
        assert(@sizeOf(zig_field_type) == @sizeOf(c_field_type));
        assert(@alignOf(zig_field_type) == @alignOf(c_field_type));
        assert(@offsetOf(ZigType, zig_field_name) == @offsetOf(CType, c_field_name));
    }
}
