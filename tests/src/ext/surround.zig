const abi = @import("../abi.zig");
const clap = @import("clap_zig");
const raw = @import("raw");
const testing = @import("std").testing;

comptime {
    const surround = clap.ext.surround;
    abi.assertStruct(surround.Plugin, raw.clap_plugin_surround_t);
    abi.assertFnPtr(@FieldType(surround.Plugin, "isChannelMaskSupported"), @FieldType(raw.clap_plugin_surround_t, "is_channel_mask_supported"));
    abi.assertFnPtr(@FieldType(surround.Plugin, "getChannelMap"), @FieldType(raw.clap_plugin_surround_t, "get_channel_map"));
    abi.assertStruct(surround.Host, raw.clap_host_surround_t);
    abi.assertFnPtr(@FieldType(surround.Host, "changed"), @FieldType(raw.clap_host_surround_t, "changed"));
}

test "surround identifier" {
    try testing.expectEqualStrings(raw.CLAP_EXT_SURROUND[0..], clap.ext.surround.id);
    try testing.expectEqualStrings(raw.CLAP_EXT_SURROUND_COMPAT[0..], clap.ext.surround.id_compat);
    try testing.expectEqualStrings(raw.CLAP_PORT_SURROUND[0..], clap.ext.surround.port_type.surround);
}

test "surround channel" {
    const Channel = clap.ext.surround.Channel;
    try testing.expectEqual(raw.CLAP_SURROUND_FL, @backingInt(Channel.fl));
    try testing.expectEqual(raw.CLAP_SURROUND_FR, @backingInt(Channel.fr));
    try testing.expectEqual(raw.CLAP_SURROUND_FC, @backingInt(Channel.fc));
    try testing.expectEqual(raw.CLAP_SURROUND_LFE, @backingInt(Channel.lfe));
    try testing.expectEqual(raw.CLAP_SURROUND_BL, @backingInt(Channel.bl));
    try testing.expectEqual(raw.CLAP_SURROUND_BR, @backingInt(Channel.br));
    try testing.expectEqual(raw.CLAP_SURROUND_FLC, @backingInt(Channel.flc));
    try testing.expectEqual(raw.CLAP_SURROUND_FRC, @backingInt(Channel.frc));
    try testing.expectEqual(raw.CLAP_SURROUND_BC, @backingInt(Channel.bc));
    try testing.expectEqual(raw.CLAP_SURROUND_SL, @backingInt(Channel.sl));
    try testing.expectEqual(raw.CLAP_SURROUND_SR, @backingInt(Channel.sr));
    try testing.expectEqual(raw.CLAP_SURROUND_TC, @backingInt(Channel.tc));
    try testing.expectEqual(raw.CLAP_SURROUND_TFL, @backingInt(Channel.tfl));
    try testing.expectEqual(raw.CLAP_SURROUND_TFC, @backingInt(Channel.tfc));
    try testing.expectEqual(raw.CLAP_SURROUND_TFR, @backingInt(Channel.tfr));
    try testing.expectEqual(raw.CLAP_SURROUND_TBL, @backingInt(Channel.tbl));
    try testing.expectEqual(raw.CLAP_SURROUND_TBC, @backingInt(Channel.tbc));
    try testing.expectEqual(raw.CLAP_SURROUND_TBR, @backingInt(Channel.tbr));
    try testing.expectEqual(raw.CLAP_SURROUND_TSL, @backingInt(Channel.tsl));
    try testing.expectEqual(raw.CLAP_SURROUND_TSR, @backingInt(Channel.tsr));
}

test "surround channel mask" {
    const Channel = clap.ext.surround.Channel;
    const ChannelMask = clap.ext.surround.ChannelMask;
    try testing.expectEqual(@backingInt(ChannelMask{ .fl = true }), @as(u64, 1) << @backingInt(Channel.fl));
    try testing.expectEqual(@backingInt(ChannelMask{ .fr = true }), @as(u64, 1) << @backingInt(Channel.fr));
    try testing.expectEqual(@backingInt(ChannelMask{ .fc = true }), @as(u64, 1) << @backingInt(Channel.fc));
    try testing.expectEqual(@backingInt(ChannelMask{ .lfe = true }), @as(u64, 1) << @backingInt(Channel.lfe));
    try testing.expectEqual(@backingInt(ChannelMask{ .bl = true }), @as(u64, 1) << @backingInt(Channel.bl));
    try testing.expectEqual(@backingInt(ChannelMask{ .br = true }), @as(u64, 1) << @backingInt(Channel.br));
    try testing.expectEqual(@backingInt(ChannelMask{ .flc = true }), @as(u64, 1) << @backingInt(Channel.flc));
    try testing.expectEqual(@backingInt(ChannelMask{ .frc = true }), @as(u64, 1) << @backingInt(Channel.frc));
    try testing.expectEqual(@backingInt(ChannelMask{ .bc = true }), @as(u64, 1) << @backingInt(Channel.bc));
    try testing.expectEqual(@backingInt(ChannelMask{ .sl = true }), @as(u64, 1) << @backingInt(Channel.sl));
    try testing.expectEqual(@backingInt(ChannelMask{ .sr = true }), @as(u64, 1) << @backingInt(Channel.sr));
    try testing.expectEqual(@backingInt(ChannelMask{ .tc = true }), @as(u64, 1) << @backingInt(Channel.tc));
    try testing.expectEqual(@backingInt(ChannelMask{ .tfl = true }), @as(u64, 1) << @backingInt(Channel.tfl));
    try testing.expectEqual(@backingInt(ChannelMask{ .tfc = true }), @as(u64, 1) << @backingInt(Channel.tfc));
    try testing.expectEqual(@backingInt(ChannelMask{ .tfr = true }), @as(u64, 1) << @backingInt(Channel.tfr));
    try testing.expectEqual(@backingInt(ChannelMask{ .tbl = true }), @as(u64, 1) << @backingInt(Channel.tbl));
    try testing.expectEqual(@backingInt(ChannelMask{ .tbc = true }), @as(u64, 1) << @backingInt(Channel.tbc));
    try testing.expectEqual(@backingInt(ChannelMask{ .tbr = true }), @as(u64, 1) << @backingInt(Channel.tbr));
    try testing.expectEqual(@backingInt(ChannelMask{ .tsl = true }), @as(u64, 1) << @backingInt(Channel.tsl));
    try testing.expectEqual(@backingInt(ChannelMask{ .tsr = true }), @as(u64, 1) << @backingInt(Channel.tsr));
}
