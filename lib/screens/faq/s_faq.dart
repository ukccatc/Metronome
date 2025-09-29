/// FAQ Screen
/// Provides step-by-step instructions for new users

import 'package:flutter/material.dart';
import '../../l10n/app_localizations.dart';
import '../../constants/theme.dart';
import '../../constants/text_styles.dart';
import '../../constants/constants.dart';

class FaqScreen extends StatelessWidget {
  const FaqScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.howToUse),
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.textOnPrimary,
        elevation: kDefaultElevation,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(kDefaultPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildWelcomeSection(l10n),
            const SizedBox(height: kDefaultSpacing * 2),
            _buildQuickStartSection(l10n),
            const SizedBox(height: kDefaultSpacing * 2),
            _buildDetailedInstructionsSection(l10n),
            const SizedBox(height: kDefaultSpacing * 2),
            _buildFeaturesSection(l10n),
            const SizedBox(height: kDefaultSpacing * 2),
            _buildTipsSection(l10n),
            const SizedBox(height: kDefaultSpacing * 2),
            _buildTroubleshootingSection(l10n),
          ],
        ),
      ),
    );
  }

  Widget _buildWelcomeSection(AppLocalizations l10n) {
    return Card(
      elevation: kDefaultElevation,
      child: Padding(
        padding: const EdgeInsets.all(kDefaultPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              l10n.welcomeToMetronom,
              style: AppTextStyles.headlineSmall.copyWith(
                color: AppColors.primary,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: kDefaultSpacing),
            Text(l10n.welcomeDescription, style: AppTextStyles.bodyMedium),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickStartSection(AppLocalizations l10n) {
    return Card(
      elevation: kDefaultElevation,
      child: Padding(
        padding: const EdgeInsets.all(kDefaultPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              l10n.quickStart,
              style: AppTextStyles.headlineSmall.copyWith(
                color: AppColors.primary,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: kDefaultSpacing),
            _buildStepItem(
              step: '1',
              title: l10n.step1,
              description: l10n.step1Description,
            ),
            _buildStepItem(
              step: '2',
              title: l10n.step2,
              description: l10n.step2Description,
            ),
            _buildStepItem(
              step: '3',
              title: l10n.step3,
              description: l10n.step3Description,
            ),
            _buildStepItem(
              step: '4',
              title: l10n.step4,
              description: l10n.step4Description,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailedInstructionsSection(AppLocalizations l10n) {
    return Card(
      elevation: kDefaultElevation,
      child: Padding(
        padding: const EdgeInsets.all(kDefaultPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              l10n.detailedInstructions,
              style: AppTextStyles.headlineSmall.copyWith(
                color: AppColors.primary,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: kDefaultSpacing),
            _buildFeatureInstruction(
              title: 'Beat Indicator (Top of Screen)',
              description:
                  'The row of circles shows your current position in the measure. The highlighted circle is the current beat. Accented beats (like beat 1) are shown with a different color.',
            ),
            _buildFeatureInstruction(
              title: 'Metronome Controls',
              description:
                  'Play (▶️): Start the metronome\nPause (⏸️): Temporarily stop\nStop (⏹️): Stop and reset to beat 1',
            ),
            _buildFeatureInstruction(
              title: 'BPM Control',
              description:
                  'BPM = Beats Per Minute. Higher numbers = faster tempo. Use +/- buttons or tap the number to edit directly. Range: 40-200 BPM.',
            ),
            _buildFeatureInstruction(
              title: 'Time Signature',
              description:
                  'Choose how many beats per measure:\n• 4/4 (Common) - Most popular\n• 3/4 (Waltz) - For dancing\n• 2/4 (March) - For marching music\n• 5/4 (Quintuple) - Unusual time\n• 6/4, 7/4, 8/4 - Advanced time signatures',
            ),
            _buildFeatureInstruction(
              title: 'Beat Subdivision',
              description:
                  'Choose how beats are divided:\n• Quarter (1/4) - Standard, one click per beat\n• Eighth (1/8) - Twice as fast, two clicks per beat\n• Triplet (1/3) - Creates swing feel\n• Sixteenth (1/16) - Very fast, four clicks per beat',
            ),
            _buildFeatureInstruction(
              title: 'Accent Patterns',
              description:
                  'Choose which beats are emphasized (louder):\n• None - All beats equal\n• First Beat - Emphasize beat 1\n• Strong-Weak - Emphasize beats 1 and 3\n• Custom - Create your own pattern',
            ),
            _buildFeatureInstruction(
              title: 'Volume Control',
              description:
                  'Adjust the volume in the settings panel. Higher values make the clicks louder. Use this to practice in different environments.',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeaturesSection(AppLocalizations l10n) {
    return Card(
      elevation: kDefaultElevation,
      child: Padding(
        padding: const EdgeInsets.all(kDefaultPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'All Features Explained',
              style: AppTextStyles.headlineSmall.copyWith(
                color: AppColors.primary,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: kDefaultSpacing),
            _buildFeatureItem(
              icon: '🎵',
              title: 'BPM Control',
              description:
                  'Set tempo from 40-200 BPM. Use +/- buttons or tap to edit directly.',
            ),
            _buildFeatureItem(
              icon: '🎼',
              title: 'Time Signatures',
              description:
                  'Choose from 2/4 to 8/4 time signatures with musical names.',
            ),
            _buildFeatureItem(
              icon: '⚡',
              title: 'Beat Subdivisions',
              description:
                  'Practice with quarter, eighth, triplet, or sixteenth notes.',
            ),
            _buildFeatureItem(
              icon: '💥',
              title: 'Accent Patterns',
              description:
                  'Emphasize specific beats to feel the rhythm structure.',
            ),
            _buildFeatureItem(
              icon: '🔊',
              title: 'Volume Control',
              description: 'Adjust volume for different practice environments.',
            ),
            _buildFeatureItem(
              icon: '👁️',
              title: 'Visual Feedback',
              description: 'See the current beat with animated indicators.',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTipsSection(AppLocalizations l10n) {
    return Card(
      elevation: kDefaultElevation,
      child: Padding(
        padding: const EdgeInsets.all(kDefaultPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Pro Tips',
              style: AppTextStyles.headlineSmall.copyWith(
                color: AppColors.primary,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: kDefaultSpacing),
            _buildTipItem(
              tip: 'Start Slow',
              description:
                  'Begin with a slow tempo (60-80 BPM) and gradually increase speed as you improve.',
            ),
            _buildTipItem(
              tip: 'Use Visual Cues',
              description:
                  'Watch the beat indicator to help you stay in time, especially when learning new pieces.',
            ),
            _buildTipItem(
              tip: 'Practice Subdivisions',
              description:
                  'Use eighth or sixteenth notes to practice complex rhythms and improve timing.',
            ),
            _buildTipItem(
              tip: 'Feel the Accents',
              description:
                  'Use accent patterns to understand the musical structure and feel of different time signatures.',
            ),
            _buildTipItem(
              tip: 'Adjust Volume',
              description:
                  'Set volume so you can hear the metronome clearly without it overpowering your instrument.',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTroubleshootingSection(AppLocalizations l10n) {
    return Card(
      elevation: kDefaultElevation,
      child: Padding(
        padding: const EdgeInsets.all(kDefaultPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Troubleshooting',
              style: AppTextStyles.headlineSmall.copyWith(
                color: AppColors.primary,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: kDefaultSpacing),
            _buildTroubleshootingItem(
              problem: 'No Sound',
              solution:
                  'Check your device volume and the app\'s volume setting. Make sure your device isn\'t on silent mode.',
            ),
            _buildTroubleshootingItem(
              problem: 'Metronome Won\'t Start',
              solution:
                  'Try stopping and starting again. Make sure you have a valid BPM setting (40-200).',
            ),
            _buildTroubleshootingItem(
              problem: 'Visual Indicator Not Moving',
              solution:
                  'The visual indicator only moves when the metronome is playing. Press the play button to start.',
            ),
            _buildTroubleshootingItem(
              problem: 'App Feels Slow',
              solution:
                  'Close other apps to free up memory. The metronome needs precise timing to work properly.',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStepItem({
    required String step,
    required String title,
    required String description,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: kDefaultSpacing),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              color: AppColors.primary,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                step,
                style: AppTextStyles.bodySmall.copyWith(
                  color: AppColors.textOnPrimary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(width: kDefaultSpacing),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppTextStyles.bodyMedium.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: AppTextStyles.bodySmall.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureInstruction({
    required String title,
    required String description,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: kDefaultSpacing),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: AppTextStyles.bodyMedium.copyWith(
              fontWeight: FontWeight.bold,
              color: AppColors.primary,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            description,
            style: AppTextStyles.bodySmall.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureItem({
    required String icon,
    required String title,
    required String description,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: kDefaultSpacing),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(icon, style: const TextStyle(fontSize: 24)),
          const SizedBox(width: kDefaultSpacing),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppTextStyles.bodyMedium.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: AppTextStyles.bodySmall.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTipItem({required String tip, required String description}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: kDefaultSpacing),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              color: AppColors.secondary,
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.lightbulb_outline,
              size: 16,
              color: AppColors.textOnPrimary,
            ),
          ),
          const SizedBox(width: kDefaultSpacing),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  tip,
                  style: AppTextStyles.bodyMedium.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: AppTextStyles.bodySmall.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTroubleshootingItem({
    required String problem,
    required String solution,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: kDefaultSpacing),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(
                Icons.warning_outlined,
                size: 16,
                color: AppColors.error,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  problem,
                  style: AppTextStyles.bodyMedium.copyWith(
                    fontWeight: FontWeight.bold,
                    color: AppColors.error,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Padding(
            padding: const EdgeInsets.only(left: 24),
            child: Text(
              solution,
              style: AppTextStyles.bodySmall.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
