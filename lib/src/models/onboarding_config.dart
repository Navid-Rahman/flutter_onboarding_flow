import 'package:flutter/material.dart';

/// Configuration for the entire onboarding flow
class OnboardingConfig {
  final bool showSkipButton;
  final bool showBackButton;
  final bool showProgressIndicator;
  final ProgressIndicatorType progressIndicatorType;
  final Color? progressIndicatorColor;
  final Color? progressIndicatorBackgroundColor;
  final String skipButtonText;
  final String nextButtonText;
  final String doneButtonText;
  final String backButtonText;
  final TextStyle? buttonTextStyle;
  final ButtonStyle? buttonStyle;
  final EdgeInsets? buttonPadding;
  final Duration animationDuration;
  final Curve animationCurve;
  final PageTransitionType transitionType;
  final bool enableSwipeGesture;
  final String storageKey;
  final bool autoSave;

  const OnboardingConfig({
    this.showSkipButton = true,
    this.showBackButton = true,
    this.showProgressIndicator = true,
    this.progressIndicatorType = ProgressIndicatorType.dots,
    this.progressIndicatorColor,
    this.progressIndicatorBackgroundColor,
    this.skipButtonText = 'Skip',
    this.nextButtonText = 'Next',
    this.doneButtonText = 'Get Started',
    this.backButtonText = 'Back',
    this.buttonTextStyle,
    this.buttonStyle,
    this.buttonPadding,
    this.animationDuration = const Duration(milliseconds: 300),
    this.animationCurve = Curves.easeInOut,
    this.transitionType = PageTransitionType.slide,
    this.enableSwipeGesture = true,
    this.storageKey = 'onboarding_completed',
    this.autoSave = true,
  });
}

enum ProgressIndicatorType { dots, bar, none }

enum PageTransitionType { slide, fade, zoom, scale }
