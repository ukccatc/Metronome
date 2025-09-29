/// Metronome Provider for state management
/// This provider manages the metronome state and business logic

import 'dart:async';
import 'package:flutter/foundation.dart';
import '../models/m_metronome.dart';
import '../services/audio_service.dart';
import '../constants/constants.dart';

/// Base class for change notifier with update method
abstract class ChangeNotifierUpdater extends ChangeNotifier {
  void update() => notifyListeners();
}

/// Metronome Provider class
class MetronomeProvider extends ChangeNotifierUpdater {
  // Services
  final AudioService _audioService = AudioService();
  
  // State
  MetronomeSettings _settings = const MetronomeSettings();
  MetronomeStateModel _state = const MetronomeStateModel();
  bool _isLoading = false;
  String? _errorMessage;
  
  // Stream subscriptions
  StreamSubscription<MetronomeStateModel>? _stateSubscription;
  StreamSubscription<int>? _tickSubscription;
  
  // Getters
  MetronomeSettings get settings => _settings;
  MetronomeStateModel get state => _state;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  
  // Computed getters
  bool get isPlaying => _state.state == MetronomeState.playing;
  bool get isInitialized => _state.isInitialized;
  int get currentTick => _state.currentTick;
  int get bpm => _settings.bpm;
  int get timeSignature => _settings.timeSignature;
  double get volume => _settings.volume;
  
  /// Initialize the provider
  Future<void> initialize() async {
    _setLoading(true);
    _clearError();
    
    try {
      // Initialize audio service
      await _audioService.initialize(_settings);
      
      // Listen to state changes
      _stateSubscription = _audioService.stateStream.listen(
        _onStateChanged,
        onError: _onError,
      );
      
      // Listen to tick changes
      _tickSubscription = _audioService.tickStream.listen(
        _onTickChanged,
        onError: _onError,
      );
      
    } catch (e) {
      _setError('Failed to initialize metronome: $e');
    } finally {
      _setLoading(false);
    }
  }
  
  /// Start the metronome
  Future<void> start() async {
    if (!_state.isInitialized) {
      await initialize();
    }
    
    try {
      await _audioService.start();
    } catch (e) {
      _setError('Failed to start metronome: $e');
    }
  }
  
  /// Pause the metronome
  Future<void> pause() async {
    try {
      await _audioService.pause();
    } catch (e) {
      _setError('Failed to pause metronome: $e');
    }
  }
  
  /// Stop the metronome
  Future<void> stop() async {
    try {
      await _audioService.stop();
    } catch (e) {
      _setError('Failed to stop metronome: $e');
    }
  }
  
  /// Toggle play/pause
  Future<void> togglePlayPause() async {
    if (isPlaying) {
      await pause();
    } else {
      await start();
    }
  }
  
  /// Update BPM
  Future<void> updateBpm(int bpm) async {
    if (bpm < kMinBpm || bpm > kMaxBpm) {
      _setError('BPM must be between $kMinBpm and $kMaxBpm');
      return;
    }
    
    _settings = _settings.copyWith(bpm: bpm);
    update();
    
    try {
      await _audioService.updateBpm(bpm);
    } catch (e) {
      _setError('Failed to update BPM: $e');
    }
  }
  
  /// Update time signature
  Future<void> updateTimeSignature(int timeSignature) async {
    if (timeSignature < 2 || timeSignature > 8) {
      _setError('Time signature must be between 2 and 8');
      return;
    }
    
    _settings = _settings.copyWith(timeSignature: timeSignature);
    update();
    
    try {
      await _audioService.updateTimeSignature(timeSignature);
    } catch (e) {
      _setError('Failed to update time signature: $e');
    }
  }
  
  /// Update volume
  Future<void> updateVolume(double volume) async {
    if (volume < 0.0 || volume > 1.0) {
      _setError('Volume must be between 0.0 and 1.0');
      return;
    }
    
    _settings = _settings.copyWith(volume: volume);
    update();
    
    try {
      await _audioService.updateVolume(volume);
    } catch (e) {
      _setError('Failed to update volume: $e');
    }
  }
  
  /// Update tick sound
  void updateTickSound(String sound) {
    _settings = _settings.copyWith(tickSound: sound);
    update();
  }
  
  /// Update accent sound
  void updateAccentSound(String sound) {
    _settings = _settings.copyWith(accentSound: sound);
    update();
  }
  
  /// Toggle accent
  void toggleAccent() {
    _settings = _settings.copyWith(enableAccent: !_settings.enableAccent);
    update();
  }
  
  /// Toggle visual feedback
  void toggleVisualFeedback() {
    _settings = _settings.copyWith(enableVisualFeedback: !_settings.enableVisualFeedback);
    update();
  }
  
  /// Toggle haptic feedback
  void toggleHapticFeedback() {
    _settings = _settings.copyWith(enableHapticFeedback: !_settings.enableHapticFeedback);
    update();
  }
  
  /// Reset to default settings
  void resetToDefaults() {
    _settings = const MetronomeSettings();
    update();
  }
  
  /// Handle state changes from audio service
  void _onStateChanged(MetronomeStateModel newState) {
    _state = newState;
    update();
  }
  
  /// Handle tick changes from audio service
  void _onTickChanged(int tick) {
    // Tick is already handled in state changes
    // This is here for any additional tick-specific logic
  }
  
  /// Handle errors
  void _onError(dynamic error) {
    _setError('Audio service error: $error');
  }
  
  /// Set loading state
  void _setLoading(bool loading) {
    _isLoading = loading;
    update();
  }
  
  /// Set error message
  void _setError(String error) {
    _errorMessage = error;
    update();
  }
  
  /// Clear error message
  void _clearError() {
    _errorMessage = null;
    update();
  }
  
  @override
  void dispose() {
    _stateSubscription?.cancel();
    _tickSubscription?.cancel();
    _audioService.dispose();
    super.dispose();
  }
}
