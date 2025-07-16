import 'package:flutter/material.dart';
import '../models/onboarding_config.dart';

/// Widget for displaying progress through onboarding screens
class ProgressIndicatorWidget extends StatelessWidget {
  final int currentIndex;
  final int totalPages;
  final ProgressIndicatorType type;
  final Color? activeColor;
  final Color? inactiveColor;
  final double? dotSize;
  final double? spacing;
  final double? barHeight;
  final BorderRadius? barBorderRadius;

  const ProgressIndicatorWidget({
    Key? key,
    required this.currentIndex,
    required this.totalPages,
    this.type = ProgressIndicatorType.dots,
    this.activeColor,
    this.inactiveColor,
    this.dotSize = 8.0,
    this.spacing = 8.0,
    this.barHeight = 4.0,
    this.barBorderRadius,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final effectiveActiveColor = activeColor ?? theme.primaryColor;
    final effectiveInactiveColor = inactiveColor ?? theme.disabledColor;

    switch (type) {
      case ProgressIndicatorType.dots:
        return _buildDots(effectiveActiveColor, effectiveInactiveColor);
      case ProgressIndicatorType.bar:
        return _buildBar(effectiveActiveColor, effectiveInactiveColor);
      case ProgressIndicatorType.none:
        return const SizedBox.shrink();
    }
  }

  Widget _buildDots(Color activeColor, Color inactiveColor) {
    return Semantics(
      label: 'Page ${currentIndex + 1} of $totalPages',
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: List.generate(
          totalPages,
          (index) => AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            margin: EdgeInsets.symmetric(horizontal: spacing! / 2),
            width: dotSize,
            height: dotSize,
            decoration: BoxDecoration(
              color: index == currentIndex ? activeColor : inactiveColor,
              shape: BoxShape.circle,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBar(Color activeColor, Color inactiveColor) {
    return Semantics(
      label: 'Progress: ${((currentIndex + 1) / totalPages * 100).round()}%',
      child: Container(
        width: 200,
        height: barHeight,
        decoration: BoxDecoration(
          color: inactiveColor,
          borderRadius: barBorderRadius ?? BorderRadius.circular(barHeight! / 2),
        ),
        child: FractionallySizedBox(
          alignment: Alignment.centerLeft,
          widthFactor: (currentIndex + 1) / totalPages,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            decoration: BoxDecoration(
              color: activeColor,
              borderRadius: barBorderRadius ?? BorderRadius.circular(barHeight! / 2),
            ),
          ),
        ),
      ),
    );
  }
}
