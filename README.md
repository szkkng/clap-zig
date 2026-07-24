# clap-zig

WIP: Zig bindings for CLAP.

## Usage

```bash
zig fetch --save https://codeberg.org/kengo/clap-zig.git
```

```zig
// Import the clap-zig module in your build function.
const clap = b.dependency("clap_zig", .{});
your_module.addImport("clap", clap.module("clap_zig"));
```

## Status

Not implemented yet:
- ext/ambisonic
- ext/context-menu
- ext/gui
- ext/note-name
- ext/note-ports
- ext/param-indication
- ext/posix-fd-support
- ext/preset-load
- ext/remote-controls
- ext/surround
- ext/thread-pool

Draft headers are not supported.
