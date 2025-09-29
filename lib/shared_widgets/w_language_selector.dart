/// Language selector widget
/// Allows users to switch between English and Russian

import 'package:flutter/material.dart';
import '../constants/theme.dart';
import '../constants/text_styles.dart';
import '../constants/constants.dart';

class LanguageSelector extends StatelessWidget {
  final Locale currentLocale;
  final Function(Locale) onLocaleChanged;

  const LanguageSelector({
    super.key,
    required this.currentLocale,
    required this.onLocaleChanged,
  });

  @override
  Widget build(BuildContext context) {
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
            Text('Language / Язык', style: AppTextStyles.titleMedium),
            const SizedBox(height: 4),
            Text(
              'Choose your preferred language / Выберите предпочитаемый язык',
              style: AppTextStyles.bodySmall.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
            const SizedBox(height: kDefaultSpacing),
            Row(
              children: [
                Expanded(
                  child: _buildLanguageOption(
                    context: context,
                    locale: const Locale('en', ''),
                    flag: '🇺🇸',
                    name: 'English',
                    isSelected: currentLocale.languageCode == 'en',
                  ),
                ),
                const SizedBox(width: kDefaultSpacing),
                Expanded(
                  child: _buildLanguageOption(
                    context: context,
                    locale: const Locale('ru', ''),
                    flag: '🇷🇺',
                    name: 'Русский',
                    isSelected: currentLocale.languageCode == 'ru',
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLanguageOption({
    required BuildContext context,
    required Locale locale,
    required String flag,
    required String name,
    required bool isSelected,
  }) {
    return GestureDetector(
      onTap: () => onLocaleChanged(locale),
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
            Text(flag, style: const TextStyle(fontSize: 32)),
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
    );
  }
}
