import 'package:flutter/material.dart';
import '../models/onboarding_config.dart';

/// A customizable progress indicator widget for displaying user progress through onboarding screens.
/// 
/// This widget supports multiple display types including dots, progress bars, and none (hidden).
/// It automatically adapts to the current theme colors while allowing full customization
/// of appearance and behavior.
/// 
/// The widget is designed to be accessible with proper semantic labeling for screen readers
/// and includes smooth animations when transitioning between progress states.
/// 
/// Example usage:
/// ```dart
/// ProgressIndicatorWidget(
///   currentIndex: 2,
///   totalPages: 5,
///   type: ProgressIndicatorType.dots,
///   activeColor: Colors.blue,
///   inactiveColor: Colors.grey,
/// )
/// ```
class ProgressIndicatorWidget extends StatelessWidget {
  /// The current page index (0-based).
  /// This determines which progress element is highlighted as active.
  final int currentIndex;

  /// The total number of pages in the onboarding flow.
  /// Used to calculate progress percentage and determine number of dots.
  final int totalPages;

  /// The type of progress indicator to display.
  /// Options: dots (default), bar, or none.
  final ProgressIndicatorType type;

  /// The color for the active/current progress element.
  /// If null, uses the theme's primary color.
  final Color? activeColor;

  /// The color for inactive/background progress elements.
  /// If null, uses the theme's disabled color.
  final Color? inactiveColor;

  /// The size of dots in the dots indicator type.
  /// Only applies when type is [ProgressIndicatorType.dots].
  /// Defaults to 8.0 pixels.
  final double? dotSize;

  /// The spacing between dots in the dots indicator type.
  /// Only applies when type is [ProgressIndicatorType.dots].
  /// Defaults to 8.0 pixels.
  final double? spacing;

  /// The height of the progress bar in the bar indicator type.
  /// Only applies when type is [ProgressIndicatorType.bar].
  /// Defaults to 4.0 pixels.
  final double? barHeight;

  /// The border radius for the progress bar.
  /// Only applies when type is [ProgressIndicatorType.bar].
  /// If null, uses a circular border radius based on bar height.
  final BorderRadius? barBorderRadius;

  /// Creates a progress indicator widget with the specified configuration.
  /// 
  /// The [currentIndex] and [totalPages] parameters are required.
  /// All other parameters have sensible defaults and are optional.
  const ProgressIndicatorWidget({
    super.key,
    required this.currentIndex,
    required this.totalPages,
    this.type = ProgressIndicatorType.dots,
    this.activeColor,
    this.inactiveColor,
    this.dotSize = 8.0,
    this.spacing = 8.0,
    this.barHeight = 4.0,
    this.barBorderRadius,
  });

  @override
  Widget build(BuildContext context) {
    // Extract theme colors with fallbacks
    final theme = Theme.of(context);
    final effectiveActiveColor = activeColor ?? theme.primaryColor;
    final effectiveInactiveColor = inactiveColor ?? theme.disabledColor;

    // Build the appropriate indicator type
    switch (type) {
      case ProgressIndicatorType.dots:
        return _buildDots(effectiveActiveColor, effectiveInactiveColor);
      case ProgressIndicatorType.bar:
        return _buildBar(effectiveActiveColor, effectiveInactiveColor);
      case ProgressIndicatorType.none:
        // Return an empty widget that takes no space
        return const SizedBox.shrink();
    }
  }

  /// Builds a dots-style progress indicator.
  /// 
  /// Creates a row of circular dots where the current page is highlighted
  /// with the active color and other pages use the inactive color.
  /// Includes smooth animation transitions when the current page changes.
  /// 
  /// The method automatically generates the correct number of dots based
  /// on [totalPages] and applies proper accessibility labeling.
  Widget _buildDots(Color activeColor, Color inactiveColor) {
    return Semantics(
      // Provide screen reader accessibility
      label: 'Page ${currentIndex + 1} of $totalPages',
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: List.generate(
          totalPages,
          (index) => AnimatedContainer(
            // Smooth color transition animation
            duration: const Duration(milliseconds: 200),
            margin: EdgeInsets.symmetric(horizontal: spacing! / 2),
            width: dotSize,
            height: dotSize,
            decoration: BoxDecoration(
              // Highlight current page dot
              color: index == currentIndex ? activeColor : inactiveColor,
              shape: BoxShape.circle,
            ),
          ),
        ),
      ),
    );
  }

  /// Builds a bar-style progress indicator.
  /// 
  /// Creates a horizontal progress bar that fills based on the current
  /// progress through the onboarding flow. The bar smoothly animates
  /// as the user progresses through pages.
  /// 
  /// The progress percentage is calculated as (currentIndex + 1) / totalPages
  /// to show completion progress rather than just current position.
  Widget _buildBar(Color activeColor, Color inactiveColor) {
    return Semantics(
      // Provide screen reader accessibility with percentage
      label: 'Progress: ${((currentIndex + 1) / totalPages * 100).round()}%',
      child: Container(
        width: 200, // Fixed width for consistent appearance
        height: barHeight,
        decoration: BoxDecoration(
          color: inactiveColor, // Background color
          borderRadius:
              barBorderRadius ?? BorderRadius.circular(barHeight! / 2),
        ),
        child: FractionallySizedBox(
          alignment: Alignment.centerLeft,
          // Calculate progress as a fraction (0.0 to 1.0)
          widthFactor: (currentIndex + 1) / totalPages,
          child: AnimatedContainer(
            // Smooth progress animation
            duration: const Duration(milliseconds: 300),
            decoration: BoxDecoration(
              color: activeColor, // Foreground/progress color
              borderRadius:
                  barBorderRadius ?? BorderRadius.circular(barHeight! / 2),
            ),
          ),
        ),
      ),
    );
  }
}
