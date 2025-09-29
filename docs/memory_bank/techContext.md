# Technical Context - Metronom

## Technology Stack

### Core Framework
- **Flutter**: 3.8.0+ - Cross-platform UI framework
- **Dart**: 3.0.0+ - Programming language
- **Material Design 3**: Modern UI design system

### State Management
- **Provider**: 6.1.1 - State management and dependency injection
- **ChangeNotifier**: Reactive state updates
- **StreamController**: Event broadcasting

### Audio Processing
- **Metronome Package**: 2.0.6 - Cross-platform metronome engine
- **AudioPlayers**: 5.2.1 - Fallback audio playback
- **WAV Audio**: High-quality audio format for metronome sounds

### Data Management
- **JSON Annotation**: 4.8.1 - Model serialization
- **JSON Serializable**: 6.7.1 - Code generation for JSON
- **Build Runner**: 2.4.7 - Code generation tool

### Development Tools
- **Flutter Lints**: 2.0.0 - Code quality and style enforcement
- **Flutter Test**: Unit and widget testing framework
- **Dart Analysis**: Static code analysis

## Platform Support

### Mobile Platforms
- **iOS**: 13.0+ (iPhone and iPad)
- **Android**: API 21+ (Android 5.0+)

### Web Platform
- **Modern Browsers**: Chrome, Firefox, Safari, Edge
- **Web Audio API**: Required for audio playback
- **Progressive Web App**: Installable web application

### Desktop Platforms (Future)
- **macOS**: 10.14+ (planned)
- **Windows**: 10+ (planned)
- **Linux**: Ubuntu 18.04+ (planned)

## Architecture Components

### Audio Engine
```dart
// Primary audio engine
Metronome _metronome = Metronome();

// Configuration
await _metronome.init(
  'assets/audio/snare.wav',
  accentedPath: 'assets/audio/claves44_wav.wav',
  bpm: 120,
  volume: 80,
  enableTickCallback: true,
  timeSignature: 4,
);
```

### State Management
```dart
// Provider-based state management
class MetronomeProvider extends ChangeNotifier {
  MetronomeSettings _settings = MetronomeSettings.defaultSettings();
  MetronomeStateModel _state = const MetronomeStateModel();
  AudioService _audioService = AudioService();
}
```

### Data Models
```dart
// Immutable data models with JSON serialization
@JsonSerializable()
class MetronomeSettings {
  final int bpm;
  final double volume;
  final int timeSignature;
  final BeatSubdivision subdivision;
  final AccentPattern? accentPattern;
}
```

## Audio System Architecture

### Audio Pipeline
```
User Input → Provider → Audio Service → Metronome Package → Platform Audio
```

### Audio Assets
- **Snare Sound**: `assets/audio/snare.wav` - Main metronome tick
- **Claves Sound**: `assets/audio/claves44_wav.wav` - Accented beat
- **Format**: WAV for best quality and compatibility
- **Quality**: 44.1kHz, 16-bit for optimal performance

### Audio Features
- **BPM Range**: 40-200 BPM with precise control
- **Volume Control**: 0-100% with smooth adjustment
- **Time Signatures**: 2/4, 3/4, 4/4, 5/4, 6/4, 7/4, 8/4
- **Beat Subdivisions**: Quarter, eighth, triplet, sixteenth notes
- **Accent Patterns**: Customizable beat emphasis

## Performance Specifications

### Audio Performance
- **Latency**: < 50ms from beat to sound
- **Accuracy**: ±0.1% BPM precision
- **Jitter**: < 5ms timing variation
- **Sample Rate**: 44.1kHz for high quality

### UI Performance
- **Frame Rate**: 60 FPS smooth animations
- **Response Time**: < 16ms for UI updates
- **Memory Usage**: < 50MB total app footprint
- **Battery Impact**: Minimal drain during use

### Startup Performance
- **Cold Start**: < 2 seconds to ready state
- **Warm Start**: < 1 second to ready state
- **Audio Init**: < 500ms audio system initialization

## Development Environment

### Required Tools
- **Flutter SDK**: 3.8.0 or higher
- **Dart SDK**: 3.0.0 or higher
- **Android Studio**: Latest version with Flutter plugin
- **Xcode**: Latest version for iOS development
- **VS Code**: Optional, with Flutter extension

### Build Configuration
```yaml
# pubspec.yaml
environment:
  sdk: '>=3.8.0 <4.0.0'

dependencies:
  flutter:
    sdk: flutter
  metronome: ^2.0.6
  provider: ^6.1.1
  json_annotation: ^4.8.1
```

### Code Generation
```bash
# Generate JSON serialization code
flutter packages pub run build_runner build

# Watch for changes during development
flutter packages pub run build_runner watch
```

## Platform-Specific Configurations

