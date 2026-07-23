//! ## Notes on using streams
//!
//! When working with `clap_istream` and `clap_ostream` objects to load and save
//! state, it is important to keep in mind that the host may limit the number of
//! bytes that can be read or written at a time. The return values for the
//! stream read and write functions indicate how many bytes were actually read
//! or written. You need to use a loop to ensure that you read or write the
//! entirety of your state. Don't forget to also consider the negative return
//! values for the end of file and IO error codes.

pub const IStream = extern struct {
    ctx: *anyopaque, // reserved pointer for the stream

    /// returns the number of bytes read; 0 indicates end of file and -1 a read error
    read: *const fn (stream: *const IStream, buffer: ?*anyopaque, size: u64) callconv(.c) i64,
};

pub const OStream = extern struct {
    ctx: *anyopaque, // reserved pointer for the stream

    /// returns the number of bytes written; -1 on write error
    write: *const fn (stream: *const OStream, buffer: ?*const anyopaque, size: u64) callconv(.c) i64,
};
