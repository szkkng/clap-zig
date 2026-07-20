const std = @import("std");
// const Translator = @import("translate_c").Translator;

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});
    const mod = b.addModule("clap_zig", .{
        .root_source_file = b.path("src/root.zig"),
        .target = target,
        .optimize = optimize,
    });

    // The translate-c generated CLAP bindings are used only for ABI compatibility
    // checks against the hand-written bindings.
    const test_step = b.step("test", "Run unit tests");
    const unit_tests = b.addTest(.{
        .root_module = mod,
    });
    // translate-c is currently disabled because the translate-c package
    // following Zig 0.16 fails to generate bindings for the CLAP header.
    // The version following Zig 0.17 succeeds, but ZLS does not provide completion
    // for the generated file in this setup. Therefore, the generated bindings are
    // placed as src/raw.zig and imported directly so that ZLS can provide completion.
    // Re-enable translate-c when this situation improves.
    //
    // const clap = b.dependency("clap", .{});
    // const translate_c = b.dependency("translate_c", .{});
    // const translator: Translator = .init(translate_c, .{
    //     .c_source_file = clap.path("include/clap/clap.h"),
    //     .target = target,
    //     .optimize = optimize,
    // });
    // unit_tests.root_module.addImport("raw", translator.mod);
    const run_unit_tests = b.addRunArtifact(unit_tests);
    test_step.dependOn(&run_unit_tests.step);
}
