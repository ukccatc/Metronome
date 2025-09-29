/// BPM display widget
/// This widget shows the current BPM with controls

import 'package:flutter/material.dart';
import '../../constants/theme.dart';
import '../../constants/text_styles.dart';
import '../../constants/constants.dart';

class BpmDisplay extends StatelessWidget {
  final int bpm;
  final Function(int) onBpmChanged;
  final bool isEnabled;

  const BpmDisplay({
    super.key,
    required this.bpm,
    required this.onBpmChanged,
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
          children: [
            Text(
              'BPM',
              style: AppTextStyles.labelLarge.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
            const SizedBox(height: kDefaultSpacing),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildBpmButton(
                  icon: Icons.remove,
                  onPressed: isEnabled && bpm > kMinBpm
                      ? () => onBpmChanged(bpm - 1)
                      : null,
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: kDefaultPadding,
                    vertical: kDefaultSpacing,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.primary.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(kDefaultBorderRadius),
                  ),
                  child: Text(
                    '$bpm',
                    style: AppTextStyles.bpmDisplay.copyWith(
                      color: AppColors.primary,
                    ),
                  ),
                ),
                _buildBpmButton(
                  icon: Icons.add,
                  onPressed: isEnabled && bpm < kMaxBpm
                      ? () => onBpmChanged(bpm + 1)
                      : null,
                ),
              ],
            ),
            const SizedBox(height: kDefaultSpacing),
            // BPM slider
            Slider(
              value: bpm.toDouble(),
              min: kMinBpm.toDouble(),
              max: kMaxBpm.toDouble(),
              divisions: kMaxBpm - kMinBpm,
              onChanged: isEnabled
                  ? (value) => onBpmChanged(value.round())
                  : null,
              activeColor: AppColors.primary,
              inactiveColor: AppColors.primary.withOpacity(0.3),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBpmButton({
    required IconData icon,
    required VoidCallback? onPressed,
  }) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: onPressed != null 
            ? AppColors.primary 
            : AppColors.primary.withOpacity(0.3),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(20),
          onTap: onPressed,
          child: Icon(
            icon,
            color: onPressed != null 
                ? AppColors.textOnPrimary 
                : AppColors.textSecondary,
            size: 20,
          ),
        ),
      ),
    );
  }
}
