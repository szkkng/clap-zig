# clap-zig

Zig bindings for the [CLAP](https://github.com/free-audio/clap) audio plugin API.

Draft headers are not supported.

## Setup

Add clap-zig as a dependency:

For Zig 0.18.0-dev:

```bash
zig fetch --save git+https://github.com/szkkng/clap-zig
```

For Zig 0.17.x:

```bash
zig fetch --save git+https://github.com/szkkng/clap-zig#zig-0.17.x
```

Import the `clap_zig` module in your `build.zig`:

```zig
const clap = b.dependency("clap_zig", .{});
your_module.addImport("clap", clap.module("clap_zig"));
```

## Usage

See the minimal gain example: [hello-clap-zig](https://github.com/szkkng/hello-clap-zig)

## License

MIT.
