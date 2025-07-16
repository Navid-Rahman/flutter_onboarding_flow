import 'package:flutter/material.dart';
import '../models/onboarding_config.dart';

/// Widget for onboarding navigation controls (skip, back, next buttons)
class NavigationControls extends StatelessWidget {
  final int currentIndex;
  final int totalPages;
  final OnboardingConfig config;
  final VoidCallback? onSkip;
  final VoidCallback? onBack;
  final VoidCallback? onNext;
  final VoidCallback? onDone;

  const NavigationControls({
    Key? key,
    required this.currentIndex,
    required this.totalPages,
    required this.config,
    this.onSkip,
    this.onBack,
    this.onNext,
    this.onDone,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isLastPage = currentIndex == totalPages - 1;
    final isFirstPage = currentIndex == 0;

    return Padding(
      padding: config.buttonPadding ?? const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Skip button
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
            const SizedBox.shrink(),

          // Back button
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
            const SizedBox.shrink(),

          // Next/Done button
          Semantics(
            button: true,
            label: isLastPage ? 'Complete onboarding' : 'Go to next page',
            child: ElevatedButton(
              onPressed: isLastPage ? onDone : onNext,
              style: config.buttonStyle,
              child: Text(
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
