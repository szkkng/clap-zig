const clap = @import("clap_zig");
const raw = @import("raw");
const testing = @import("std").testing;

test "context menu identifiers" {
    try testing.expectEqualStrings(raw.CLAP_EXT_CONTEXT_MENU[0..], clap.ext.context_menu.id);
    try testing.expectEqualStrings(raw.CLAP_EXT_CONTEXT_MENU_COMPAT[0..], clap.ext.context_menu.id_compat);
}

test "context menu target kind" {
    const TargetKind = clap.ext.context_menu.Target.Kind;
    try testing.expectEqual(raw.CLAP_CONTEXT_MENU_TARGET_KIND_GLOBAL, @intFromEnum(TargetKind.global));
    try testing.expectEqual(raw.CLAP_CONTEXT_MENU_TARGET_KIND_PARAM, @intFromEnum(TargetKind.param));
}

test "context menu item kind" {
    const ItemKind = clap.ext.context_menu.Item.Kind;
    try testing.expectEqual(raw.CLAP_CONTEXT_MENU_ITEM_ENTRY, @intFromEnum(ItemKind.entry));
    try testing.expectEqual(raw.CLAP_CONTEXT_MENU_ITEM_CHECK_ENTRY, @intFromEnum(ItemKind.check_entry));
    try testing.expectEqual(raw.CLAP_CONTEXT_MENU_ITEM_SEPARATOR, @intFromEnum(ItemKind.separator));
    try testing.expectEqual(raw.CLAP_CONTEXT_MENU_ITEM_BEGIN_SUBMENU, @intFromEnum(ItemKind.begin_submenu));
    try testing.expectEqual(raw.CLAP_CONTEXT_MENU_ITEM_END_SUBMENU, @intFromEnum(ItemKind.end_submenu));
    try testing.expectEqual(raw.CLAP_CONTEXT_MENU_ITEM_TITLE, @intFromEnum(ItemKind.title));
}
