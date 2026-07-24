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
    assertStruct(clap.event.Transport, raw.clap_event_transport_t);

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

    assertStruct(clap.Plugin.Entry, raw.clap_plugin_entry_t);
    assertFnPtr(@FieldType(clap.Plugin.Entry, "init"), @FieldType(raw.clap_plugin_entry_t, "init"));
    assertFnPtr(@FieldType(clap.Plugin.Entry, "deinit"), @FieldType(raw.clap_plugin_entry_t, "deinit"));
    assertFnPtr(@FieldType(clap.Plugin.Entry, "getFactory"), @FieldType(raw.clap_plugin_entry_t, "get_factory"));

    assertStruct(clap.Plugin.Factory, raw.clap_plugin_factory_t);
    assertFnPtr(@FieldType(clap.Plugin.Factory, "getPluginCount"), @FieldType(raw.clap_plugin_factory_t, "get_plugin_count"));
    assertFnPtr(@FieldType(clap.Plugin.Factory, "getPluginDescriptor"), @FieldType(raw.clap_plugin_factory_t, "get_plugin_descriptor"));
    assertFnPtr(@FieldType(clap.Plugin.Factory, "createPlugin"), @FieldType(raw.clap_plugin_factory_t, "create_plugin"));

    assertStruct(clap.Plugin.Descriptor, raw.clap_plugin_descriptor_t);

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

    assertStruct(clap.event.InputEvents, raw.clap_input_events_t);
    assertFnPtr(@FieldType(clap.event.InputEvents, "size"), @FieldType(raw.clap_input_events_t, "size"));
    assertFnPtr(@FieldType(clap.event.InputEvents, "get"), @FieldType(raw.clap_input_events_t, "get"));

    assertStruct(clap.event.OutputEvents, raw.clap_output_events_t);
    assertFnPtr(@FieldType(clap.event.OutputEvents, "tryPush"), @FieldType(raw.clap_output_events_t, "try_push"));

    const ClapMetadataReceiver = clap.preset_discovery.MetadataReceiver;
    const RawMetadataReceiver = raw.clap_preset_discovery_metadata_receiver;
    assertStruct(ClapMetadataReceiver, RawMetadataReceiver);
    assertFnPtr(@FieldType(ClapMetadataReceiver, "onError"), @FieldType(RawMetadataReceiver, "on_error"));
    assertFnPtr(@FieldType(ClapMetadataReceiver, "beginPreset"), @FieldType(RawMetadataReceiver, "begin_preset"));
    assertFnPtr(@FieldType(ClapMetadataReceiver, "addPluginId"), @FieldType(RawMetadataReceiver, "add_plugin_id"));
    assertFnPtr(@FieldType(ClapMetadataReceiver, "setSoundpackId"), @FieldType(RawMetadataReceiver, "set_soundpack_id"));
    assertFnPtr(@FieldType(ClapMetadataReceiver, "setFlags"), @FieldType(RawMetadataReceiver, "set_flags"));
    assertFnPtr(@FieldType(ClapMetadataReceiver, "addCreator"), @FieldType(RawMetadataReceiver, "add_creator"));
    assertFnPtr(@FieldType(ClapMetadataReceiver, "setDescription"), @FieldType(RawMetadataReceiver, "set_description"));
    assertFnPtr(@FieldType(ClapMetadataReceiver, "setTimestamps"), @FieldType(RawMetadataReceiver, "set_timestamps"));
    assertFnPtr(@FieldType(ClapMetadataReceiver, "addFeature"), @FieldType(RawMetadataReceiver, "add_feature"));
    assertFnPtr(@FieldType(ClapMetadataReceiver, "addExtraInfo"), @FieldType(RawMetadataReceiver, "add_extra_info"));

    assertStruct(clap.preset_discovery.FileType, raw.clap_preset_discovery_filetype_t);
    assertStruct(clap.preset_discovery.Location, raw.clap_preset_discovery_location_t);
    assertStruct(clap.preset_discovery.Soundpack, raw.clap_preset_discovery_soundpack_t);
    assertStruct(clap.preset_discovery.Provider, raw.clap_preset_discovery_provider_t);
    assertFnPtr(@FieldType(clap.preset_discovery.Provider, "init"), @FieldType(raw.clap_preset_discovery_provider_t, "init"));
    assertFnPtr(@FieldType(clap.preset_discovery.Provider, "destroy"), @FieldType(raw.clap_preset_discovery_provider_t, "destroy"));
    assertFnPtr(@FieldType(clap.preset_discovery.Provider, "getMetadata"), @FieldType(raw.clap_preset_discovery_provider_t, "get_metadata"));
    assertFnPtr(@FieldType(clap.preset_discovery.Provider, "getExtension"), @FieldType(raw.clap_preset_discovery_provider_t, "get_extension"));
    assertStruct(clap.preset_discovery.Provider.Descriptor, raw.clap_preset_discovery_provider_descriptor_t);
    assertStruct(clap.preset_discovery.Indexer, raw.clap_preset_discovery_indexer_t);
    assertFnPtr(@FieldType(clap.preset_discovery.Indexer, "declareFiletype"), @FieldType(raw.clap_preset_discovery_indexer_t, "declare_filetype"));
    assertFnPtr(@FieldType(clap.preset_discovery.Indexer, "declareLocation"), @FieldType(raw.clap_preset_discovery_indexer_t, "declare_location"));
    assertFnPtr(@FieldType(clap.preset_discovery.Indexer, "declareSoundpack"), @FieldType(raw.clap_preset_discovery_indexer_t, "declare_soundpack"));
    assertFnPtr(@FieldType(clap.preset_discovery.Indexer, "getExtension"), @FieldType(raw.clap_preset_discovery_indexer_t, "get_extension"));
    assertStruct(clap.preset_discovery.Factory, raw.clap_preset_discovery_factory);
    assertFnPtr(@FieldType(clap.preset_discovery.Factory, "count"), @FieldType(raw.clap_preset_discovery_factory, "count"));
    assertFnPtr(@FieldType(clap.preset_discovery.Factory, "getDescriptor"), @FieldType(raw.clap_preset_discovery_factory, "get_descriptor"));
    assertFnPtr(@FieldType(clap.preset_discovery.Factory, "create"), @FieldType(raw.clap_preset_discovery_factory, "create"));

    assertStruct(clap.IStream, raw.clap_istream_t);
    assertFnPtr(@FieldType(clap.IStream, "read"), @FieldType(raw.clap_istream_t, "read"));

    assertStruct(clap.OStream, raw.clap_ostream_t);
    assertFnPtr(@FieldType(clap.OStream, "write"), @FieldType(raw.clap_ostream_t, "write"));

    assertStruct(clap.Color, raw.clap_color_t);
    assertStruct(clap.UniversalPluginId, raw.clap_universal_plugin_id_t);
    assert(clap.Timestamp == raw.clap_timestamp);
    assertStruct(clap.ext.audio_ports.Info, raw.clap_audio_port_info_t);
}

