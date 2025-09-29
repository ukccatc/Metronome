/// Metronome controls widget
/// This widget contains the main metronome control buttons

import 'package:flutter/material.dart';
import '../../l10n/app_localizations.dart';
import '../../constants/theme.dart';
import '../../constants/text_styles.dart';
import '../../constants/constants.dart';

class MetronomeControls extends StatelessWidget {
  final bool isPlaying;
  final bool isInitialized;
  final VoidCallback onPlayPause;
  final VoidCallback onStop;
  final bool isLoading;

  const MetronomeControls({
    super.key,
    required this.isPlaying,
    required this.isInitialized,
    required this.onPlayPause,
    required this.onStop,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Card(
      elevation: kDefaultElevation,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(kDefaultBorderRadius),
      ),
      child: Padding(
        padding: const EdgeInsets.all(kDefaultPadding),
        child: Column(
          children: [
            Text(l10n.metronomeControls, style: AppTextStyles.titleMedium),
            const SizedBox(height: 4),
            Text(
              l10n.metronomeControlsDescription,
              style: AppTextStyles.bodySmall.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
            const SizedBox(height: kDefaultSpacing),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // Stop button
                _buildControlButton(
                  icon: Icons.stop,
                  onPressed: isInitialized ? onStop : null,
                  isActive: false,
                ),

                // Play/Pause button
                _buildControlButton(
                  icon: isPlaying ? Icons.pause : Icons.play_arrow,
                  onPressed: isInitialized ? onPlayPause : null,
                  isActive: isPlaying,
                  isPrimary: true,
                  isLoading: isLoading,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildControlButton({
    required IconData icon,
    required VoidCallback? onPressed,
    required bool isActive,
    bool isPrimary = false,
    bool isLoading = false,
  }) {
    return Container(
      width: isPrimary ? 80 : 60,
      height: isPrimary ? 80 : 60,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isActive
            ? AppColors.metronomeActive
            : AppColors.metronomeInactive,
        boxShadow: [
          BoxShadow(
            color: isActive
                ? AppColors.metronomeActive.withValues(alpha: 0.3)
                : AppColors.metronomeInactive.withValues(alpha: 0.3),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(isPrimary ? 40 : 30),
          onTap: () {
            debugPrint('Button tapped. onPressed: ${onPressed != null}');
            onPressed?.call();
          },
          child: Center(
            child: isLoading
                ? SizedBox(
                    width: 24,
                    height: 24,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation<Color>(
                        isActive
                            ? AppColors.textOnPrimary
                            : AppColors.textPrimary,
                      ),
                    ),
                  )
                : Icon(
                    icon,
                    size: isPrimary ? 32 : 24,
                    color: isActive
                        ? AppColors.textOnPrimary
                        : AppColors.textPrimary,
                  ),
          ),
        ),
      ),
    );
  }
}
