const root = @import("../root.zig");
const Id = root.Id;
const name_size = root.name_size;

pub const id = "clap.remote-controls/2";
pub const id_compat = "clap.remote-controls.draft/2";
pub const count = 8;

pub const Page = extern struct {
    section_name: [name_size]u8,
    page_id: Id,
    page_name: [name_size]u8,
    param_ids: [count]Id,
    is_for_preset: bool,
};

pub const Plugin = extern struct {
    count: *const fn (plugin: *const root.Plugin) callconv(.c) u32,
    get: *const fn (plugin: *const root.Plugin, page_index: u32, page: *Page) callconv(.c) bool,
};

pub const Host = extern struct {
    changed: *const fn (host: *const root.Host) callconv(.c) void,
    suggestPage: *const fn (host: *const root.Host, page_id: Id) callconv(.c) void,
};
