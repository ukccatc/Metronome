/// Global app-wide constants and utilities
/// This file contains all global constants used throughout the application

// Global constants with k prefix
const bool kIsDebug = true;
const String kAppName = 'Metronome';
const String kAppVersion = '1.0.0';

// Metronome specific constants
const int kDefaultBpm = 120;
const int kMinBpm = 40;
const int kMaxBpm = 200;
const double kDefaultVolume = 0.7;
const int kDefaultTimeSignature = 4;

// Audio constants
const int kSampleRate = 44100;
const String kDefaultTickSound = 'snare.wav';
const String kDefaultAccentSound = 'claves44_wav.wav';

// UI constants
const double kDefaultPadding = 16.0;
const double kDefaultSpacing = 8.0;
const double kDefaultBorderRadius = 8.0;
const double kDefaultElevation = 2.0;

// Animation constants
const Duration kDefaultAnimationDuration = Duration(milliseconds: 300);
const Duration kFastAnimationDuration = Duration(milliseconds: 150);
const Duration kSlowAnimationDuration = Duration(milliseconds: 500);
