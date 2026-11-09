const ClapPlugin = @import("../plugin.zig").Plugin;
const ClapHost = @import("../host.zig").Host;
const Id = @import("../id.zig").Id;
const name_size = @import("../string_sizes.zig").name_size;

pub const id = "clap.remote-controls/2";
pub const id_compat = "clap.remote-controls.draft/2";
pub const controls_per_page = 8;

pub const Page = extern struct {
    section_name: [name_size]u8,
    page_id: Id,
    page_name: [name_size]u8,
    param_ids: [controls_per_page]Id,
    is_for_preset: bool,
};

pub const Plugin = extern struct {
    count: *const fn (plugin: *const ClapPlugin) callconv(.c) u32,
    get: *const fn (plugin: *const ClapPlugin, page_index: u32, page: *Page) callconv(.c) bool,
};

pub const Host = extern struct {
    changed: *const fn (host: *const ClapHost) callconv(.c) void,
    suggestPage: *const fn (host: *const ClapHost, page_id: Id) callconv(.c) void,
};
