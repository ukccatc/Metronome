# System Patterns - Metronom

## Architecture Overview

### Core Architecture Pattern
**Clean Architecture with Provider State Management**

The Metronom app follows a clean, layered architecture that separates concerns and ensures maintainability:

```
┌─────────────────────────────────────┐
│           Presentation Layer        │
│  (Screens, Widgets, UI Logic)      │
├─────────────────────────────────────┤
│           Business Logic Layer      │
│  (Providers, Services, Models)     │
├─────────────────────────────────────┤
│           Data Layer                │
│  (Audio Service, Local Storage)    │
└─────────────────────────────────────┘
```

### Key Design Patterns

#### 1. Provider Pattern (State Management)
- **MetronomeProvider**: Central state management using ChangeNotifier
- **Reactive Updates**: UI automatically updates when state changes
- **Separation of Concerns**: Business logic separated from UI

```dart
class MetronomeProvider extends ChangeNotifier {
  // State management
  // Business logic methods
  // Audio service integration
}
```

#### 2. Service Layer Pattern
- **AudioService**: Encapsulates audio functionality
- **Single Responsibility**: Each service has one clear purpose
- **Dependency Injection**: Services injected into providers

```dart
class AudioService {
  // Audio engine management
  // Stream controllers
  // Cross-platform audio handling
}
```

#### 3. Model-View-Controller (MVC)
- **Models**: Data structures with JSON serialization
- **Views**: Flutter widgets for UI presentation
- **Controllers**: Logic classes that handle business rules

#### 4. Widget Composition Pattern
- **Reusable Components**: Small, focused widgets
- **Composition over Inheritance**: Build complex UI from simple widgets
- **Consistent Naming**: w_ prefix for widgets, s_ for screens, l_ for logic

## File Organization Patterns

### Directory Structure
```
lib/
├── constants/           # Global constants and configuration
├── models/             # Data models and DTOs
├── providers/          # State management
├── services/           # Business logic and external services
├── screens/            # Screen implementations
│   └── metronome/      # Feature-specific organization
│       ├── s_metronome.dart    # Screen
│       ├── l_metronome.dart    # Logic
│       └── w_*.dart           # Widgets
├── shared_widgets/     # Reusable UI components
└── main.dart          # App entry point
```

### Naming Conventions
- **m_**: Models (m_metronome.dart)
- **s_**: Screens (s_metronome.dart)
- **l_**: Logic (l_metronome.dart)
- **w_**: Widgets (w_bpm_display.dart)
- **pp_**: Proxy Providers (not used in this project)
- **e_**: Extensions (e_*.dart)
- **h_**: Helpers (h_*.dart)
- **mix_**: Mixins (mix_*.dart)

## State Management Patterns

### Provider State Flow
```
User Action → Logic Layer → Provider → Audio Service → State Update → UI Update
```

### State Synchronization
1. **User Interaction**: User taps button or changes setting
2. **Logic Processing**: Logic class processes the action
3. **Provider Update**: Provider updates internal state
4. **Service Call**: Audio service receives the update
5. **State Broadcast**: Provider notifies listeners
6. **UI Update**: Widgets rebuild with new state

### Error Handling Pattern
```dart
try {
  await _audioService.start();
} catch (e) {
  _setError('Failed to start metronome: $e');
  // Graceful degradation
}
```

## Audio System Patterns

### Audio Service Architecture
```
MetronomeProvider → AudioService → Metronome Package → Platform Audio
```

### Stream-Based Communication
- **State Stream**: Broadcasts metronome state changes
- **Tick Stream**: Broadcasts beat timing events
- **Error Handling**: Graceful fallback for audio issues

### Cross-Platform Audio
- **Primary**: Metronome package for consistent timing
- **Fallback**: Platform-specific audio if needed
- **Asset Management**: WAV files for best compatibility

## UI/UX Patterns

### Material Design 3 Compliance
- **Color System**: Consistent color palette
- **Typography**: Clear hierarchy with proper text styles
- **Spacing**: Consistent padding and margins
- **Elevation**: Proper shadow and depth

