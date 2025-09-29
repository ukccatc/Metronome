/// Audio service for metronome functionality
/// This service handles audio playback and metronome timing

import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:metronome/metronome.dart';
import 'package:audioplayers/audioplayers.dart';
import '../models/m_metronome.dart';
import '../constants/constants.dart';

/// Audio service class for metronome functionality
class AudioService {
  // Core metronome instance
  final Metronome _metronome = Metronome();
  final AudioPlayer _audioPlayer = AudioPlayer();
  
  // State management
  final StreamController<MetronomeStateModel> _stateController = 
      StreamController<MetronomeStateModel>.broadcast();
  final StreamController<int> _tickController = 
      StreamController<int>.broadcast();
  
  // Current state
  MetronomeSettings _settings = const MetronomeSettings();
  MetronomeStateModel _currentState = const MetronomeStateModel();
  Timer? _fallbackTimer;
  bool _isInitialized = false;
  bool _useFallback = false;
  
  // Streams
  Stream<MetronomeStateModel> get stateStream => _stateController.stream;
  Stream<int> get tickStream => _tickController.stream;
  
  /// Initialize the audio service
  Future<void> initialize(MetronomeSettings settings) async {
    _settings = settings;
    
    try {
      debugPrint('Initializing audio service...');
      
      // Try to initialize the native metronome
      await _metronome.init(
        'assets/audio/${settings.tickSound}',
        accentedPath: 'assets/audio/${settings.accentSound}',
        bpm: settings.bpm,
        volume: (settings.volume * 100).toInt(),
        enableTickCallback: true,
        timeSignature: settings.timeSignature,
        sampleRate: kSampleRate,
      );
      
      // Listen to tick stream
      _metronome.tickStream.listen((int tick) {
        _onTickReceived(tick);
      });
      
      _isInitialized = true;
      _useFallback = false;
      
      _updateState(_currentState.copyWith(
        isInitialized: true,
        useFallback: false,
        lastUpdated: DateTime.now(),
      ));
      
      debugPrint('Audio service initialized successfully');
    } catch (e) {
      debugPrint('Error initializing metronome: $e');
      debugPrint('Switching to fallback audio system...');
      
      _isInitialized = true;
      _useFallback = true;
      
      _updateState(_currentState.copyWith(
        isInitialized: true,
        useFallback: true,
        errorMessage: 'Using fallback audio system',
        lastUpdated: DateTime.now(),
      ));
    }
  }
  
  /// Start the metronome
  Future<void> start() async {
    if (!_isInitialized) {
      throw Exception('Audio service not initialized');
    }
    
    try {
      if (_useFallback) {
        _startFallbackMetronome();
      } else {
        await _metronome.play();
      }
      
      _updateState(_currentState.copyWith(
        state: MetronomeState.playing,
        lastUpdated: DateTime.now(),
      ));
    } catch (e) {
      _updateState(_currentState.copyWith(
        errorMessage: 'Failed to start metronome: $e',
        lastUpdated: DateTime.now(),
      ));
      rethrow;
    }
  }
  
  /// Pause the metronome
  Future<void> pause() async {
    if (!_isInitialized) return;
    
    try {
      if (_useFallback) {
        _fallbackTimer?.cancel();
      } else {
        await _metronome.pause();
      }
      
      _updateState(_currentState.copyWith(
        state: MetronomeState.paused,
        lastUpdated: DateTime.now(),
      ));
    } catch (e) {
      _updateState(_currentState.copyWith(
        errorMessage: 'Failed to pause metronome: $e',
        lastUpdated: DateTime.now(),
      ));
      rethrow;
    }
  }
  
  /// Stop the metronome
  Future<void> stop() async {
    if (!_isInitialized) return;
    
    try {
      if (_useFallback) {
        _fallbackTimer?.cancel();
      } else {
        await _metronome.stop();
      }
      
      _updateState(_currentState.copyWith(
        state: MetronomeState.stopped,
        currentTick: 0,
        lastUpdated: DateTime.now(),
      ));
    } catch (e) {
      _updateState(_currentState.copyWith(
        errorMessage: 'Failed to stop metronome: $e',
        lastUpdated: DateTime.now(),
      ));
      rethrow;
    }
  }
  
  /// Update BPM
  Future<void> updateBpm(int bpm) async {
    _settings = _settings.copyWith(bpm: bpm);
    
    if (_isInitialized) {
      if (_useFallback) {
        // Restart fallback timer with new BPM
        if (_currentState.state == MetronomeState.playing) {
          _fallbackTimer?.cancel();
          _startFallbackMetronome();
        }
      } else {
        _metronome.setBPM(bpm);
      }
    }
  }
  
  /// Update time signature
  Future<void> updateTimeSignature(int timeSignature) async {
    _settings = _settings.copyWith(timeSignature: timeSignature);
    
    if (_isInitialized && _useFallback) {
      // Restart fallback timer with new time signature
      if (_currentState.state == MetronomeState.playing) {
        _fallbackTimer?.cancel();
        _startFallbackMetronome();
      }
    }
  }
  
  /// Update volume
  Future<void> updateVolume(double volume) async {
    _settings = _settings.copyWith(volume: volume);
    
    if (_isInitialized && !_useFallback) {
      _metronome.setVolume((volume * 100).toInt());
    }
  }
  
  /// Start fallback metronome using Timer
  void _startFallbackMetronome() {
    debugPrint('Starting fallback metronome at ${_settings.bpm} BPM');
    final interval = Duration(milliseconds: (60000 / _settings.bpm).round());
    
    _fallbackTimer = Timer.periodic(interval, (timer) {
      final newTick = (_currentState.currentTick % _settings.timeSignature) + 1;
      
      _updateState(_currentState.copyWith(
        currentTick: newTick,
        lastUpdated: DateTime.now(),
      ));
      
      _tickController.add(newTick);
      
      // Play different sounds for beat 1 vs other beats
      if (newTick == 1) {
        _audioPlayer.play(AssetSource('audio/${_settings.accentSound}'));
      } else {
        _audioPlayer.play(AssetSource('audio/${_settings.tickSound}'));
      }
      
      debugPrint('Fallback tick: $newTick');
    });
  }
  
  /// Handle tick received from native metronome
  void _onTickReceived(int tick) {
    _updateState(_currentState.copyWith(
      currentTick: tick,
      lastUpdated: DateTime.now(),
    ));
    
    _tickController.add(tick);
    debugPrint('Native tick: $tick');
  }
  
  /// Update internal state and notify listeners
  void _updateState(MetronomeStateModel newState) {
    _currentState = newState;
    _stateController.add(newState);
  }
  
  /// Dispose resources
  void dispose() {
    _fallbackTimer?.cancel();
    _metronome.destroy();
    _audioPlayer.dispose();
    _stateController.close();
    _tickController.close();
  }
}