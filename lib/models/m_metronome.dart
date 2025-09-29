/// Metronome data model
/// This file contains the data model for metronome functionality

import 'package:json_annotation/json_annotation.dart';

part 'm_metronome.g.dart';

/// Metronome state enumeration
enum MetronomeState {
  @JsonValue('stopped')
  stopped,
  @JsonValue('playing')
  playing,
  @JsonValue('paused')
  paused,
}

/// Metronome settings model
@JsonSerializable()
class MetronomeSettings {
  final int bpm;
  final int timeSignature;
  final double volume;
  final String tickSound;
  final String accentSound;
  final bool enableAccent;
  final bool enableVisualFeedback;
  final bool enableHapticFeedback;

  const MetronomeSettings({
    this.bpm = 120,
    this.timeSignature = 4,
    this.volume = 0.7,
    this.tickSound = 'snare.wav',
    this.accentSound = 'claves44_wav.wav',
    this.enableAccent = true,
    this.enableVisualFeedback = true,
    this.enableHapticFeedback = false,
  });

  /// Create a copy of this settings with updated values
  MetronomeSettings copyWith({
    int? bpm,
    int? timeSignature,
    double? volume,
    String? tickSound,
    String? accentSound,
    bool? enableAccent,
    bool? enableVisualFeedback,
    bool? enableHapticFeedback,
  }) {
    return MetronomeSettings(
      bpm: bpm ?? this.bpm,
      timeSignature: timeSignature ?? this.timeSignature,
      volume: volume ?? this.volume,
      tickSound: tickSound ?? this.tickSound,
      accentSound: accentSound ?? this.accentSound,
      enableAccent: enableAccent ?? this.enableAccent,
      enableVisualFeedback: enableVisualFeedback ?? this.enableVisualFeedback,
      enableHapticFeedback: enableHapticFeedback ?? this.enableHapticFeedback,
    );
  }

  /// Convert to JSON
  Map<String, dynamic> toJson() => _$MetronomeSettingsToJson(this);

  /// Create from JSON
  factory MetronomeSettings.fromJson(Map<String, dynamic> json) =>
      _$MetronomeSettingsFromJson(json);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is MetronomeSettings &&
        other.bpm == bpm &&
        other.timeSignature == timeSignature &&
        other.volume == volume &&
        other.tickSound == tickSound &&
        other.accentSound == accentSound &&
        other.enableAccent == enableAccent &&
        other.enableVisualFeedback == enableVisualFeedback &&
        other.enableHapticFeedback == enableHapticFeedback;
  }

  @override
  int get hashCode {
    return Object.hash(
      bpm,
      timeSignature,
      volume,
      tickSound,
      accentSound,
      enableAccent,
      enableVisualFeedback,
      enableHapticFeedback,
    );
  }

  @override
  String toString() {
    return 'MetronomeSettings(bpm: $bpm, timeSignature: $timeSignature, volume: $volume, tickSound: $tickSound, accentSound: $accentSound, enableAccent: $enableAccent, enableVisualFeedback: $enableVisualFeedback, enableHapticFeedback: $enableHapticFeedback)';
  }
}

/// Metronome state model
@JsonSerializable()
class MetronomeStateModel {
  final MetronomeState state;
  final int currentTick;
  final bool isInitialized;
  final bool useFallback;
  final String? errorMessage;
  final DateTime? lastUpdated;

  const MetronomeStateModel({
    this.state = MetronomeState.stopped,
    this.currentTick = 0,
    this.isInitialized = false,
    this.useFallback = false,
    this.errorMessage,
    this.lastUpdated,
  });

  /// Create a copy of this state with updated values
  MetronomeStateModel copyWith({
    MetronomeState? state,
    int? currentTick,
    bool? isInitialized,
    bool? useFallback,
    String? errorMessage,
    DateTime? lastUpdated,
  }) {
    return MetronomeStateModel(
      state: state ?? this.state,
      currentTick: currentTick ?? this.currentTick,
      isInitialized: isInitialized ?? this.isInitialized,
      useFallback: useFallback ?? this.useFallback,
      errorMessage: errorMessage ?? this.errorMessage,
      lastUpdated: lastUpdated ?? this.lastUpdated,
    );
  }

  /// Convert to JSON
  Map<String, dynamic> toJson() => _$MetronomeStateModelToJson(this);

  /// Create from JSON
  factory MetronomeStateModel.fromJson(Map<String, dynamic> json) =>
      _$MetronomeStateModelFromJson(json);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is MetronomeStateModel &&
        other.state == state &&
        other.currentTick == currentTick &&
        other.isInitialized == isInitialized &&
        other.useFallback == useFallback &&
        other.errorMessage == errorMessage &&
        other.lastUpdated == lastUpdated;
  }

  @override
  int get hashCode {
    return Object.hash(
      state,
      currentTick,
      isInitialized,
      useFallback,
      errorMessage,
      lastUpdated,
    );
  }

  @override
  String toString() {
    return 'MetronomeStateModel(state: $state, currentTick: $currentTick, isInitialized: $isInitialized, useFallback: $useFallback, errorMessage: $errorMessage, lastUpdated: $lastUpdated)';
  }
}

/// Complete metronome model combining settings and state
@JsonSerializable()
class MetronomeModel {
  final MetronomeSettings settings;
  final MetronomeStateModel state;

  const MetronomeModel({
    required this.settings,
    required this.state,
  });

  /// Create a copy of this model with updated values
  MetronomeModel copyWith({
    MetronomeSettings? settings,
    MetronomeStateModel? state,
  }) {
    return MetronomeModel(
      settings: settings ?? this.settings,
      state: state ?? this.state,
    );
  }

  /// Convert to JSON
  Map<String, dynamic> toJson() => _$MetronomeModelToJson(this);

  /// Create from JSON
  factory MetronomeModel.fromJson(Map<String, dynamic> json) =>
      _$MetronomeModelFromJson(json);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is MetronomeModel &&
        other.settings == settings &&
        other.state == state;
  }

  @override
  int get hashCode => Object.hash(settings, state);

  @override
  String toString() {
    return 'MetronomeModel(settings: $settings, state: $state)';
  }
}
