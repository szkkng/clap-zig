//! This file provides a set of standard plugin features meant to be used
//! within plugin.Descriptor.features.
//!
//! For practical reasons we'll avoid spaces and use `-` instead to facilitate
//! scripts that generate the feature array.
//!
//! Non-standard features should be formatted as follow: "$namespace:$feature"

pub const feature = struct {
    /////////////////////
    // Plugin category //
    /////////////////////

    /// Add this feature if your plugin can process note events and then produce audio
    pub const instrument = "instrument";

    /// Add this feature if your plugin is an audio effect
    pub const audio_effect = "audio-effect";

    /// Add this feature if your plugin is a note effect or a note generator/sequencer
    pub const note_effect = "note-effect";

    /// Add this feature if your plugin converts audio to notes
    pub const note_detector = "note-detector";

    /// Add this feature if your plugin is an analyzer
    pub const analyzer = "analyzer";

    /////////////////////////
    // Plugin sub-category //
    /////////////////////////

    pub const synthesizer = "synthesizer";
    pub const sampler = "sampler";
    pub const drum = "drum";
    pub const drum_machine = "drum-machine";
    pub const filter = "filter";
    pub const phaser = "phaser";
    pub const equalizer = "equalizer";
    pub const deesser = "de-esser";
    pub const phase_vocoder = "phase-vocoder";
    pub const granular = "granular";
    pub const frequency_shifter = "frequency-shifter";
    pub const pitch_shifter = "pitch-shifter";
    pub const distortion = "distortion";
    pub const transient_shaper = "transient-shaper";
    pub const compressor = "compressor";
    pub const expander = "expander";
    pub const gate = "gate";
    pub const limiter = "limiter";
    pub const flanger = "flanger";
    pub const chorus = "chorus";
    pub const delay = "delay";
    pub const reverb = "reverb";
    pub const tremolo = "tremolo";
    pub const glitch = "glitch";
    pub const utility = "utility";
    pub const pitch_correction = "pitch-correction";
    pub const restoration = "restoration"; // repair the sound
    pub const multi_effects = "multi-effects";
    pub const mixing = "mixing";
    pub const mastering = "mastering";

    ////////////////////////
    // Audio Capabilities //
    ////////////////////////

    pub const mono = "mono";
    pub const stereo = "stereo";
    pub const surround = "surround";
    pub const ambisonic = "ambisonic";
};
