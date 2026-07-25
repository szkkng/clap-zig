const root = @import("../root.zig");
const Id = root.Id;

pub const id = "clap.context-menu/1";
pub const id_compat = "clap.context-menu.draft/0";

pub const Target = extern struct {
    kind: Kind,
    id: Id,

    pub const Kind = enum(u32) {
        global = 0,
        param = 1,
    };
};

pub const Item = struct {
    pub const Kind = enum(u32) {
        entry,
        check_entry,
        separator,
        begin_submenu,
        end_submenu,
        title,
    };

    pub const Title = extern struct {
        title: [*:0]const u8,
        is_enabled: bool,
    };
};

pub const Entry = extern struct {
    label: [*:0]const u8,
    is_enabled: bool,
    action_id: Id,
};

pub const CheckEntry = extern struct {
    label: [*:0]const u8,
    is_enabled: bool,
    is_checked: bool,
    action_id: Id,
};

pub const Submenu = extern struct {
    label: [*:0]const u8,
    is_enabled: bool,
};

pub const Builder = extern struct {
    ctx: ?*anyopaque,
    addItem: *const fn (builder: *const Builder, item_kind: Item.Kind, item_data: ?*const anyopaque) callconv(.c) bool,
    supports: *const fn (builder: *const Builder, item_kind: Item.Kind) callconv(.c) bool,
};

pub const Plugin = extern struct {
    populate: *const fn (
        plugin: *const root.Plugin,
        target: ?*const Target,
        builder: *const Builder,
    ) callconv(.c) bool,

    perform: *const fn (
        plugin: *const root.Plugin,
        target: ?*const Target,
        action_id: Id,
    ) callconv(.c) bool,
};

pub const Host = extern struct {
    populate: *const fn (
        host: *const root.Host,
        target: ?*const Target,
        builder: *const Builder,
    ) callconv(.c) bool,

    perform: *const fn (
        host: *const root.Host,
        target: ?*const Target,
        action_id: Id,
    ) callconv(.c) bool,

    canPopup: *const fn (host: *const root.Host) callconv(.c) bool,

    popup: *const fn (
        host: *const root.Host,
        target: ?*const Target,
        screen_index: i32,
        x: i32,
        y: i32,
    ) callconv(.c) bool,
};
