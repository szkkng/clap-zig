# clap-zig

WIP: Zig bindings for [CLAP](https://github.com/free-audio/clap).

Draft headers are not supported.

## Usage

```bash
zig fetch --save https://codeberg.org/kengo/clap-zig.git
```

```zig
// Import the clap-zig module in your build function.
const clap = b.dependency("clap_zig", .{});
your_module.addImport("clap", clap.module("clap_zig"));
```

## License

MIT.
