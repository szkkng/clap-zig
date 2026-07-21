const std = @import("std");
const assert = std.debug.assert;
const meta = std.meta;

pub fn assertType(comptime ZigType: type, comptime CType: type) void {
    if (ZigType == CType) return;

    const zig_type_info = @typeInfo(ZigType);
    const c_type_info = @typeInfo(CType);

    assert(meta.activeTag(zig_type_info) == meta.activeTag(c_type_info));

    switch (zig_type_info) {
        .int => |zig_int| assert(meta.eql(zig_int, c_type_info.int)),
        .float => |zig_float| assert(meta.eql(zig_float, c_type_info.float)),
        .@"struct" => assertStruct(ZigType, CType),
        .pointer => assertPtr(ZigType, CType),
        .optional => |zig_opt| assertType(zig_opt.child, c_type_info.optional.child),
        else => @compileError("unsupported"),
    }
}

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
        assert(@sizeOf(zig_field_type) == @sizeOf(c_field_type));
        assert(@offsetOf(ZigType, zig_field_name) == @offsetOf(CType, c_field_name));
    }
}

pub fn assertFnPtr(comptime ZigType: type, comptime CType: type) void {
    const zig_ptr = switch (@typeInfo(unwrapOptional(ZigType))) {
        .pointer => |p| p,
        else => @compileError("Expected a function pointer"),
    };
    const zig_fn = switch (@typeInfo(zig_ptr.child)) {
        .@"fn" => |f| f,
        else => @compileError("Expected a function pointer"),
    };
    const c_ptr = switch (@typeInfo(unwrapOptional(CType))) {
        .pointer => |p| p,
        else => @compileError("Expected a function pointer"),
    };
    const c_fn = switch (@typeInfo(c_ptr.child)) {
        .@"fn" => |f| f,
        else => @compileError("Expected a function pointer"),
    };

    assert(zig_fn.attrs.@"callconv".eql(.c));
    assert(c_fn.attrs.@"callconv".eql(.c));

    assert(zig_fn.param_types.len == c_fn.param_types.len);
    assertType(unwrapOptional(zig_fn.return_type.?), unwrapOptional(c_fn.return_type.?));

    inline for (zig_fn.param_types, c_fn.param_types) |zig_param_type, c_param_type| {
        assertType(zig_param_type.?, c_param_type.?);
    }
}

pub fn assertPtr(comptime ZigType: type, comptime CType: type) void {
    const zig_ptr = switch (@typeInfo(ZigType)) {
        .pointer => |p| p,
        else => @compileError("Expected a pointer"),
    };
    const c_ptr = switch (@typeInfo(CType)) {
        .pointer => |p| p,
        else => @compileError("Expected a pointer"),
    };

    assert(@sizeOf(ZigType) == @sizeOf(CType));
    assert(@alignOf(ZigType) == @alignOf(CType));

    if (zig_ptr.size != c_ptr.size) {
        assert(zig_ptr.size == .c or c_ptr.size == .c);
        assert(zig_ptr.size != .slice);
        assert(c_ptr.size != .slice);
    } else {
        assert(zig_ptr.attrs.@"allowzero" == c_ptr.attrs.@"allowzero");
    }

    assert(zig_ptr.attrs.@"const" == c_ptr.attrs.@"const");
    assertType(zig_ptr.child, c_ptr.child);
}

fn unwrapOptional(comptime T: type) type {
    return switch (@typeInfo(T)) {
        .optional => |optional| optional.child,
        else => T,
    };
}
