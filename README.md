# clap-zig

Zig bindings for [CLAP](https://github.com/free-audio/clap) v1.2.10.

Draft headers are not supported.

## Requirements

- Zig v0.16.0

## Setup

Add clap-zig as a dependency:

```bash
zig fetch --save git+https://codeberg.org/kengo/clap-zig
```

Import `clap_zig` module in your `build.zig`:

```zig
const clap = b.dependency("clap_zig", .{});
your_module.addImport("clap", clap.module("clap_zig"));
```

## Usage

See the minimal gain example: [hello-clap-zig](https://codeberg.org/kengo/hello-clap-zig)

## License

MIT.
