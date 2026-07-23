/// This type defines a timestamp: the number of seconds since UNIX EPOCH.
/// See C's time_t time(time_t *).
pub const Timestamp = u64;

/// Value for unknown timestamp.
pub const unknown: Timestamp = 0;
