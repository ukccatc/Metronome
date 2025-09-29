/// Metronome main screen
/// This is the main screen for the metronome functionality

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/metronome_provider.dart';
import '../../constants/theme.dart';
import '../../constants/text_styles.dart';
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

                // Beat Indicator (moved to top)
                _buildTickDisplay(),

                const SizedBox(height: kDefaultPadding),

                // Metronome Controls (moved to top)
                MetronomeControls(
                  isPlaying: _logic.isPlaying,
                  isInitialized: _logic.isInitialized,
                  onPlayPause: _logic.togglePlayPause,
                  onStop: _logic.stop,
                  isLoading: _logic.isLoading,
                ),

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
        return Card(
          elevation: kDefaultElevation,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(kDefaultBorderRadius),
          ),
          child: Padding(
            padding: const EdgeInsets.all(kDefaultPadding),
            child: Column(
              children: [
                Text('Beat Indicator', style: AppTextStyles.titleMedium),
                const SizedBox(height: 4),
                Text(
                  'Current beat in the measure',
                  style: AppTextStyles.bodySmall.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
                const SizedBox(height: kDefaultSpacing),
                _buildBeatPallets(provider),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildBeatPallets(MetronomeProvider provider) {
    final timeSignature = provider.timeSignature;
    final currentTick = provider.currentTick;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(timeSignature, (index) {
        final beatNumber = index + 1;
        final isActive = currentTick == beatNumber;
        final isAccented = _isAccentedBeat(beatNumber, provider);

        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 4),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 150),
            width: isActive ? 24 : 20,
            height: isActive ? 24 : 20,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isActive
                  ? (isAccented ? AppColors.accent : AppColors.primary)
                  : (isAccented
                        ? AppColors.accent.withOpacity(0.3)
                        : AppColors.textHint),
              border: Border.all(
                color: isActive
                    ? (isAccented ? AppColors.accent : AppColors.primary)
                    : AppColors.textHint,
                width: 2,
              ),
              boxShadow: isActive
                  ? [
                      BoxShadow(
                        color:
                            (isAccented ? AppColors.accent : AppColors.primary)
                                .withOpacity(0.4),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ]
                  : null,
            ),
            child: Center(
              child: Text(
                '$beatNumber',
                style: TextStyle(
                  fontSize: isActive ? 12 : 10,
                  fontWeight: FontWeight.bold,
                  color: isActive
                      ? AppColors.textOnPrimary
                      : AppColors.textSecondary,
                ),
              ),
            ),
          ),
        );
      }),
    );
  }

  bool _isAccentedBeat(int beatNumber, MetronomeProvider provider) {
    final accentPattern = provider.accentPattern;
    if (accentPattern == null) return false;

    // Check if this beat should be accented
    if (beatNumber <= accentPattern.accents.length) {
      return accentPattern.accents[beatNumber - 1];
    }
    return false;
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
            const SizedBox(height: 4),
            Text(
              'Adjust the volume of the metronome. Higher values make the clicks louder.',
              style: Theme.of(
                context,
              ).textTheme.bodySmall?.copyWith(color: AppColors.textSecondary),
            ),
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
