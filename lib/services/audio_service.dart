import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:metronome/metronome.dart';
import '../models/m_metronome.dart';

/// Simple audio service using only the metronome package
class AudioService {
  final Metronome _metronome = Metronome();
  MetronomeSettings? _settings;
  bool _isInitialized = false;

  // State management
  MetronomeStateModel _currentState = const MetronomeStateModel();
  final StreamController<MetronomeStateModel> _stateController =
      StreamController.broadcast();
  final StreamController<int> _tickController = StreamController.broadcast();

  // Streams
  Stream<MetronomeStateModel> get stateStream => _stateController.stream;
  Stream<int> get tickStream => _tickController.stream;

  /// Initialize the audio service
  Future<void> initialize(MetronomeSettings settings) async {
    debugPrint('AudioService.initialize() called with settings: $settings');
    _settings = settings;

    try {
      debugPrint('Calling _metronome.init()...');
      await _metronome.init(
        'assets/audio/${settings.tickSound}',
        accentedPath: 'assets/audio/${settings.accentSound}',
        bpm: settings.bpm,
        volume: (settings.volume * 100).toInt(),
        enableTickCallback: true,
        timeSignature: settings.timeSignature,
      );
      debugPrint('_metronome.init() completed successfully');

      _metronome.tickStream.listen((int tick) {
        debugPrint('Tick received: $tick');
        _updateState(_currentState.copyWith(currentTick: tick));
        _tickController.add(tick);
      });

      _isInitialized = true;
      _updateState(_currentState.copyWith(isInitialized: true));

      debugPrint(
        'Metronome initialized successfully, isInitialized: $_isInitialized',
      );
    } catch (e) {
      debugPrint('Error initializing metronome: $e');
      _isInitialized = false;
    }
  }

  /// Start the metronome
  Future<void> start() async {
    debugPrint('AudioService.start() called, isInitialized: $_isInitialized');

    if (!_isInitialized) {
      debugPrint('Metronome not initialized, cannot start');
      return;
    }

    try {
      debugPrint('Calling _metronome.play()...');
      await _metronome.play();
      debugPrint('_metronome.play() completed successfully');
      _updateState(_currentState.copyWith(state: MetronomeState.playing));
    } catch (e) {
      debugPrint('Error starting metronome: $e');
    }
  }

  /// Pause the metronome
  Future<void> pause() async {
    if (!_isInitialized) return;

    try {
      await _metronome.pause();
      _updateState(_currentState.copyWith(state: MetronomeState.paused));
    } catch (e) {
      debugPrint('Error pausing metronome: $e');
    }
  }

  /// Stop the metronome
  Future<void> stop() async {
    if (!_isInitialized) return;

    try {
      await _metronome.stop();
      _updateState(
        _currentState.copyWith(state: MetronomeState.stopped, currentTick: 0),
      );
    } catch (e) {
      debugPrint('Error stopping metronome: $e');
    }
  }

  /// Update BPM
  Future<void> setBpm(int bpm) async {
    if (!_isInitialized || _settings == null) return;

    _settings = _settings!.copyWith(bpm: bpm);

    try {
      await _metronome.setBPM(bpm);
    } catch (e) {
      debugPrint('Error setting BPM: $e');
    }
  }

  /// Update volume
  Future<void> setVolume(double volume) async {
    if (!_isInitialized || _settings == null) return;

    _settings = _settings!.copyWith(volume: volume);

    try {
      await _metronome.setVolume((volume * 100).toInt());
    } catch (e) {
      debugPrint('Error setting volume: $e');
    }
  }

  /// Update time signature
  Future<void> setTimeSignature(int timeSignature) async {
    if (!_isInitialized || _settings == null) return;

    _settings = _settings!.copyWith(timeSignature: timeSignature);

    try {
      await _metronome.setTimeSignature(timeSignature);
    } catch (e) {
      debugPrint('Error setting time signature: $e');
    }
  }

  /// Get current state
  MetronomeStateModel get currentState => _currentState;

  /// Check if initialized
  bool get isInitialized => _isInitialized;

  /// Update internal state and notify listeners
  void _updateState(MetronomeStateModel newState) {
    _currentState = newState;
    _stateController.add(newState);
  }

  /// Dispose resources
  void dispose() {
    _metronome.destroy();
    _stateController.close();
    _tickController.close();
  }
}
