/// Time signature selector widget
/// This widget allows users to select the time signature

import 'package:flutter/material.dart';
import '../../constants/theme.dart';
import '../../constants/text_styles.dart';
import '../../constants/constants.dart';

class TimeSignatureSelector extends StatelessWidget {
  final int selectedSignature;
  final Function(int) onSignatureChanged;
  final bool isEnabled;
  final List<int> availableSignatures;

  const TimeSignatureSelector({
    super.key,
    required this.selectedSignature,
    required this.onSignatureChanged,
    this.isEnabled = true,
    this.availableSignatures = const [2, 3, 4, 5, 6, 7, 8],
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
              'Time Signature',
              style: AppTextStyles.titleMedium,
            ),
            const SizedBox(height: 4),
            Text(
              'Set how many beats per measure. 4/4 (Common) is most popular, 3/4 (Waltz) for dancing, 2/4 (March) for marching music.',
              style: AppTextStyles.bodySmall.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
            const SizedBox(height: kDefaultSpacing),
            Wrap(
              spacing: kDefaultSpacing,
              runSpacing: kDefaultSpacing,
              children: availableSignatures.map((signature) {
                return _buildSignatureChip(signature);
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSignatureChip(int signature) {
    final isSelected = signature == selectedSignature;
    final signatureName = _getSignatureName(signature);

    return ChoiceChip(
      label: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            '$signature/4',
            style: AppTextStyles.labelMedium.copyWith(
              color: isSelected ? AppColors.textOnPrimary : AppColors.textPrimary,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            signatureName,
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
                onSignatureChanged(signature);
              }
            }
          : null,
      selectedColor: AppColors.primary,
      backgroundColor: AppColors.surface,
      disabledColor: AppColors.surface.withValues(alpha: 0.5),
      side: BorderSide(
        color: isSelected
            ? AppColors.primary
            : AppColors.primary.withValues(alpha: 0.3),
        width: 1,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(kDefaultBorderRadius),
      ),
    );
  }

  String _getSignatureName(int signature) {
    switch (signature) {
      case 2:
        return 'March';
      case 3:
        return 'Waltz';
      case 4:
        return 'Common';
      case 5:
        return 'Quintuple';
      case 6:
        return 'Compound';
      case 7:
        return 'Septuple';
      case 8:
        return 'Octuple';
      default:
        return 'Custom';
    }
  }
}