comptime {
    @setEvalBranchQuota(5000);

    const PluginAudioPorts = clap.ext.audio_ports.Plugin;
    assertStruct(PluginAudioPorts, raw.clap_plugin_audio_ports_t);
    assertFnPtr(@FieldType(PluginAudioPorts, "count"), @FieldType(raw.clap_plugin_audio_ports_t, "count"));
    assertFnPtr(@FieldType(PluginAudioPorts, "get"), @FieldType(raw.clap_plugin_audio_ports_t, "get"));

    const HostAudioPorts = clap.ext.audio_ports.Host;
    assertStruct(HostAudioPorts, raw.clap_host_audio_ports_t);
    assertFnPtr(@FieldType(HostAudioPorts, "isRescanFlagSupported"), @FieldType(raw.clap_host_audio_ports_t, "is_rescan_flag_supported"));
    assertFnPtr(@FieldType(HostAudioPorts, "rescan"), @FieldType(raw.clap_host_audio_ports_t, "rescan"));

    assertStruct(clap.ext.audio_ports_config.Config, raw.clap_audio_ports_config_t);

    const PluginAudioPortsConfig = clap.ext.audio_ports_config.Plugin;
    assertStruct(PluginAudioPortsConfig, raw.clap_plugin_audio_ports_config_t);
    assertFnPtr(@FieldType(PluginAudioPortsConfig, "count"), @FieldType(raw.clap_plugin_audio_ports_config_t, "count"));
    assertFnPtr(@FieldType(PluginAudioPortsConfig, "get"), @FieldType(raw.clap_plugin_audio_ports_config_t, "get"));
    assertFnPtr(@FieldType(PluginAudioPortsConfig, "select"), @FieldType(raw.clap_plugin_audio_ports_config_t, "select"));

    const PluginAudioPortsConfigInfo = clap.ext.audio_ports_config_info.Plugin;
    assertStruct(PluginAudioPortsConfigInfo, raw.clap_plugin_audio_ports_config_info_t);
    assertFnPtr(@FieldType(PluginAudioPortsConfigInfo, "currentConfig"), @FieldType(raw.clap_plugin_audio_ports_config_info_t, "current_config"));
    assertFnPtr(@FieldType(PluginAudioPortsConfigInfo, "get"), @FieldType(raw.clap_plugin_audio_ports_config_info_t, "get"));

    const HostAudioPortsConfig = clap.ext.audio_ports_config.Host;
    assertStruct(HostAudioPortsConfig, raw.clap_host_audio_ports_config_t);
    assertFnPtr(@FieldType(HostAudioPortsConfig, "rescan"), @FieldType(raw.clap_host_audio_ports_config_t, "rescan"));

    assertStruct(clap.ext.params.Info, raw.clap_param_info_t);

    assertStruct(clap.ext.params.Plugin, raw.clap_plugin_params_t);
    assertFnPtr(@FieldType(clap.ext.params.Plugin, "count"), @FieldType(raw.clap_plugin_params_t, "count"));
    assertFnPtr(@FieldType(clap.ext.params.Plugin, "getInfo"), @FieldType(raw.clap_plugin_params_t, "get_info"));
    assertFnPtr(@FieldType(clap.ext.params.Plugin, "valueToText"), @FieldType(raw.clap_plugin_params_t, "value_to_text"));
    assertFnPtr(@FieldType(clap.ext.params.Plugin, "textToValue"), @FieldType(raw.clap_plugin_params_t, "text_to_value"));
    assertFnPtr(@FieldType(clap.ext.params.Plugin, "flush"), @FieldType(raw.clap_plugin_params_t, "flush"));

    assertStruct(clap.ext.params.Host, raw.clap_host_params_t);
    assertFnPtr(@FieldType(clap.ext.params.Host, "rescan"), @FieldType(raw.clap_host_params_t, "rescan"));
    assertFnPtr(@FieldType(clap.ext.params.Host, "clear"), @FieldType(raw.clap_host_params_t, "clear"));
    assertFnPtr(@FieldType(clap.ext.params.Host, "requestFlush"), @FieldType(raw.clap_host_params_t, "request_flush"));

    assertStruct(clap.ext.audio_ports_activation.Plugin, raw.clap_plugin_audio_ports_activation_t);
    assertFnPtr(@FieldType(clap.ext.audio_ports_activation.Plugin, "canActivateWhileProcessing"), @FieldType(raw.clap_plugin_audio_ports_activation_t, "can_activate_while_processing"));
    assertFnPtr(@FieldType(clap.ext.audio_ports_activation.Plugin, "setActive"), @FieldType(raw.clap_plugin_audio_ports_activation_t, "set_active"));

    assertStruct(clap.ext.state.Plugin, raw.clap_plugin_state_t);
    assertFnPtr(@FieldType(clap.ext.state.Plugin, "save"), @FieldType(raw.clap_plugin_state_t, "save"));
    assertFnPtr(@FieldType(clap.ext.state.Plugin, "load"), @FieldType(raw.clap_plugin_state_t, "load"));

    assertStruct(clap.ext.state.Host, raw.clap_host_state_t);
    assertFnPtr(@FieldType(clap.ext.state.Host, "markDirty"), @FieldType(raw.clap_host_state_t, "mark_dirty"));

    assertStruct(clap.ext.configurable_audio_ports.ConfigurationRequest, raw.clap_audio_port_configuration_request);

    assertStruct(clap.ext.configurable_audio_ports.Plugin, raw.clap_plugin_configurable_audio_ports_t);
    assertFnPtr(@FieldType(clap.ext.configurable_audio_ports.Plugin, "canApplyConfiguration"), @FieldType(raw.clap_plugin_configurable_audio_ports_t, "can_apply_configuration"));
    assertFnPtr(@FieldType(clap.ext.configurable_audio_ports.Plugin, "applyConfiguration"), @FieldType(raw.clap_plugin_configurable_audio_ports_t, "apply_configuration"));

    assertStruct(clap.ext.event_registry.Host, raw.clap_host_event_registry_t);
    assertFnPtr(@FieldType(clap.ext.event_registry.Host, "query"), @FieldType(raw.clap_host_event_registry_t, "query"));

    assertStruct(clap.ext.latency.Plugin, raw.clap_plugin_latency_t);
    assertFnPtr(@FieldType(clap.ext.latency.Plugin, "get"), @FieldType(raw.clap_plugin_latency_t, "get"));

    assertStruct(clap.ext.latency.Host, raw.clap_host_latency_t);
    assertFnPtr(@FieldType(clap.ext.latency.Host, "changed"), @FieldType(raw.clap_host_latency_t, "changed"));

    assertStruct(clap.ext.log.Host, raw.clap_host_log_t);
    assertFnPtr(@FieldType(clap.ext.log.Host, "log"), @FieldType(raw.clap_host_log_t, "log"));

    assertStruct(clap.ext.tail.Plugin, raw.clap_plugin_tail_t);
    assertFnPtr(@FieldType(clap.ext.tail.Plugin, "get"), @FieldType(raw.clap_plugin_tail_t, "get"));

    assertStruct(clap.ext.tail.Host, raw.clap_host_tail_t);
    assertFnPtr(@FieldType(clap.ext.tail.Host, "changed"), @FieldType(raw.clap_host_tail_t, "changed"));

    assertStruct(clap.ext.state_context.Plugin, raw.clap_plugin_state_context_t);
    assertFnPtr(@FieldType(clap.ext.state_context.Plugin, "save"), @FieldType(raw.clap_plugin_state_context_t, "save"));
    assertFnPtr(@FieldType(clap.ext.state_context.Plugin, "load"), @FieldType(raw.clap_plugin_state_context_t, "load"));

    assertStruct(clap.ext.render.Plugin, raw.clap_plugin_render_t);
    assertFnPtr(@FieldType(clap.ext.render.Plugin, "hasHardRealtimeRequirement"), @FieldType(raw.clap_plugin_render_t, "has_hard_realtime_requirement"));
    assertFnPtr(@FieldType(clap.ext.render.Plugin, "set"), @FieldType(raw.clap_plugin_render_t, "set"));

    assertStruct(clap.ext.thread_check.Host, raw.clap_host_thread_check_t);
    assertFnPtr(@FieldType(clap.ext.thread_check.Host, "isMainThread"), @FieldType(raw.clap_host_thread_check_t, "is_main_thread"));
    assertFnPtr(@FieldType(clap.ext.thread_check.Host, "isAudioThread"), @FieldType(raw.clap_host_thread_check_t, "is_audio_thread"));

    assertStruct(clap.ext.timer_support.Plugin, raw.clap_plugin_timer_support_t);
    assertFnPtr(@FieldType(clap.ext.timer_support.Plugin, "onTimer"), @FieldType(raw.clap_plugin_timer_support_t, "on_timer"));

    assertStruct(clap.ext.timer_support.Host, raw.clap_host_timer_support_t);
    assertFnPtr(@FieldType(clap.ext.timer_support.Host, "registerTimer"), @FieldType(raw.clap_host_timer_support_t, "register_timer"));
    assertFnPtr(@FieldType(clap.ext.timer_support.Host, "unregisterTimer"), @FieldType(raw.clap_host_timer_support_t, "unregister_timer"));

    assertStruct(clap.ext.track_info.Info, raw.clap_track_info_t);
    assertStruct(clap.ext.track_info.Plugin, raw.clap_plugin_track_info_t);
    assertFnPtr(@FieldType(clap.ext.track_info.Plugin, "changed"), @FieldType(raw.clap_plugin_track_info_t, "changed"));
    assertStruct(clap.ext.track_info.Host, raw.clap_host_track_info_t);
    assertFnPtr(@FieldType(clap.ext.track_info.Host, "get"), @FieldType(raw.clap_host_track_info_t, "get"));

    assertStruct(clap.ext.voice_info.Info, raw.clap_voice_info_t);
    assertStruct(clap.ext.voice_info.Plugin, raw.clap_plugin_voice_info_t);
    assertFnPtr(@FieldType(clap.ext.voice_info.Plugin, "get"), @FieldType(raw.clap_plugin_voice_info_t, "get"));
    assertStruct(clap.ext.voice_info.Host, raw.clap_host_voice_info_t);
    assertFnPtr(@FieldType(clap.ext.voice_info.Host, "changed"), @FieldType(raw.clap_host_voice_info_t, "changed"));
}

// Check extern struct layout by comparing size, alignment,
// field count, field sizes, and offsets.
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
        assertPtr(zig_field_type, c_field_type);
        assert(@sizeOf(zig_field_type) == @sizeOf(c_field_type));
        assert(@offsetOf(ZigType, zig_field_name) == @offsetOf(CType, c_field_name));
    }
}

// Check callback ABI shape by comparing the C calling convention,
// parameter count, and size/alignment of parameters and the return value.
fn assertFnPtr(comptime ZigType: type, comptime CType: type) void {
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
