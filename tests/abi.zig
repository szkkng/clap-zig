const std = @import("std");
const assert = std.debug.assert;
const meta = std.meta;
const clap = @import("clap_zig");
const raw = @import("raw");

comptime {
    @setEvalBranchQuota(5000);

    assertStruct(clap.Version, raw.clap_version_t);

    assertStruct(clap.Process, raw.clap_process_t);

    assertStruct(clap.AudioBuffer, raw.clap_audio_buffer_t);

    assertStruct(clap.Transport, raw.clap_event_transport_t);

    assertStruct(clap.Plugin, raw.clap_plugin_t);
    assertFnPtr(@FieldType(clap.Plugin, "init"), @FieldType(raw.clap_plugin_t, "init"));
    assertFnPtr(@FieldType(clap.Plugin, "destroy"), @FieldType(raw.clap_plugin_t, "destroy"));
    assertFnPtr(@FieldType(clap.Plugin, "activate"), @FieldType(raw.clap_plugin_t, "activate"));
    assertFnPtr(@FieldType(clap.Plugin, "startProcessing"), @FieldType(raw.clap_plugin_t, "start_processing"));
    assertFnPtr(@FieldType(clap.Plugin, "stopProcessing"), @FieldType(raw.clap_plugin_t, "stop_processing"));
    assertFnPtr(@FieldType(clap.Plugin, "reset"), @FieldType(raw.clap_plugin_t, "reset"));
    assertFnPtr(@FieldType(clap.Plugin, "process"), @FieldType(raw.clap_plugin_t, "process"));
    assertFnPtr(@FieldType(clap.Plugin, "getExtension"), @FieldType(raw.clap_plugin_t, "get_extension"));
    assertFnPtr(@FieldType(clap.Plugin, "onMainThread"), @FieldType(raw.clap_plugin_t, "on_main_thread"));

    assertStruct(clap.InputEvents, raw.clap_input_events_t);
    assertFnPtr(@FieldType(clap.InputEvents, "size"), @FieldType(raw.clap_input_events_t, "size"));
    assertFnPtr(@FieldType(clap.InputEvents, "get"), @FieldType(raw.clap_input_events_t, "get"));

    assertStruct(clap.OutputEvents, raw.clap_output_events_t);
    assertFnPtr(@FieldType(clap.OutputEvents, "tryPush"), @FieldType(raw.clap_output_events_t, "try_push"));

    assertStruct(clap.Host, raw.clap_host_t);
    assertFnPtr(@FieldType(clap.Host, "getExtension"), @FieldType(raw.clap_host_t, "get_extension"));
    assertFnPtr(@FieldType(clap.Host, "requestRestart"), @FieldType(raw.clap_host_t, "request_restart"));
    assertFnPtr(@FieldType(clap.Host, "requestProcess"), @FieldType(raw.clap_host_t, "request_process"));
    assertFnPtr(@FieldType(clap.Host, "requestCallback"), @FieldType(raw.clap_host_t, "request_callback"));

    assertStruct(clap.event.Header, raw.clap_event_header_t);

    assertStruct(clap.event.Note, raw.clap_event_note_t);

    assertStruct(clap.event.NoteExpression, raw.clap_event_note_expression_t);

    assertStruct(clap.event.ParamValue, raw.clap_event_param_value_t);

    assertStruct(clap.event.ParamMod, raw.clap_event_param_mod_t);

    assertStruct(clap.event.ParamGesture, raw.clap_event_param_gesture_t);

    assertStruct(clap.event.Midi, raw.clap_event_midi_t);

    assertStruct(clap.event.MidiSysex, raw.clap_event_midi_sysex_t);

    assertStruct(clap.event.Midi2, raw.clap_event_midi2_t);

    assertStruct(clap.plugin.Entry, raw.clap_plugin_entry_t);
    assertFnPtr(@FieldType(clap.plugin.Entry, "init"), @FieldType(raw.clap_plugin_entry_t, "init"));
    assertFnPtr(@FieldType(clap.plugin.Entry, "deinit"), @FieldType(raw.clap_plugin_entry_t, "deinit"));
    assertFnPtr(@FieldType(clap.plugin.Entry, "getFactory"), @FieldType(raw.clap_plugin_entry_t, "get_factory"));

    assertStruct(clap.plugin.Factory, raw.clap_plugin_factory_t);
    assertFnPtr(@FieldType(clap.plugin.Factory, "getPluginCount"), @FieldType(raw.clap_plugin_factory_t, "get_plugin_count"));
    assertFnPtr(@FieldType(clap.plugin.Factory, "getPluginDescriptor"), @FieldType(raw.clap_plugin_factory_t, "get_plugin_descriptor"));
    assertFnPtr(@FieldType(clap.plugin.Factory, "createPlugin"), @FieldType(raw.clap_plugin_factory_t, "create_plugin"));

    assertStruct(clap.plugin.Descriptor, raw.clap_plugin_descriptor_t);
}

fn assertStruct(comptime ZigType: type, comptime CType: type) void {
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

fn assertFnPtr(comptime ZigType: type, comptime CType: type) void {
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
    inline for (zig_fn.param_types, c_fn.param_types) |zig_param_type, c_param_type| {
        assertType(zig_param_type.?, c_param_type.?);
    }
}

fn unwrapOptional(comptime T: type) type {
    return switch (@typeInfo(T)) {
        .optional => |optional| optional.child,
        else => T,
    };
}

fn assertType(comptime ZigType: type, comptime CType: type) void {
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

fn assertPtr(comptime ZigType: type, comptime CType: type) void {
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
    assert(zig_ptr.attrs.@"const" == c_ptr.attrs.@"const");
    assertType(zig_ptr.child, c_ptr.child);
}
