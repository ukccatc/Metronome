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
              style: AppTextStyles.labelLarge.copyWith(
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

    return ChoiceChip(
      label: Text(
        _getSubdivisionLabel(subdivision),
        style: AppTextStyles.labelMedium.copyWith(
          color: isSelected ? AppColors.textOnPrimary : AppColors.textPrimary,
        ),
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
}
