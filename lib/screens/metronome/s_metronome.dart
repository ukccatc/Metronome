/// Metronome main screen
/// This is the main screen for the metronome functionality

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/metronome_provider.dart';
import '../../constants/theme.dart';
import '../../constants/constants.dart';
import 'l_metronome.dart';
import 'w_metronome_controls.dart';
import 'w_bpm_display.dart';
import 'w_time_signature_selector.dart';
import 'w_beat_subdivision.dart';
import 'w_accent_selector.dart';

class MetronomeScreen extends StatefulWidget {
  const MetronomeScreen({super.key});

  @override
  State<MetronomeScreen> createState() => _MetronomeScreenState();
}

class _MetronomeScreenState extends State<MetronomeScreen> {
  late MetronomeLogic _logic;

  @override
  void initState() {
    super.initState();
    _logic = MetronomeLogic(context.read<MetronomeProvider>());
    // Initialize automatically but safely
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _logic.initialize();
    });
  }

  @override
  void dispose() {
    _logic.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Metronome'),
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.textOnPrimary,
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: _logic.toggleSettings,
          ),
        ],
      ),
      body: Consumer<MetronomeProvider>(
        builder: (context, provider, child) {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(kDefaultPadding),
            child: Column(
              children: [
                // Error message display
                if (provider.errorMessage != null)
                  _buildErrorMessage(provider.errorMessage!),

                const SizedBox(height: kDefaultPadding),

                // BPM Display
                BpmDisplay(
                  bpm: _logic.bpm,
                  onBpmChanged: _logic.updateBpm,
                  isEnabled: !_logic.isLoading,
                ),

                const SizedBox(height: kDefaultPadding),

                // Time Signature Selector
                TimeSignatureSelector(
                  selectedSignature: _logic.timeSignature,
                  onSignatureChanged: _logic.updateTimeSignature,
                  isEnabled: !_logic.isLoading,
                ),

                // Beat Subdivision Selector
                BeatSubdivisionSelector(
                  selectedSubdivision: _logic.subdivision,
                  onSubdivisionChanged: _logic.updateSubdivision,
                  isEnabled: !_logic.isLoading,
                ),

                const SizedBox(height: kDefaultPadding),

                // Accent Pattern Selector
                AccentSelector(
                  selectedPattern: _logic.accentPattern,
                  timeSignature: _logic.timeSignature,
                  onPatternChanged: _logic.updateAccentPattern,
                  isEnabled: !_logic.isLoading,
                ),

                const SizedBox(height: kDefaultPadding),

                // Metronome Controls
                MetronomeControls(
                  isPlaying: _logic.isPlaying,
                  isInitialized: _logic.isInitialized,
                  onPlayPause: _logic.togglePlayPause,
                  onStop: _logic.stop,
                  isLoading: _logic.isLoading,
                ),

                const SizedBox(height: kDefaultPadding),

                // Current tick display
                _buildTickDisplay(),

                const SizedBox(height: kDefaultPadding),

                // Settings panel (if visible)
                if (_logic.showSettings) _buildSettingsPanel(),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildErrorMessage(String message) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(kDefaultPadding),
      margin: const EdgeInsets.only(bottom: kDefaultPadding),
      decoration: BoxDecoration(
        color: AppColors.error.withOpacity(0.1),
        borderRadius: BorderRadius.circular(kDefaultBorderRadius),
        border: Border.all(color: AppColors.error.withOpacity(0.3)),
      ),
      child: Row(
        children: [
          Icon(Icons.error_outline, color: AppColors.error, size: 20),
          const SizedBox(width: kDefaultSpacing),
          Expanded(
            child: Text(
              message,
              style: const TextStyle(color: AppColors.error),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTickDisplay() {
    return Consumer<MetronomeProvider>(
      builder: (context, provider, child) {
        return AnimatedScale(
          scale: _logic.animationScale,
          duration: kFastAnimationDuration,
          child: Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: provider.isPlaying
                  ? AppColors.metronomeActive
                  : AppColors.metronomeInactive,
              boxShadow: [
                BoxShadow(
                  color:
                      (provider.isPlaying
                              ? AppColors.metronomeActive
                              : AppColors.metronomeInactive)
                          .withOpacity(0.3),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Center(
              child: Text(
                '${provider.currentTick}',
                style: const TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textOnPrimary,
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildSettingsPanel() {
    return Card(
      elevation: kDefaultElevation,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(kDefaultBorderRadius),
      ),
      child: Padding(
        padding: const EdgeInsets.all(kDefaultPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Settings', style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: kDefaultSpacing),

            // Volume control
            Row(
              children: [
                const Text('Volume: '),
                Expanded(
                  child: Slider(
                    value: _logic.volume,
                    min: 0.0,
                    max: 1.0,
                    divisions: 100,
                    onChanged: _logic.updateVolume,
                    activeColor: AppColors.primary,
                  ),
                ),
                Text('${(_logic.volume * 100).round()}%'),
              ],
            ),

            const SizedBox(height: kDefaultSpacing),

            // Additional settings can be added here
            const Text('More settings coming soon...'),
          ],
        ),
      ),
    );
  }
}
