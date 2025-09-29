/// Metronome screen logic
/// This file contains the business logic for the metronome screen

import 'package:flutter/foundation.dart';
import '../../providers/metronome_provider.dart';
import '../../models/m_metronome.dart';
import '../../constants/constants.dart';

/// Metronome screen logic class
class MetronomeLogic extends ChangeNotifier {
  // Provider reference
  final MetronomeProvider _provider;

  // UI state
  bool _showSettings = false;
  bool _showTimeSignatureSelector = false;
  bool _showVolumeSlider = false;

  // Animation state
  bool _isAnimating = false;
  double _animationScale = 1.0;

  // Constructor
  MetronomeLogic(this._provider) {
    // Listen to provider changes
    _provider.addListener(_onProviderChanged);
  }

  // Getters
  MetronomeProvider get provider => _provider;
  bool get showSettings => _showSettings;
  bool get showTimeSignatureSelector => _showTimeSignatureSelector;
  bool get showVolumeSlider => _showVolumeSlider;
  bool get isAnimating => _isAnimating;
  double get animationScale => _animationScale;

  // Computed getters
  bool get isPlaying => _provider.isPlaying;
  bool get isInitialized => _provider.isInitialized;
  int get currentTick => _provider.currentTick;
  int get bpm => _provider.bpm;
  int get timeSignature => _provider.timeSignature;
  double get volume => _provider.volume;
  BeatSubdivision get subdivision => _provider.subdivision;
  AccentPattern? get accentPattern => _provider.accentPattern;
  bool get isLoading => _provider.isLoading;
  String? get errorMessage => _provider.errorMessage;

  /// Initialize the logic
  Future<void> initialize() async {
    debugPrint('MetronomeLogic.initialize() called');
    try {
      await _provider.initialize();
      debugPrint(
        'MetronomeLogic.initialize() completed, isInitialized: ${_provider.isInitialized}',
      );
    } catch (e) {
      debugPrint('Error initializing metronome logic: $e');
      // Continue anyway to allow fallback usage
    }
  }

  /// Toggle play/pause
  Future<void> togglePlayPause() async {
    if (!_provider.isInitialized) {
      await _provider.initialize();
    }

    await _provider.togglePlayPause();

    // Trigger animation on play
    if (_provider.isPlaying) {
      _triggerTickAnimation();
    }
  }

  /// Stop the metronome
  Future<void> stop() async {
    await _provider.stop();
  }

  /// Update BPM
  Future<void> updateBpm(int bpm) async {
    await _provider.updateBpm(bpm);
  }

  /// Update time signature
  Future<void> updateTimeSignature(int timeSignature) async {
    await _provider.updateTimeSignature(timeSignature);
  }

  /// Update volume
  Future<void> updateVolume(double volume) async {
    await _provider.updateVolume(volume);
  }

  /// Update beat subdivision
  void updateSubdivision(BeatSubdivision subdivision) {
    _provider.updateSubdivision(subdivision);
  }

  /// Update accent pattern
  void updateAccentPattern(AccentPattern? pattern) {
    _provider.updateAccentPattern(pattern);
  }

  /// Toggle settings visibility
  void toggleSettings() {
    _showSettings = !_showSettings;
    notifyListeners();
  }

  /// Toggle time signature selector
  void toggleTimeSignatureSelector() {
    _showTimeSignatureSelector = !_showTimeSignatureSelector;
    notifyListeners();
  }

  /// Toggle volume slider
  void toggleVolumeSlider() {
    _showVolumeSlider = !_showVolumeSlider;
    notifyListeners();
  }

  /// Trigger tick animation
  void _triggerTickAnimation() {
    if (_isAnimating) return;

    _isAnimating = true;
    _animationScale = 1.2;
    notifyListeners();

    // Reset animation after duration
    Future.delayed(kFastAnimationDuration, () {
      _animationScale = 1.0;
      _isAnimating = false;
      notifyListeners();
    });
  }

  /// Handle provider changes
  void _onProviderChanged() {
    // Trigger animation on tick change
    if (_provider.isPlaying && _provider.currentTick > 0) {
      _triggerTickAnimation();
    }

    notifyListeners();
  }

  /// Get available time signatures
  List<int> get availableTimeSignatures => [2, 3, 4, 5, 6, 7, 8];

  /// Get BPM range
  int get minBpm => kMinBpm;
  int get maxBpm => kMaxBpm;

  /// Get volume range
  double get minVolume => 0.0;
  double get maxVolume => 1.0;

  /// Format BPM for display
  String formatBpm(int bpm) => '$bpm BPM';

  /// Format time signature for display
  String formatTimeSignature(int signature) => '$signature/4';

  /// Format volume for display
  String formatVolume(double volume) => '${(volume * 100).round()}%';

  /// Check if BPM is valid
  bool isValidBpm(int bpm) => bpm >= kMinBpm && bpm <= kMaxBpm;

  /// Check if time signature is valid
  bool isValidTimeSignature(int signature) => signature >= 2 && signature <= 8;

  /// Check if volume is valid
  bool isValidVolume(double volume) => volume >= 0.0 && volume <= 1.0;

  @override
  void dispose() {
    _provider.removeListener(_onProviderChanged);
    super.dispose();
  }
}
