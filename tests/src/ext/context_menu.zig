const abi = @import("../abi.zig");
const clap = @import("clap_zig");
const raw = @import("raw");
const testing = @import("std").testing;

comptime {
    const context_menu = clap.ext.context_menu;
    abi.assertStruct(context_menu.Target, raw.clap_context_menu_target_t);
    abi.assertStruct(context_menu.Entry, raw.clap_context_menu_entry_t);
    abi.assertStruct(context_menu.CheckEntry, raw.clap_context_menu_check_entry_t);
    abi.assertStruct(context_menu.Item.Title, raw.clap_context_menu_item_title_t);
    abi.assertStruct(context_menu.Submenu, raw.clap_context_menu_submenu_t);
    abi.assertStruct(context_menu.Builder, raw.clap_context_menu_builder_t);
    abi.assertFnPtr(@FieldType(context_menu.Builder, "addItem"), @FieldType(raw.clap_context_menu_builder_t, "add_item"));
    abi.assertFnPtr(@FieldType(context_menu.Builder, "supports"), @FieldType(raw.clap_context_menu_builder_t, "supports"));
    abi.assertStruct(context_menu.Plugin, raw.clap_plugin_context_menu_t);
    abi.assertFnPtr(@FieldType(context_menu.Plugin, "populate"), @FieldType(raw.clap_plugin_context_menu_t, "populate"));
    abi.assertFnPtr(@FieldType(context_menu.Plugin, "perform"), @FieldType(raw.clap_plugin_context_menu_t, "perform"));
    abi.assertStruct(context_menu.Host, raw.clap_host_context_menu_t);
    abi.assertFnPtr(@FieldType(context_menu.Host, "populate"), @FieldType(raw.clap_host_context_menu_t, "populate"));
    abi.assertFnPtr(@FieldType(context_menu.Host, "perform"), @FieldType(raw.clap_host_context_menu_t, "perform"));
    abi.assertFnPtr(@FieldType(context_menu.Host, "canPopup"), @FieldType(raw.clap_host_context_menu_t, "can_popup"));
    abi.assertFnPtr(@FieldType(context_menu.Host, "popup"), @FieldType(raw.clap_host_context_menu_t, "popup"));
}

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
