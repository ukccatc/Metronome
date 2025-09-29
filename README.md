# Metronom - Flutter Metronome App

A simple and elegant metronome app built with Flutter using the [metronome package](https://pub.dev/packages/metronome).

## Features

- **BPM Control**: Adjustable tempo from 40 to 200 BPM
- **Volume Control**: Adjustable volume from 0 to 100%
- **Time Signature**: Support for 2/4, 3/4, 4/4, 5/4, 6/4, 7/4, and 8/4 time signatures
- **Visual Beat Indicator**: Shows current beat in the measure
- **Play/Pause/Stop Controls**: Full playback control
- **Cross-platform**: Works on Android, iOS, macOS, Windows, and Web

## Getting Started

### Prerequisites

- Flutter SDK (3.0.0 or higher)
- Dart SDK
- Audio assets (see assets/audio/README.md)

### Installation

1. Clone or download this project
2. Add audio files to `assets/audio/` directory:
   - `snare.wav` - Main metronome tick sound
   - `claves44_wav.wav` - Accented beat sound
3. Run `flutter pub get` to install dependencies
4. Run `flutter run` to start the app

### Audio Assets

The app requires two audio files:

- **snare.wav**: The main metronome tick sound
- **claves44_wav.wav**: The accented beat sound (for beat 1 of each measure)

You can find free metronome sounds at:

- [Freesound.org](https://freesound.org/)
- [Zapsplat](https://www.zapsplat.com/)

Make sure the files are in WAV format for best compatibility.

## Usage

1. **Set BPM**: Use the BPM slider to adjust the tempo
2. **Set Volume**: Use the volume slider to adjust the sound level
3. **Choose Time Signature**: Select from 2/4 to 8/4 time signatures
4. **Play**: Tap the Play button to start the metronome
5. **Pause**: Tap Pause to temporarily stop
6. **Stop**: Tap Stop to completely stop and reset to beat 1

## Technical Details

- Built with Flutter and the metronome package v2.0.6
- Supports high BPM values (up to 600+ BPM)
- Efficient resource usage
- Accurate timing with tick callbacks
- Material Design 3 UI

## License

This project is open source and available under the MIT License.
# Metronome
