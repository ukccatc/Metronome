/// Accent pattern selector widget
/// Allows users to select accent patterns for different time signatures

import 'package:flutter/material.dart';
import '../../constants/theme.dart';
import '../../constants/text_styles.dart';
import '../../constants/constants.dart';
import '../../models/m_metronome.dart';

class AccentSelector extends StatelessWidget {
  final AccentPattern? selectedPattern;
  final int timeSignature;
  final Function(AccentPattern?) onPatternChanged;
  final bool isEnabled;

  const AccentSelector({
    super.key,
    this.selectedPattern,
    required this.timeSignature,
    required this.onPatternChanged,
    this.isEnabled = true,
  });

  @override
  Widget build(BuildContext context) {
    final availablePatterns = _getAvailablePatterns(timeSignature);

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
            Text(
              'Accent Pattern',
              style: AppTextStyles.titleMedium,
            ),
            const SizedBox(height: 4),
            Text(
              'Choose which beats are emphasized. Accented beats play louder and help you feel the rhythm structure.',
              style: AppTextStyles.bodySmall.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
            const SizedBox(height: kDefaultSpacing),

            // No accent option
            _buildPatternChip(null, 'No Accent', 'All beats equal'),

            const SizedBox(height: kDefaultSpacing),

            // Available patterns
            ...availablePatterns.map((pattern) {
              return Padding(
                padding: const EdgeInsets.only(bottom: kDefaultSpacing),
                child: _buildPatternChip(
                  pattern,
                  pattern.name,
                  pattern.description,
                ),
              );
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildPatternChip(
    AccentPattern? pattern,
    String name,
    String description,
  ) {
    final isSelected = pattern == selectedPattern;

    return InkWell(
      onTap: isEnabled ? () => onPatternChanged(pattern) : null,
      borderRadius: BorderRadius.circular(kDefaultBorderRadius),
      child: Container(
        padding: const EdgeInsets.all(kDefaultSpacing),
        decoration: BoxDecoration(
          border: Border.all(
            color: isSelected
                ? AppColors.primary
                : AppColors.primary.withOpacity(0.3),
            width: 2,
          ),
          borderRadius: BorderRadius.circular(kDefaultBorderRadius),
          color: isSelected
              ? AppColors.primary.withOpacity(0.1)
              : Colors.transparent,
        ),
        child: Row(
          children: [
            // Accent visualization
            Expanded(flex: 2, child: _buildAccentVisualization(pattern)),

            const SizedBox(width: kDefaultSpacing),

            // Pattern info
            Expanded(
              flex: 3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: AppTextStyles.labelMedium.copyWith(
                      color: isSelected
                          ? AppColors.primary
                          : AppColors.textPrimary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    description,
                    style: AppTextStyles.bodySmall.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),

            // Selection indicator
            if (isSelected)
              Icon(Icons.check_circle, color: AppColors.primary, size: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildAccentVisualization(AccentPattern? pattern) {
    if (pattern == null) {
      // Show equal beats
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: List.generate(timeSignature, (index) {
          return Container(
            width: 12,
            height: 12,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.textSecondary,
            ),
          );
        }),
      );
    }

    // Show accent pattern
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: List.generate(timeSignature, (index) {
        final isAccented =
            index < pattern.accents.length && pattern.accents[index];
        return Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isAccented ? AppColors.accent : AppColors.textSecondary,
            border: isAccented
                ? Border.all(color: AppColors.accent, width: 2)
                : null,
          ),
        );
      }),
    );
  }

  List<AccentPattern> _getAvailablePatterns(int timeSignature) {
    switch (timeSignature) {
      case 2:
        return [
          const AccentPattern(
            name: 'Strong-Weak',
            accents: [true, false],
            description: 'First beat accented',
          ),
        ];
      case 3:
        return [
          const AccentPattern(
            name: 'Strong-Weak-Weak',
            accents: [true, false, false],
            description: 'First beat accented',
          ),
          const AccentPattern(
            name: 'Strong-Weak-Strong',
            accents: [true, false, true],
            description: 'First and third beats accented',
          ),
        ];
      case 4:
        return [
          const AccentPattern(
            name: 'Strong-Weak-Medium-Weak',
            accents: [true, false, true, false],
            description: 'First and third beats accented',
          ),
          const AccentPattern(
            name: 'Strong-Weak-Weak-Weak',
            accents: [true, false, false, false],
            description: 'First beat accented',
          ),
          const AccentPattern(
            name: 'Strong-Weak-Weak-Strong',
            accents: [true, false, false, true],
            description: 'First and fourth beats accented',
          ),
        ];
      case 5:
        return [
          const AccentPattern(
            name: 'Strong-Weak-Medium-Weak-Weak',
            accents: [true, false, true, false, false],
            description: 'First and third beats accented',
          ),
          const AccentPattern(
            name: 'Strong-Weak-Weak-Medium-Weak',
            accents: [true, false, false, true, false],
            description: 'First and fourth beats accented',
          ),
        ];
      case 6:
        return [
          const AccentPattern(
            name: 'Strong-Weak-Medium-Weak-Medium-Weak',
            accents: [true, false, true, false, true, false],
            description: 'Odd beats accented',
          ),
          const AccentPattern(
            name: 'Strong-Weak-Weak-Medium-Weak-Weak',
            accents: [true, false, false, true, false, false],
            description: 'First and fourth beats accented',
          ),
        ];
      case 7:
        return [
          const AccentPattern(
            name: 'Strong-Weak-Medium-Weak-Medium-Weak-Weak',
            accents: [true, false, true, false, true, false, false],
            description: 'First, third, and fifth beats accented',
          ),
        ];
      case 8:
        return [
          const AccentPattern(
            name: 'Strong-Weak-Medium-Weak-Strong-Weak-Medium-Weak',
            accents: [true, false, true, false, true, false, true, false],
            description: 'Odd beats accented',
          ),
          const AccentPattern(
            name: 'Strong-Weak-Weak-Weak-Medium-Weak-Weak-Weak',
            accents: [true, false, false, false, true, false, false, false],
            description: 'First and fifth beats accented',
          ),
        ];
      default:
        return [];
    }
  }
}