### iOS Configuration
```xml
<!-- ios/Runner/Info.plist -->
<key>NSMicrophoneUsageDescription</key>
<string>This app uses audio for metronome functionality</string>
```

### Android Configuration
```xml
<!-- android/app/src/main/AndroidManifest.xml -->
<uses-permission android:name="android.permission.RECORD_AUDIO" />
<uses-permission android:name="android.permission.MODIFY_AUDIO_SETTINGS" />
```

### Web Configuration
```html
<!-- web/index.html -->
<script>
  // Web Audio API support check
  if (!window.AudioContext && !window.webkitAudioContext) {
    console.warn('Web Audio API not supported');
  }
</script>
```

## Audio Processing Details

### Metronome Package Integration
```dart
// Initialize metronome with configuration
await _metronome.init(
  tickSoundPath,           // Main tick sound
  accentedPath: accentPath, // Accented beat sound
  bpm: bpm,                // Beats per minute
  volume: volume,          // Volume level (0-100)
  enableTickCallback: true, // Enable beat callbacks
  timeSignature: timeSignature, // Beats per measure
);

// Listen to beat events
_metronome.tickStream.listen((int tick) {
  // Handle beat timing
  _updateVisualIndicator(tick);
});
```

### Audio Timing Precision
- **High-Resolution Timer**: Platform-specific timing
- **Audio Buffer Management**: Optimized buffer sizes
- **Synchronization**: Audio-visual sync within 16ms
- **Drift Compensation**: Automatic timing correction

## State Management Architecture

### Provider Hierarchy
```
MultiProvider
└── ChangeNotifierProvider<MetronomeProvider>
    ├── MetronomeSettings (immutable)
    ├── MetronomeStateModel (immutable)
    └── AudioService (singleton)
```

### State Flow
```
User Action → Logic → Provider → Audio Service → State Update → UI Rebuild
```

### Error Handling
```dart
// Comprehensive error handling
try {
  await _audioService.start();
} catch (e) {
  _setError('Failed to start metronome: $e');
  // Graceful degradation
}
```

## Data Persistence

### Local Storage
- **SharedPreferences**: User settings and preferences
- **No Cloud Sync**: Offline-first application
- **Settings Persistence**: BPM, volume, time signature preferences

### Model Serialization
```dart
// JSON serialization for data persistence
@JsonSerializable()
class MetronomeSettings {
  final int bpm;
  final double volume;
  final int timeSignature;
  
  // Automatic JSON serialization
  factory MetronomeSettings.fromJson(Map<String, dynamic> json) =>
      _$MetronomeSettingsFromJson(json);
  Map<String, dynamic> toJson() => _$MetronomeSettingsToJson(this);
}
```

## Testing Strategy

### Unit Testing
- **Provider Testing**: State management logic
- **Service Testing**: Audio service functionality
- **Model Testing**: Data model behavior

### Widget Testing
- **Component Testing**: Individual widget behavior
- **Integration Testing**: Widget interactions
- **User Flow Testing**: Complete user journeys

### Platform Testing
- **iOS Testing**: iPhone and iPad devices
- **Android Testing**: Various screen sizes and versions
- **Web Testing**: Multiple browsers and devices

## Performance Monitoring

### Metrics Tracking
- **Audio Latency**: Measure timing accuracy
- **Memory Usage**: Monitor memory consumption
- **CPU Usage**: Track processing overhead
- **Battery Impact**: Measure power consumption

### Optimization Strategies
- **Lazy Loading**: Load resources on demand
- **Caching**: Cache frequently used data
- **Efficient Rebuilds**: Minimize widget rebuilds
- **Resource Management**: Proper disposal of resources

## Security Considerations

### Data Security
- **No Sensitive Data**: No personal information stored
- **Local Storage Only**: No network communication
- **Audio Assets**: Local audio files only

### Input Validation
- **BPM Validation**: Range checking (40-200)
- **Volume Validation**: Range checking (0-100)
- **Time Signature Validation**: Valid values only

## Accessibility Features

### Screen Reader Support
- **Semantic Labels**: Proper accessibility labels
- **Focus Management**: Logical tab order
- **Audio Descriptions**: Clear audio feedback

### Visual Accessibility
- **High Contrast**: Sufficient color contrast
- **Large Text**: Scalable text sizes
- **Visual Indicators**: Clear visual feedback

## Future Technical Roadmap

### Short-term Improvements
- **Performance Optimization**: Reduce latency and memory usage
- **Testing Coverage**: Comprehensive automated testing
- **Error Handling**: Enhanced error recovery

### Medium-term Features
- **Desktop Support**: macOS, Windows, Linux versions
- **Advanced Audio**: Custom sound uploads
- **Cloud Sync**: Optional settings synchronization

### Long-term Vision
- **AI Integration**: Smart tempo suggestions
- **Advanced Patterns**: Complex rhythm patterns
- **Professional Features**: Advanced metronome capabilities
