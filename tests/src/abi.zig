const std = @import("std");
const assert = std.debug.assert;
const meta = std.meta;

// Check extern struct layout by comparing size, alignment,
// field count, field sizes, and offsets.
pub fn assertStruct(comptime ZigType: type, comptime CType: type) void {
    const zig_struct = switch (@typeInfo(ZigType)) {
        .@"struct" => |s| s,
        else => @compileError("Expected a struct"),
    };
    const c_struct = switch (@typeInfo(CType)) {
        .@"struct" => |s| s,
        else => @compileError("Expected a struct"),
    };

    assert(zig_struct.layout == .@"extern");
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
        assertPtr(zig_field_type, c_field_type);
        assert(@sizeOf(zig_field_type) == @sizeOf(c_field_type));
        assert(@offsetOf(ZigType, zig_field_name) == @offsetOf(CType, c_field_name));
    }
}

// Check callback ABI shape by comparing the C calling convention,
// parameter count, and size/alignment of parameters and the return value.
pub fn assertFnPtr(comptime ZigType: type, comptime CType: type) void {
    const zig_fn_ptr = switch (@typeInfo(unwrapOptional(ZigType))) {
        .pointer => |p| p,
        else => @compileError("Expected a function pointer"),
    };
    const zig_fn = switch (@typeInfo(zig_fn_ptr.child)) {
        .@"fn" => |f| f,
        else => @compileError("Expected a function pointer"),
    };
    const c_fn_ptr = switch (@typeInfo(unwrapOptional(CType))) {
        .pointer => |p| p,
        else => @compileError("Expected a function pointer"),
    };
    const c_fn = switch (@typeInfo(c_fn_ptr.child)) {
        .@"fn" => |f| f,
        else => @compileError("Expected a function pointer"),
    };

    assert(zig_fn.attrs.@"callconv".eql(.c));
    assert(c_fn.attrs.@"callconv".eql(.c));

    assert(@sizeOf(zig_fn.return_type.?) == @sizeOf(c_fn.return_type.?));
    assert(@alignOf(zig_fn.return_type.?) == @alignOf(c_fn.return_type.?));
    assert(zig_fn.param_types.len == c_fn.param_types.len);

    inline for (zig_fn.param_types, c_fn.param_types) |zig_param_type, c_param_type| {
        assertPtr(zig_param_type.?, c_param_type.?);
        assert(@sizeOf(zig_param_type.?) == @sizeOf(c_param_type.?));
        assert(@alignOf(zig_param_type.?) == @alignOf(c_param_type.?));
    }
}

fn assertPtr(comptime ZigType: type, comptime CType: type) void {
    const zig_type_info = @typeInfo(ZigType);
    const c_type_info = @typeInfo(CType);

    switch (zig_type_info) {
        .pointer => |zig_ptr| switch (c_type_info) {
            .pointer => |c_ptr| {
                assert(@sizeOf(zig_ptr.child) == @sizeOf(c_ptr.child));
                assert(@alignOf(zig_ptr.child) == @alignOf(c_ptr.child));
            },
            else => {},
        },
        .optional => |zig_opt| switch (@typeInfo(zig_opt.child)) {
            .pointer => switch (c_type_info) {
                .pointer => |c_ptr| assert(c_ptr.size == .c),
                else => {},
            },
            else => {},
        },
        else => {},
    }
}

fn unwrapOptional(comptime T: type) type {
    return switch (@typeInfo(T)) {
        .optional => |optional| optional.child,
        else => T,
    };
}
