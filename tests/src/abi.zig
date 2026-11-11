const std = @import("std");

pub fn assertCompatible(comptime CType: type, comptime ZigType: type) void {
    comptime {
        @setEvalBranchQuota(100_000);
        assertCompatibleInner(CType, ZigType, &.{});
    }
}

const TypePair = struct {
    c_type: type,
    zig_type: type,
};

fn assertCompatibleInner(
    comptime CType: type,
    comptime ZigType: type,
    comptime active_pairs: []const TypePair,
) void {
    inline for (active_pairs) |pair| {
        if (pair.c_type == CType and pair.zig_type == ZigType) return;
    }

    const pair: TypePair = .{ .c_type = CType, .zig_type = ZigType };
    const next_pairs = active_pairs ++ [_]TypePair{pair};
    const c_type_info = @typeInfo(CType);
    const zig_type_info = @typeInfo(ZigType);

    if (c_type_info != .@"fn" and
        c_type_info != .@"opaque" and
        zig_type_info != .@"fn" and
        zig_type_info != .@"opaque")
    {
        if (@sizeOf(CType) != @sizeOf(ZigType) or
            @alignOf(CType) != @alignOf(ZigType))
        {
            fail(pair, "type mismatch");
        }
    }

    switch (zig_type_info) {
        .@"struct" => |z| switch (z.layout) {
            .@"packed" => switch (c_type_info) {
                .int => |c| {
                    const z_int = @typeInfo(z.backing_integer.?).int;
                    if (c.signedness != z_int.signedness or c.bits != z_int.bits) {
                        fail(pair, "type mismatch");
                    }
                },
                else => fail(pair, "type mismatch"),
            },
            .@"extern" => switch (c_type_info) {
                .@"struct" => |c| {
                    if (c.layout != z.layout or c.field_types.len != z.field_types.len) {
                        fail(pair, "type mismatch");
                    }

                    inline for (
                        c.field_types,
                        c.field_names,
                        z.field_types,
                        z.field_names,
                    ) |c_type, c_name, z_type, z_name| {
                        if (@offsetOf(CType, c_name) != @offsetOf(ZigType, z_name)) {
                            fail(pair, "type mismatch");
                        }
                        assertCompatibleInner(c_type, z_type, next_pairs);
                    }
                },
                else => fail(pair, "type mismatch"),
            },
            .auto => fail(pair, "Zig structs must use extern or packed layout"),
        },
        .optional => |z_opt| switch (@typeInfo(z_opt.child)) {
            .pointer => assertCompatibleInner(CType, z_opt.child, next_pairs),
            else => fail(pair, "only pointer optionals are supported"),
        },
        .pointer => |z_ptr| switch (c_type_info) {
            .optional => |c_opt| switch (@typeInfo(c_opt.child)) {
                .pointer => assertCompatibleInner(c_opt.child, ZigType, next_pairs),
                else => fail(pair, "type mismatch"),
            },
            .pointer => |c_ptr| {
                if (@typeInfo(z_ptr.child) != .@"fn" and
                    c_ptr.attrs.@"const" != z_ptr.attrs.@"const")
                {
                    fail(pair, "type mismatch");
                }
                assertCompatibleInner(c_ptr.child, z_ptr.child, next_pairs);
            },
            else => fail(pair, "type mismatch"),
        },
        .@"fn" => |z_fn| switch (c_type_info) {
            .@"fn" => |c_fn| {
                if (!(c_fn.attrs.@"callconv".eql(.c) and z_fn.attrs.@"callconv".eql(.c))) {
                    fail(pair, "functions must use the C calling convention");
                }
                if (c_fn.attrs.varargs != z_fn.attrs.varargs or
                    c_fn.param_types.len != z_fn.param_types.len)
                {
                    fail(pair, "type mismatch");
                }

                inline for (c_fn.param_types, z_fn.param_types) |c_type, z_type| {
                    assertCompatibleInner(c_type.?, z_type.?, next_pairs);
                }
                assertCompatibleInner(c_fn.return_type.?, z_fn.return_type.?, next_pairs);
            },
            else => fail(pair, "type mismatch"),
        },
        .@"enum" => |z| switch (c_type_info) {
            .int => |c| {
                const z_int = @typeInfo(z.tag_type).int;
                if (c.signedness != z_int.signedness or c.bits != z_int.bits) {
                    fail(pair, "type mismatch");
                }
            },
            else => fail(pair, "type mismatch"),
        },
        .int => |z| switch (c_type_info) {
            .int => |c| {
                if (c.signedness != z.signedness or c.bits != z.bits) {
                    fail(pair, "type mismatch");
                }
            },
            else => fail(pair, "type mismatch"),
        },
        .float => |z| switch (c_type_info) {
            .float => |c| {
                if (c.bits != z.bits) fail(pair, "type mismatch");
            },
            else => fail(pair, "type mismatch"),
        },
        .array => |z| switch (c_type_info) {
            .array => |c| {
                if (c.len != z.len) fail(pair, "type mismatch");
                assertCompatibleInner(c.child, z.child, next_pairs);
            },
            else => fail(pair, "type mismatch"),
        },
        .@"union" => |z| switch (c_type_info) {
            .@"union" => |c| {
                if (c.layout != .@"extern" or z.layout != .@"extern") {
                    fail(pair, "unions must use extern layout");
                }
                if (c.field_types.len != z.field_types.len) fail(pair, "type mismatch");
                inline for (c.field_types, z.field_types) |c_type, z_type| {
                    assertCompatibleInner(c_type, z_type, next_pairs);
                }
            },
            else => fail(pair, "type mismatch"),
        },
        .bool, .void, .@"opaque" => {
            if (CType != ZigType) fail(pair, "type mismatch");
        },
        else => fail(pair, "unsupported Zig type"),
    }
}

fn fail(comptime pair: TypePair, comptime reason: []const u8) noreturn {
    @compileError(std.fmt.comptimePrint(
        "ABI check failed: {s}\n  C: {s}\n  Zig: {s}",
        .{ reason, @typeName(pair.c_type), @typeName(pair.zig_type) },
    ));
}
