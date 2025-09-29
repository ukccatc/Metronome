/// Beat subdivision selector widget
/// Allows users to select beat subdivisions (quarter, eighth, triplet, sixteenth)

import 'package:flutter/material.dart';
import '../../constants/theme.dart';
import '../../constants/text_styles.dart';
import '../../constants/constants.dart';
import '../../models/m_metronome.dart';

class BeatSubdivisionSelector extends StatelessWidget {
  final BeatSubdivision selectedSubdivision;
  final Function(BeatSubdivision) onSubdivisionChanged;
  final bool isEnabled;

  const BeatSubdivisionSelector({
    super.key,
    required this.selectedSubdivision,
    required this.onSubdivisionChanged,
    this.isEnabled = true,
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
            Text(
              'Beat Subdivision',
              style: AppTextStyles.titleMedium,
            ),
            const SizedBox(height: 4),
            Text(
              'Choose how the beats are divided. Quarter (1/4) is standard, Eighth (1/8) plays twice as fast, Triplet (1/3) creates swing feel, Sixteenth (1/16) is very fast.',
              style: AppTextStyles.bodySmall.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
            const SizedBox(height: kDefaultSpacing),
            Wrap(
              spacing: kDefaultSpacing,
              runSpacing: kDefaultSpacing,
              children: BeatSubdivision.values.map((subdivision) {
                return _buildSubdivisionChip(subdivision);
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSubdivisionChip(BeatSubdivision subdivision) {
    final isSelected = subdivision == selectedSubdivision;
    final subdivisionName = _getSubdivisionName(subdivision);

    return ChoiceChip(
      label: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            _getSubdivisionLabel(subdivision),
            style: AppTextStyles.labelMedium.copyWith(
              color: isSelected ? AppColors.textOnPrimary : AppColors.textPrimary,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            subdivisionName,
            style: AppTextStyles.bodySmall.copyWith(
              color: isSelected ? AppColors.textOnPrimary : AppColors.textSecondary,
            ),
          ),
        ],
      ),
      selected: isSelected,
      onSelected: isEnabled
          ? (selected) {
              if (selected) {
                onSubdivisionChanged(subdivision);
              }
            }
          : null,
      selectedColor: AppColors.primary,
      backgroundColor: AppColors.surface,
      disabledColor: AppColors.surface.withOpacity(0.5),
      side: BorderSide(
        color: isSelected
            ? AppColors.primary
            : AppColors.primary.withOpacity(0.3),
        width: 1,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(kDefaultBorderRadius),
      ),
    );
  }

  String _getSubdivisionLabel(BeatSubdivision subdivision) {
    switch (subdivision) {
      case BeatSubdivision.quarter:
        return '1/4';
      case BeatSubdivision.eighth:
        return '1/8';
      case BeatSubdivision.triplet:
        return '1/3';
      case BeatSubdivision.sixteenth:
        return '1/16';
    }
  }

  String _getSubdivisionName(BeatSubdivision subdivision) {
    switch (subdivision) {
      case BeatSubdivision.quarter:
        return 'Quarter';
      case BeatSubdivision.eighth:
        return 'Eighth';
      case BeatSubdivision.triplet:
        return 'Triplet';
      case BeatSubdivision.sixteenth:
        return 'Sixteenth';
    }
  }
}
