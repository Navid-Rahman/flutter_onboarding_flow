import 'package:flutter/material.dart';

/// Configuration class that controls the behavior and appearance of the entire onboarding flow.
/// 
/// This comprehensive configuration allows customization of navigation controls,
/// progress indicators, animations, and storage behavior. It provides sensible
/// defaults while allowing fine-grained control over the onboarding experience.
/// 
/// Example usage:
/// ```dart
/// OnboardingConfig(
///   showSkipButton: true,
///   progressIndicatorType: ProgressIndicatorType.bar,
///   progressIndicatorColor: Colors.blue,
///   animationDuration: Duration(milliseconds: 500),
///   enableSwipeGesture: true,
/// )
/// ```
class OnboardingConfig {
  /// Whether to show the skip button that allows users to bypass the onboarding.
  /// Defaults to true. The skip button appears on all pages except the last one.
  final bool showSkipButton;

  /// Whether to show the back button that allows users to return to previous pages.
  /// Defaults to true. The back button appears on all pages except the first one.
  final bool showBackButton;

  /// Whether to show the progress indicator at the top of the onboarding flow.
  /// Defaults to true. When false, no progress indication will be displayed.
  final bool showProgressIndicator;

  /// The type of progress indicator to display.
  /// Options: dots (default), bar, or none.
  final ProgressIndicatorType progressIndicatorType;

  /// The color of the active/current progress indicator element.
  /// If null, uses the theme's primary color.
  final Color? progressIndicatorColor;

  /// The color of the inactive/background progress indicator elements.
  /// If null, uses the theme's disabled color.
  final Color? progressIndicatorBackgroundColor;

  /// The text displayed on the skip button.
  /// Defaults to 'Skip'. Supports localization.
  final String skipButtonText;

  /// The text displayed on the next button.
  /// Defaults to 'Next'. Supports localization.
  final String nextButtonText;

  /// The text displayed on the final completion button.
  /// Defaults to 'Get Started'. Supports localization.
  final String doneButtonText;

  /// The text displayed on the back button.
  /// Defaults to 'Back'. Supports localization.
  final String backButtonText;

  /// Optional custom text style for all navigation buttons.
  /// If null, uses the theme's default button text style.
  final TextStyle? buttonTextStyle;

  /// Optional custom button style for all navigation buttons.
  /// If null, uses the theme's default button style.
  final ButtonStyle? buttonStyle;

  /// Optional padding around the navigation controls area.
  /// Defaults to EdgeInsets.all(16.0) if not specified.
  final EdgeInsets? buttonPadding;

  /// The duration of page transition animations.
  /// Defaults to 300 milliseconds. Used for both automatic and gesture-based transitions.
  final Duration animationDuration;

  /// The animation curve used for page transitions.
  /// Defaults to Curves.easeInOut for smooth, natural feeling transitions.
  final Curve animationCurve;

  /// The type of transition animation between pages.
  /// Options: slide (default), fade, zoom, or scale.
  final PageTransitionType transitionType;

  /// Whether to enable swipe gestures for page navigation.
  /// Defaults to true. When false, users can only navigate using buttons.
  final bool enableSwipeGesture;

  /// The SharedPreferences key used to store onboarding completion status.
  /// Defaults to 'onboarding_completed'. Change this if you need multiple onboarding flows.
  final String storageKey;

  /// Whether to automatically save progress and completion status to local storage.
  /// Defaults to true. When false, manual storage management is required.
  final bool autoSave;

  /// Creates a new onboarding configuration with the specified options.
  /// 
  /// All parameters are optional and have sensible defaults for typical use cases.
  /// Customize only the aspects that differ from your design requirements.
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

/// Enumeration of available progress indicator types.
/// 
/// - [dots]: Circular dots showing current page position (default)
/// - [bar]: Linear progress bar showing completion percentage
/// - [none]: No progress indicator displayed
enum ProgressIndicatorType { 
  /// Displays circular dots indicating current page and total pages
  dots, 
  
  /// Displays a linear progress bar showing completion percentage
  bar, 
  
  /// No progress indicator is shown
  none 
}

/// Enumeration of available page transition animation types.
/// 
/// - [slide]: Pages slide horizontally (default)
/// - [fade]: Pages fade in and out
/// - [zoom]: Pages zoom in with fade effect
/// - [scale]: Pages scale up from center
enum PageTransitionType { 
  /// Horizontal slide transition between pages
  slide, 
  
  /// Fade transition between pages
  fade, 
  
  /// Zoom transition with scaling and fade effects
  zoom, 
  
  /// Scale transition from center point
  scale 
}
