const clap = @import("clap_zig");
const raw = @import("raw");
const testing = @import("std").testing;

test "surround identifier" {
    try testing.expectEqualStrings(raw.CLAP_EXT_SURROUND[0..], clap.ext.surround.id);
    try testing.expectEqualStrings(raw.CLAP_EXT_SURROUND_COMPAT[0..], clap.ext.surround.id_compat);
    try testing.expectEqualStrings(raw.CLAP_PORT_SURROUND[0..], clap.ext.surround.port_type.surround);
}

test "surround channel" {
    const Channel = clap.ext.surround.Channel;
    try testing.expectEqual(raw.CLAP_SURROUND_FL, @intFromEnum(Channel.fl));
    try testing.expectEqual(raw.CLAP_SURROUND_FR, @intFromEnum(Channel.fr));
    try testing.expectEqual(raw.CLAP_SURROUND_FC, @intFromEnum(Channel.fc));
    try testing.expectEqual(raw.CLAP_SURROUND_LFE, @intFromEnum(Channel.lfe));
    try testing.expectEqual(raw.CLAP_SURROUND_BL, @intFromEnum(Channel.bl));
    try testing.expectEqual(raw.CLAP_SURROUND_BR, @intFromEnum(Channel.br));
    try testing.expectEqual(raw.CLAP_SURROUND_FLC, @intFromEnum(Channel.flc));
    try testing.expectEqual(raw.CLAP_SURROUND_FRC, @intFromEnum(Channel.frc));
    try testing.expectEqual(raw.CLAP_SURROUND_BC, @intFromEnum(Channel.bc));
    try testing.expectEqual(raw.CLAP_SURROUND_SL, @intFromEnum(Channel.sl));
    try testing.expectEqual(raw.CLAP_SURROUND_SR, @intFromEnum(Channel.sr));
    try testing.expectEqual(raw.CLAP_SURROUND_TC, @intFromEnum(Channel.tc));
    try testing.expectEqual(raw.CLAP_SURROUND_TFL, @intFromEnum(Channel.tfl));
    try testing.expectEqual(raw.CLAP_SURROUND_TFC, @intFromEnum(Channel.tfc));
    try testing.expectEqual(raw.CLAP_SURROUND_TFR, @intFromEnum(Channel.tfr));
    try testing.expectEqual(raw.CLAP_SURROUND_TBL, @intFromEnum(Channel.tbl));
    try testing.expectEqual(raw.CLAP_SURROUND_TBC, @intFromEnum(Channel.tbc));
    try testing.expectEqual(raw.CLAP_SURROUND_TBR, @intFromEnum(Channel.tbr));
    try testing.expectEqual(raw.CLAP_SURROUND_TSL, @intFromEnum(Channel.tsl));
    try testing.expectEqual(raw.CLAP_SURROUND_TSR, @intFromEnum(Channel.tsr));
}

test "surround channel mask" {
    const Channel = clap.ext.surround.Channel;
    const ChannelMask = clap.ext.surround.ChannelMask;
    try testing.expectEqual(@as(u64, @bitCast(ChannelMask{ .fl = true })), @as(u64, 1) << @intFromEnum(Channel.fl));
    try testing.expectEqual(@as(u64, @bitCast(ChannelMask{ .fr = true })), @as(u64, 1) << @intFromEnum(Channel.fr));
    try testing.expectEqual(@as(u64, @bitCast(ChannelMask{ .fc = true })), @as(u64, 1) << @intFromEnum(Channel.fc));
    try testing.expectEqual(@as(u64, @bitCast(ChannelMask{ .lfe = true })), @as(u64, 1) << @intFromEnum(Channel.lfe));
    try testing.expectEqual(@as(u64, @bitCast(ChannelMask{ .bl = true })), @as(u64, 1) << @intFromEnum(Channel.bl));
    try testing.expectEqual(@as(u64, @bitCast(ChannelMask{ .br = true })), @as(u64, 1) << @intFromEnum(Channel.br));
    try testing.expectEqual(@as(u64, @bitCast(ChannelMask{ .flc = true })), @as(u64, 1) << @intFromEnum(Channel.flc));
    try testing.expectEqual(@as(u64, @bitCast(ChannelMask{ .frc = true })), @as(u64, 1) << @intFromEnum(Channel.frc));
    try testing.expectEqual(@as(u64, @bitCast(ChannelMask{ .bc = true })), @as(u64, 1) << @intFromEnum(Channel.bc));
    try testing.expectEqual(@as(u64, @bitCast(ChannelMask{ .sl = true })), @as(u64, 1) << @intFromEnum(Channel.sl));
    try testing.expectEqual(@as(u64, @bitCast(ChannelMask{ .sr = true })), @as(u64, 1) << @intFromEnum(Channel.sr));
    try testing.expectEqual(@as(u64, @bitCast(ChannelMask{ .tc = true })), @as(u64, 1) << @intFromEnum(Channel.tc));
    try testing.expectEqual(@as(u64, @bitCast(ChannelMask{ .tfl = true })), @as(u64, 1) << @intFromEnum(Channel.tfl));
    try testing.expectEqual(@as(u64, @bitCast(ChannelMask{ .tfc = true })), @as(u64, 1) << @intFromEnum(Channel.tfc));
    try testing.expectEqual(@as(u64, @bitCast(ChannelMask{ .tfr = true })), @as(u64, 1) << @intFromEnum(Channel.tfr));
    try testing.expectEqual(@as(u64, @bitCast(ChannelMask{ .tbl = true })), @as(u64, 1) << @intFromEnum(Channel.tbl));
    try testing.expectEqual(@as(u64, @bitCast(ChannelMask{ .tbc = true })), @as(u64, 1) << @intFromEnum(Channel.tbc));
    try testing.expectEqual(@as(u64, @bitCast(ChannelMask{ .tbr = true })), @as(u64, 1) << @intFromEnum(Channel.tbr));
    try testing.expectEqual(@as(u64, @bitCast(ChannelMask{ .tsl = true })), @as(u64, 1) << @intFromEnum(Channel.tsl));
    try testing.expectEqual(@as(u64, @bitCast(ChannelMask{ .tsr = true })), @as(u64, 1) << @intFromEnum(Channel.tsr));
}
