const std = @import("std");
const Translator = @import("translate_c").Translator;

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});
    const mod = b.addModule("clap_zig", .{
        .root_source_file = b.path("src/clap.zig"),
        .target = target,
        .optimize = optimize,
    });

    // The translate-c generated CLAP bindings are used only for tests.
    const test_step = b.step("test", "Run unit tests");
    const clap = b.dependency("clap", .{});
    const translate_c = b.dependency("translate_c", .{});
    const translator: Translator = .init(translate_c, .{
        .c_source_file = clap.path("include/clap/clap.h"),
        .target = target,
        .optimize = optimize,
    });
    const unit_tests = b.addTest(.{
        .root_module = b.createModule(.{
            .root_source_file = b.path("tests/root.zig"),
            .target = target,
            .optimize = optimize,
        }),
    });
    unit_tests.root_module.addImport("clap_zig", mod);
    unit_tests.root_module.addImport("raw", translator.mod);
    const run_unit_tests = b.addRunArtifact(unit_tests);
    test_step.dependOn(&run_unit_tests.step);
}
