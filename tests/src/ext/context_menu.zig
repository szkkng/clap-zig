const abi = @import("../abi.zig");
const clap = @import("clap_zig");
const raw = @import("raw");
const testing = @import("std").testing;

comptime {
    const context_menu = clap.ext.context_menu;
    abi.assertCompatible(raw.clap_context_menu_target_t, context_menu.Target);
    abi.assertCompatible(raw.clap_context_menu_entry_t, context_menu.Entry);
    abi.assertCompatible(raw.clap_context_menu_check_entry_t, context_menu.CheckEntry);
    abi.assertCompatible(raw.clap_context_menu_item_title_t, context_menu.ItemTitle);
    abi.assertCompatible(raw.clap_context_menu_submenu_t, context_menu.Submenu);
    abi.assertCompatible(raw.clap_context_menu_builder_t, context_menu.Builder);
    abi.assertCompatible(raw.clap_plugin_context_menu_t, context_menu.Plugin);
    abi.assertCompatible(raw.clap_host_context_menu_t, context_menu.Host);
}

test "context menu identifiers" {
    try testing.expectEqualStrings(raw.CLAP_EXT_CONTEXT_MENU[0..], clap.ext.context_menu.id);
    try testing.expectEqualStrings(raw.CLAP_EXT_CONTEXT_MENU_COMPAT[0..], clap.ext.context_menu.id_compat);
}

test "context menu target kind" {
    const TargetKind = clap.ext.context_menu.Target.Kind;
    try testing.expectEqual(raw.CLAP_CONTEXT_MENU_TARGET_KIND_GLOBAL, @backingInt(TargetKind.global));
    try testing.expectEqual(raw.CLAP_CONTEXT_MENU_TARGET_KIND_PARAM, @backingInt(TargetKind.param));
}

test "context menu item kind" {
    const ItemKind = clap.ext.context_menu.ItemKind;
    try testing.expectEqual(raw.CLAP_CONTEXT_MENU_ITEM_ENTRY, @backingInt(ItemKind.entry));
    try testing.expectEqual(raw.CLAP_CONTEXT_MENU_ITEM_CHECK_ENTRY, @backingInt(ItemKind.check_entry));
    try testing.expectEqual(raw.CLAP_CONTEXT_MENU_ITEM_SEPARATOR, @backingInt(ItemKind.separator));
    try testing.expectEqual(raw.CLAP_CONTEXT_MENU_ITEM_BEGIN_SUBMENU, @backingInt(ItemKind.begin_submenu));
    try testing.expectEqual(raw.CLAP_CONTEXT_MENU_ITEM_END_SUBMENU, @backingInt(ItemKind.end_submenu));
    try testing.expectEqual(raw.CLAP_CONTEXT_MENU_ITEM_TITLE, @backingInt(ItemKind.title));
}
