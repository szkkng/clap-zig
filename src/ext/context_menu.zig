const ClapPlugin = @import("../plugin.zig").Plugin;
const ClapHost = @import("../host.zig").Host;
const Id = @import("../id.zig").Id;

pub const id = "clap.context-menu/1";
pub const id_compat = "clap.context-menu.draft/0";

pub const Target = extern struct {
    kind: Kind,
    id: Id,

    pub const Kind = enum(u32) {
        global = 0,
        param = 1,
        _,
    };
};

pub const ItemKind = enum(u32) {
    entry,
    check_entry,
    separator,
    begin_submenu,
    end_submenu,
    title,
    _,
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

pub const ItemTitle = extern struct {
    title: [*:0]const u8,
    is_enabled: bool,
};

pub const Submenu = extern struct {
    label: [*:0]const u8,
    is_enabled: bool,
};

pub const Builder = extern struct {
    ctx: ?*anyopaque,
    addItem: *const fn (builder: *const Builder, item_kind: ItemKind, item_data: ?*const anyopaque) callconv(.c) bool,
    supports: *const fn (builder: *const Builder, item_kind: ItemKind) callconv(.c) bool,
};

pub const Plugin = extern struct {
    populate: *const fn (plugin: *const ClapPlugin, target: ?*const Target, builder: *const Builder) callconv(.c) bool,
    perform: *const fn (plugin: *const ClapPlugin, target: ?*const Target, action_id: Id) callconv(.c) bool,
};

pub const Host = extern struct {
    populate: *const fn (host: *const ClapHost, target: ?*const Target, builder: *const Builder) callconv(.c) bool,
    perform: *const fn (host: *const ClapHost, target: ?*const Target, action_id: Id) callconv(.c) bool,
    canPopup: *const fn (host: *const ClapHost) callconv(.c) bool,
    popup: *const fn (host: *const ClapHost, target: ?*const Target, screen_index: i32, x: i32, y: i32) callconv(.c) bool,
};