### Responsive Design Patterns
- **Flexible Layouts**: Wrap widgets for overflow handling
- **Scrollable Content**: SingleChildScrollView for long content
- **Platform Adaptation**: Consistent experience across devices

### User Experience Patterns
- **Progressive Disclosure**: Basic features first, advanced options available
- **Immediate Feedback**: Visual and audio response to all actions
- **Error Prevention**: Input validation and clear error messages
- **Accessibility**: Proper semantics and contrast ratios

## Data Flow Patterns

### Model Serialization
```dart
@JsonSerializable()
class MetronomeSettings {
  // JSON serialization for persistence
  // CopyWith methods for immutable updates
  // Validation methods for data integrity
}
```

### State Immutability
- **Immutable Models**: All data models are immutable
- **CopyWith Pattern**: Create new instances for updates
- **State Validation**: Validate data before state updates

### Stream Management
```dart
// Proper stream lifecycle management
StreamSubscription? _stateSubscription;
StreamSubscription? _tickSubscription;

void dispose() {
  _stateSubscription?.cancel();
  _tickSubscription?.cancel();
}
```

## Error Handling Patterns

### Graceful Degradation
- **Audio Failures**: Fallback to visual-only mode
- **State Errors**: Reset to safe default state
- **User Feedback**: Clear error messages with recovery options

### Error Recovery
```dart
void _onError(dynamic error) {
  _setError('Audio error: $error');
  // Attempt recovery
  _attemptRecovery();
}
```

### Logging and Debugging
- **Debug Prints**: Comprehensive logging for development
- **Error Tracking**: Capture and report errors
- **Performance Monitoring**: Track timing and performance

## Performance Patterns

### Efficient Rebuilds
- **Selective Updates**: Only rebuild necessary widgets
- **Const Constructors**: Use const where possible
- **Widget Caching**: Cache expensive computations

### Memory Management
- **Stream Cleanup**: Proper disposal of streams and controllers
- **Resource Management**: Dispose of audio resources
- **State Cleanup**: Clear state on app termination

### Audio Performance
- **Low Latency**: Minimize audio processing delay
- **Efficient Timing**: Use platform-optimized timing
- **Resource Optimization**: Minimize CPU and memory usage

## Testing Patterns

### Unit Testing
- **Provider Testing**: Test state management logic
- **Service Testing**: Test audio service functionality
- **Model Testing**: Test data model behavior

### Widget Testing
- **Component Testing**: Test individual widgets
- **Integration Testing**: Test widget interactions
- **User Flow Testing**: Test complete user journeys

### Platform Testing
- **Cross-Platform**: Test on all target platforms
- **Audio Testing**: Verify audio quality and timing
- **Performance Testing**: Measure and optimize performance

## Security Patterns

### Data Protection
- **Local Storage**: No sensitive data stored
- **Audio Assets**: Local audio files only
- **No Network**: Offline-first application

### Input Validation
- **BPM Range**: Validate BPM within acceptable range
- **Time Signature**: Validate time signature values
- **Volume Control**: Validate volume levels

## Accessibility Patterns

### Semantic Marking
- **Screen Reader Support**: Proper semantics for all controls
- **Focus Management**: Logical tab order
- **Color Contrast**: Sufficient contrast ratios

### User Assistance
- **Explanatory Text**: Help text for all features
- **Visual Feedback**: Clear visual indicators
- **Audio Feedback**: Consistent audio cues

## Future Extension Patterns

### Plugin Architecture
- **Service Interface**: Abstract audio service interface
- **Provider Extension**: Easy addition of new providers
- **Widget Composition**: Modular widget system

### Feature Flags
- **Conditional Features**: Enable/disable features
- **A/B Testing**: Test different implementations
- **Gradual Rollout**: Controlled feature deployment

### Configuration Management
- **Environment Config**: Different configs for dev/prod
- **Feature Toggles**: Runtime feature control
- **Settings Persistence**: User preference storage
