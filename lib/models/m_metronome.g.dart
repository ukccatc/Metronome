// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'm_metronome.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AccentPattern _$AccentPatternFromJson(Map<String, dynamic> json) =>
    AccentPattern(
      name: json['name'] as String,
      accents: (json['accents'] as List<dynamic>)
          .map((e) => e as bool)
          .toList(),
      description: json['description'] as String,
    );

Map<String, dynamic> _$AccentPatternToJson(AccentPattern instance) =>
    <String, dynamic>{
      'name': instance.name,
      'accents': instance.accents,
      'description': instance.description,
    };

MetronomeSettings _$MetronomeSettingsFromJson(Map<String, dynamic> json) =>
    MetronomeSettings(
      bpm: (json['bpm'] as num?)?.toInt() ?? 120,
      timeSignature: (json['timeSignature'] as num?)?.toInt() ?? 4,
      volume: (json['volume'] as num?)?.toDouble() ?? 0.7,
      tickSound: json['tickSound'] as String? ?? 'snare.wav',
      accentSound: json['accentSound'] as String? ?? 'claves44_wav.wav',
      enableAccent: json['enableAccent'] as bool? ?? true,
      enableVisualFeedback: json['enableVisualFeedback'] as bool? ?? true,
      enableHapticFeedback: json['enableHapticFeedback'] as bool? ?? false,
      subdivision:
          $enumDecodeNullable(_$BeatSubdivisionEnumMap, json['subdivision']) ??
          BeatSubdivision.quarter,
      accentPattern: json['accentPattern'] == null
          ? null
          : AccentPattern.fromJson(
              json['accentPattern'] as Map<String, dynamic>,
            ),
    );

Map<String, dynamic> _$MetronomeSettingsToJson(MetronomeSettings instance) =>
    <String, dynamic>{
      'bpm': instance.bpm,
      'timeSignature': instance.timeSignature,
      'volume': instance.volume,
      'tickSound': instance.tickSound,
      'accentSound': instance.accentSound,
      'enableAccent': instance.enableAccent,
      'enableVisualFeedback': instance.enableVisualFeedback,
      'enableHapticFeedback': instance.enableHapticFeedback,
      'subdivision': _$BeatSubdivisionEnumMap[instance.subdivision]!,
      'accentPattern': instance.accentPattern,
    };

const _$BeatSubdivisionEnumMap = {
  BeatSubdivision.quarter: 'quarter',
  BeatSubdivision.eighth: 'eighth',
  BeatSubdivision.triplet: 'triplet',
  BeatSubdivision.sixteenth: 'sixteenth',
};

MetronomeStateModel _$MetronomeStateModelFromJson(Map<String, dynamic> json) =>
    MetronomeStateModel(
      state:
          $enumDecodeNullable(_$MetronomeStateEnumMap, json['state']) ??
          MetronomeState.stopped,
      currentTick: (json['currentTick'] as num?)?.toInt() ?? 0,
      isInitialized: json['isInitialized'] as bool? ?? false,
      useFallback: json['useFallback'] as bool? ?? false,
      errorMessage: json['errorMessage'] as String?,
      lastUpdated: json['lastUpdated'] == null
          ? null
          : DateTime.parse(json['lastUpdated'] as String),
    );

Map<String, dynamic> _$MetronomeStateModelToJson(
  MetronomeStateModel instance,
) => <String, dynamic>{
  'state': _$MetronomeStateEnumMap[instance.state]!,
  'currentTick': instance.currentTick,
  'isInitialized': instance.isInitialized,
  'useFallback': instance.useFallback,
  'errorMessage': instance.errorMessage,
  'lastUpdated': instance.lastUpdated?.toIso8601String(),
};

const _$MetronomeStateEnumMap = {
  MetronomeState.stopped: 'stopped',
  MetronomeState.playing: 'playing',
  MetronomeState.paused: 'paused',
};

MetronomeModel _$MetronomeModelFromJson(Map<String, dynamic> json) =>
    MetronomeModel(
      settings: MetronomeSettings.fromJson(
        json['settings'] as Map<String, dynamic>,
      ),
      state: MetronomeStateModel.fromJson(
        json['state'] as Map<String, dynamic>,
      ),
    );

Map<String, dynamic> _$MetronomeModelToJson(MetronomeModel instance) =>
    <String, dynamic>{'settings': instance.settings, 'state': instance.state};
