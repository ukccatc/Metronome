/// Settings screen
/// Provides comprehensive app settings and preferences

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../l10n/app_localizations.dart';
import '../../providers/locale_provider.dart';
import '../../providers/metronome_provider.dart';
import '../../constants/theme.dart';
import '../../constants/text_styles.dart';
import '../../constants/constants.dart';
import '../../shared_widgets/w_language_selector.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.settings),
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.textOnPrimary,
        elevation: kDefaultElevation,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(kDefaultPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildLanguageSection(context),
            const SizedBox(height: kDefaultSpacing * 2),
            _buildAudioSection(context),
            const SizedBox(height: kDefaultSpacing * 2),
            _buildVisualSection(context),
            const SizedBox(height: kDefaultSpacing * 2),
            _buildAdvancedSection(context),
            const SizedBox(height: kDefaultSpacing * 2),
            _buildAboutSection(context),
          ],
        ),
      ),
    );
  }

  Widget _buildLanguageSection(BuildContext context) {
    return Card(
      elevation: kDefaultElevation,
      child: Padding(
        padding: const EdgeInsets.all(kDefaultPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Language / Язык',
              style: AppTextStyles.titleMedium.copyWith(
                color: AppColors.primary,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: kDefaultSpacing),
            Consumer<LocaleProvider>(
              builder: (context, localeProvider, child) {
                return LanguageSelector(
                  currentLocale: localeProvider.currentLocale,
                  onLocaleChanged: (locale) {
                    localeProvider.setLocale(locale);
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAudioSection(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Card(
      elevation: kDefaultElevation,
      child: Padding(
        padding: const EdgeInsets.all(kDefaultPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Audio Settings',
              style: AppTextStyles.titleMedium.copyWith(
                color: AppColors.primary,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: kDefaultSpacing),
            Consumer<MetronomeProvider>(
              builder: (context, provider, child) {
                return Column(
                  children: [
                    _buildVolumeSlider(provider, l10n),
                    const SizedBox(height: kDefaultSpacing),
                    _buildAudioQualitySelector(provider),
                    const SizedBox(height: kDefaultSpacing),
                    _buildSoundPackSelector(provider),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildVolumeSlider(MetronomeProvider provider, AppLocalizations l10n) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l10n.volume,
          style: AppTextStyles.bodyMedium.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 4),
        Text(
          l10n.volumeDescription,
          style: AppTextStyles.bodySmall.copyWith(
            color: AppColors.textSecondary,
          ),
        ),
        const SizedBox(height: kDefaultSpacing),
        Row(
          children: [
            const Icon(Icons.volume_down, color: AppColors.textSecondary),
            Expanded(
              child: Slider(
                value: provider.volume,
                min: 0.0,
                max: 1.0,
                divisions: 100,
                onChanged: provider.updateVolume,
                activeColor: AppColors.primary,
              ),
            ),
            const Icon(Icons.volume_up, color: AppColors.textSecondary),
            const SizedBox(width: 8),
            Text(
              '${(provider.volume * 100).round()}%',
              style: AppTextStyles.bodyMedium.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildAudioQualitySelector(MetronomeProvider provider) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Audio Quality',
          style: AppTextStyles.bodyMedium.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 4),
        Text(
          'Choose the audio quality for metronome sounds',
          style: AppTextStyles.bodySmall.copyWith(
            color: AppColors.textSecondary,
          ),
        ),
        const SizedBox(height: kDefaultSpacing),
        Row(
          children: [
            _buildQualityOption('High', 'High quality audio', true),
            const SizedBox(width: kDefaultSpacing),
            _buildQualityOption('Medium', 'Balanced quality', false),
            const SizedBox(width: kDefaultSpacing),
            _buildQualityOption('Low', 'Lower quality, less battery', false),
          ],
        ),
      ],
    );
  }

  Widget _buildQualityOption(
    String title,
    String description,
    bool isSelected,
  ) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          // TODO: Implement quality selection
        },
        child: Container(
          padding: const EdgeInsets.all(kDefaultSpacing),
          decoration: BoxDecoration(
            color: isSelected
                ? AppColors.primary.withValues(alpha: 0.1)
                : AppColors.surface,
            border: Border.all(
              color: isSelected ? AppColors.primary : AppColors.textHint,
              width: isSelected ? 2 : 1,
            ),
            borderRadius: BorderRadius.circular(kDefaultBorderRadius),
          ),
          child: Column(
            children: [
              Text(
                title,
                style: AppTextStyles.bodyMedium.copyWith(
                  color: isSelected ? AppColors.primary : AppColors.textPrimary,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                description,
                style: AppTextStyles.bodySmall.copyWith(
                  color: AppColors.textSecondary,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSoundPackSelector(MetronomeProvider provider) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Sound Pack',
          style: AppTextStyles.bodyMedium.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 4),
        Text(
          'Choose different metronome sounds',
          style: AppTextStyles.bodySmall.copyWith(
            color: AppColors.textSecondary,
          ),
        ),
        const SizedBox(height: kDefaultSpacing),
        Wrap(
          spacing: kDefaultSpacing,
          runSpacing: kDefaultSpacing,
          children: [
            _buildSoundPackChip('Classic', 'Traditional metronome sound', true),
            _buildSoundPackChip('Electronic', 'Modern electronic beep', false),
            _buildSoundPackChip('Wooden', 'Wooden metronome sound', false),
            _buildSoundPackChip('Digital', 'Clean digital sound', false),
          ],
        ),
      ],
    );
  }

  Widget _buildSoundPackChip(String name, String description, bool isSelected) {
    return ChoiceChip(
      label: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(name),
          Text(
            description,
            style: AppTextStyles.bodySmall.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
      selected: isSelected,
      onSelected: (selected) {
        // TODO: Implement sound pack selection
      },
      selectedColor: AppColors.primary.withValues(alpha: 0.2),
      checkmarkColor: AppColors.primary,
    );
  }

  Widget _buildVisualSection(BuildContext context) {
    return Card(
      elevation: kDefaultElevation,
      child: Padding(
        padding: const EdgeInsets.all(kDefaultPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Visual Settings',
              style: AppTextStyles.titleMedium.copyWith(
                color: AppColors.primary,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: kDefaultSpacing),
            _buildVisualThemeSelector(),
            const SizedBox(height: kDefaultSpacing),
            _buildBeatIndicatorSettings(),
            const SizedBox(height: kDefaultSpacing),
            _buildAnimationSettings(),
          ],
        ),
      ),
    );
  }

  Widget _buildVisualThemeSelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Theme',
          style: AppTextStyles.bodyMedium.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 4),
        Text(
          'Choose your preferred app theme',
          style: AppTextStyles.bodySmall.copyWith(
            color: AppColors.textSecondary,
          ),
        ),
        const SizedBox(height: kDefaultSpacing),
        Row(
          children: [
            _buildThemeOption('Light', Icons.light_mode, true),
            const SizedBox(width: kDefaultSpacing),
            _buildThemeOption('Dark', Icons.dark_mode, false),
            const SizedBox(width: kDefaultSpacing),
            _buildThemeOption('System', Icons.settings_suggest, false),
          ],
        ),
      ],
    );
  }

  Widget _buildThemeOption(String name, IconData icon, bool isSelected) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          // TODO: Implement theme selection
        },
        child: Container(
          padding: const EdgeInsets.all(kDefaultSpacing),
          decoration: BoxDecoration(
            color: isSelected
                ? AppColors.primary.withValues(alpha: 0.1)
                : AppColors.surface,
            border: Border.all(
              color: isSelected ? AppColors.primary : AppColors.textHint,
              width: isSelected ? 2 : 1,
            ),
            borderRadius: BorderRadius.circular(kDefaultBorderRadius),
          ),
          child: Column(
            children: [
              Icon(
                icon,
                color: isSelected ? AppColors.primary : AppColors.textSecondary,
                size: 24,
              ),
              const SizedBox(height: 8),
              Text(
                name,
                style: AppTextStyles.bodyMedium.copyWith(
                  color: isSelected ? AppColors.primary : AppColors.textPrimary,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBeatIndicatorSettings() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Beat Indicator',
          style: AppTextStyles.bodyMedium.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 4),
        Text(
          'Customize the visual beat indicator',
          style: AppTextStyles.bodySmall.copyWith(
            color: AppColors.textSecondary,
          ),
        ),
        const SizedBox(height: kDefaultSpacing),
        Row(
          children: [
            Expanded(
              child: SwitchListTile(
                title: const Text('Show Beat Numbers'),
                subtitle: const Text('Display numbers on beat indicators'),
                value: true,
                onChanged: (value) {
                  // TODO: Implement beat number toggle
                },
                activeColor: AppColors.primary,
                contentPadding: EdgeInsets.zero,
              ),
            ),
          ],
        ),
        Row(
          children: [
            Expanded(
              child: SwitchListTile(
                title: const Text('Pulse Animation'),
                subtitle: const Text('Animate beat indicators'),
                value: true,
                onChanged: (value) {
                  // TODO: Implement pulse animation toggle
                },
                activeColor: AppColors.primary,
                contentPadding: EdgeInsets.zero,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildAnimationSettings() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Animations',
          style: AppTextStyles.bodyMedium.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 4),
        Text(
          'Control app animations and transitions',
          style: AppTextStyles.bodySmall.copyWith(
            color: AppColors.textSecondary,
          ),
        ),
        const SizedBox(height: kDefaultSpacing),
        Row(
          children: [
            Expanded(
              child: SwitchListTile(
                title: const Text('Reduce Motion'),
                subtitle: const Text('Minimize animations for accessibility'),
                value: false,
                onChanged: (value) {
                  // TODO: Implement reduce motion toggle
                },
                activeColor: AppColors.primary,
                contentPadding: EdgeInsets.zero,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildAdvancedSection(BuildContext context) {
    return Card(
      elevation: kDefaultElevation,
      child: Padding(
        padding: const EdgeInsets.all(kDefaultPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Advanced Settings',
              style: AppTextStyles.titleMedium.copyWith(
                color: AppColors.primary,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: kDefaultSpacing),
            _buildPerformanceSettings(),
            const SizedBox(height: kDefaultSpacing),
            _buildDebugSettings(),
          ],
        ),
      ),
    );
  }

  Widget _buildPerformanceSettings() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Performance',
          style: AppTextStyles.bodyMedium.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 4),
        Text(
          'Optimize app performance',
          style: AppTextStyles.bodySmall.copyWith(
            color: AppColors.textSecondary,
          ),
        ),
        const SizedBox(height: kDefaultSpacing),
        Row(
          children: [
            Expanded(
              child: SwitchListTile(
                title: const Text('High Precision Mode'),
                subtitle: const Text(
                  'More accurate timing (uses more battery)',
                ),
                value: false,
                onChanged: (value) {
                  // TODO: Implement high precision mode
                },
                activeColor: AppColors.primary,
                contentPadding: EdgeInsets.zero,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildDebugSettings() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Debug',
          style: AppTextStyles.bodyMedium.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 4),
        Text(
          'Developer and debugging options',
          style: AppTextStyles.bodySmall.copyWith(
            color: AppColors.textSecondary,
          ),
        ),
        const SizedBox(height: kDefaultSpacing),
        Row(
          children: [
            Expanded(
              child: SwitchListTile(
                title: const Text('Debug Mode'),
                subtitle: const Text('Show debug information'),
                value: false,
                onChanged: (value) {
                  // TODO: Implement debug mode toggle
                },
                activeColor: AppColors.primary,
                contentPadding: EdgeInsets.zero,
              ),
            ),
          ],
        ),
        const SizedBox(height: kDefaultSpacing),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton.icon(
            onPressed: () {
              // TODO: Implement reset settings
              _showResetDialog();
            },
            icon: const Icon(Icons.restore),
            label: const Text('Reset All Settings'),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.error,
              foregroundColor: AppColors.textOnPrimary,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildAboutSection(BuildContext context) {
    return Card(
      elevation: kDefaultElevation,
      child: Padding(
        padding: const EdgeInsets.all(kDefaultPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'About',
              style: AppTextStyles.titleMedium.copyWith(
                color: AppColors.primary,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: kDefaultSpacing),
            _buildAboutItem('App Version', '1.0.0'),
            _buildAboutItem('Build Number', '1'),
            _buildAboutItem('Flutter Version', '3.8.0+'),
            _buildAboutItem('Dart Version', '3.0.0+'),
            const SizedBox(height: kDefaultSpacing),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {
                  // TODO: Implement rate app
                },
                icon: const Icon(Icons.star),
                label: const Text('Rate App'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.warning,
                  foregroundColor: AppColors.textOnPrimary,
                ),
              ),
            ),
            const SizedBox(height: kDefaultSpacing),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: () {
                  // TODO: Implement feedback
                },
                icon: const Icon(Icons.feedback),
                label: const Text('Send Feedback'),
                style: OutlinedButton.styleFrom(
                  foregroundColor: AppColors.primary,
                  side: const BorderSide(color: AppColors.primary),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAboutItem(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: kDefaultSpacing),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: AppTextStyles.bodyMedium.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            value,
            style: AppTextStyles.bodyMedium.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }

  void _showResetDialog() {
    // TODO: Implement reset confirmation dialog
  }
}
