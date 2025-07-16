import 'package:flutter/material.dart';
import '../models/onboarding_config.dart';

/// A widget that provides navigation controls for the onboarding flow.
///
/// This widget renders skip, back, next, and done buttons based on the current
/// onboarding state and configuration. It automatically shows/hides buttons
/// contextually and provides proper accessibility support.
///
/// The layout is responsive and follows Material Design guidelines, with
/// proper button placement and spacing. All buttons are fully customizable
/// through the provided configuration.
///
/// Example usage:
/// ```dart
/// NavigationControls(
///   currentIndex: 2,
///   totalPages: 5,
///   config: onboardingConfig,
///   onSkip: () => skipOnboarding(),
///   onNext: () => goToNextPage(),
///   onDone: () => completeOnboarding(),
/// )
/// ```
class NavigationControls extends StatelessWidget {
  /// The current page index (0-based).
  /// Used to determine which buttons to show and their behavior.
  final int currentIndex;

  /// The total number of pages in the onboarding flow.
  /// Used to determine when we're on the last page.
  final int totalPages;

  /// The onboarding configuration containing display and behavior settings.
  /// Controls button visibility, text, styling, and layout.
  final OnboardingConfig config;

  /// Callback function executed when the skip button is tapped.
  /// Should handle skipping the entire onboarding flow.
  final VoidCallback? onSkip;

  /// Callback function executed when the back button is tapped.
  /// Should navigate to the previous page.
  final VoidCallback? onBack;

  /// Callback function executed when the next button is tapped.
  /// Should navigate to the next page.
  final VoidCallback? onNext;

  /// Callback function executed when the done/completion button is tapped.
  /// Should complete the onboarding flow and navigate to the main app.
  final VoidCallback? onDone;

  /// Creates navigation controls with the specified configuration and callbacks.
  ///
  /// The [currentIndex], [totalPages], and [config] parameters are required.
  /// Callback functions are optional but should be provided for functionality.
  const NavigationControls({
    super.key,
    required this.currentIndex,
    required this.totalPages,
    required this.config,
    this.onSkip,
    this.onBack,
    this.onNext,
    this.onDone,
  });

  @override
  Widget build(BuildContext context) {
    // Determine current page state for conditional rendering
    final isLastPage = currentIndex == totalPages - 1;
    final isFirstPage = currentIndex == 0;

    return Padding(
      // Apply configured padding or use default
      padding: config.buttonPadding ?? const EdgeInsets.all(16.0),
      child: Row(
        // Distribute buttons across the full width
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Skip button - shown on all pages except the last
          if (config.showSkipButton && !isLastPage)
            Semantics(
              button: true,
              label: 'Skip onboarding',
              child: TextButton(
                onPressed: onSkip,
                style: config.buttonStyle,
                child: Text(
                  config.skipButtonText,
                  style: config.buttonTextStyle,
                ),
              ),
            )
          else
            // Placeholder to maintain layout when skip button is hidden
            const SizedBox.shrink(),

          // Back button - shown on all pages except the first
          if (config.showBackButton && !isFirstPage)
            Semantics(
              button: true,
              label: 'Go to previous page',
              child: TextButton(
                onPressed: onBack,
                style: config.buttonStyle,
                child: Text(
                  config.backButtonText,
                  style: config.buttonTextStyle,
                ),
              ),
            )
          else
            // Placeholder to maintain layout when back button is hidden
            const SizedBox.shrink(),

          // Next/Done button - always shown, text changes on last page
          Semantics(
            button: true,
            // Provide contextual accessibility label
            label: isLastPage ? 'Complete onboarding' : 'Go to next page',
            child: ElevatedButton(
              // Call appropriate callback based on page position
              onPressed: isLastPage ? onDone : onNext,
              style: config.buttonStyle,
              child: Text(
                // Show completion text on last page, next text otherwise
                isLastPage ? config.doneButtonText : config.nextButtonText,
                style: config.buttonTextStyle,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
