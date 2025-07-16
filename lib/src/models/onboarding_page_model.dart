import 'package:flutter/material.dart';

/// Represents a single onboarding page with all its content and styling options.
/// 
/// This model defines the structure and appearance of an individual page within
/// the onboarding flow. It supports both image assets and custom widgets for
/// maximum flexibility in design.
/// 
/// Example usage:
/// ```dart
/// OnboardingPageModel(
///   title: 'Welcome',
///   description: 'Get started with our app',
///   customWidget: Icon(Icons.waving_hand, size: 100),
///   backgroundColor: Colors.blue.shade50,
/// )
/// ```
class OnboardingPageModel {
  /// The main title text displayed on the page.
  /// This should be a concise, impactful headline.
  final String title;

  /// The descriptive text that provides more details about the page content.
  /// This text appears below the title and should explain the feature or concept.
  final String description;

  /// Optional path to an image asset to display on the page.
  /// If both [imageAsset] and [customWidget] are provided, [customWidget] takes precedence.
  final String? imageAsset;

  /// Optional custom widget to display instead of an image.
  /// This provides maximum flexibility for page content and takes precedence over [imageAsset].
  final Widget? customWidget;

  /// Optional background color for the entire page.
  /// If not provided, the default theme background will be used.
  final Color? backgroundColor;

  /// Optional custom text style for the title.
  /// If not provided, the theme's headlineMedium style will be used.
  final TextStyle? titleStyle;

  /// Optional custom text style for the description.
  /// If not provided, the theme's bodyLarge style will be used.
  final TextStyle? descriptionStyle;

  /// Optional padding around the page content.
  /// Defaults to EdgeInsets.all(24.0) if not specified.
  final EdgeInsets? padding;

  /// Vertical alignment of the page content within the column.
  /// Defaults to MainAxisAlignment.center.
  final MainAxisAlignment? mainAxisAlignment;

  /// Horizontal alignment of the page content within the column.
  /// Defaults to CrossAxisAlignment.center.
  final CrossAxisAlignment? crossAxisAlignment;

  /// Creates a new onboarding page model.
  /// 
  /// The [title] and [description] parameters are required.
  /// All other parameters are optional and will use sensible defaults.
  const OnboardingPageModel({
    required this.title,
    required this.description,
    this.imageAsset,
    this.customWidget,
    this.backgroundColor,
    this.titleStyle,
    this.descriptionStyle,
    this.padding,
    this.mainAxisAlignment = MainAxisAlignment.center,
    this.crossAxisAlignment = CrossAxisAlignment.center,
  });

  /// Creates a copy of this page model with the given fields replaced with new values.
  /// 
  /// This method is useful for creating variations of an existing page or
  /// updating specific properties while preserving others.
  /// 
  /// Example:
  /// ```dart
  /// final newPage = originalPage.copyWith(
  ///   title: 'Updated Title',
  ///   backgroundColor: Colors.red,
  /// );
  /// ```
  OnboardingPageModel copyWith({
    String? title,
    String? description,
    String? imageAsset,
    Widget? customWidget,
    Color? backgroundColor,
    TextStyle? titleStyle,
    TextStyle? descriptionStyle,
    EdgeInsets? padding,
    MainAxisAlignment? mainAxisAlignment,
    CrossAxisAlignment? crossAxisAlignment,
  }) {
    return OnboardingPageModel(
      title: title ?? this.title,
      description: description ?? this.description,
      imageAsset: imageAsset ?? this.imageAsset,
      customWidget: customWidget ?? this.customWidget,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      titleStyle: titleStyle ?? this.titleStyle,
      descriptionStyle: descriptionStyle ?? this.descriptionStyle,
      padding: padding ?? this.padding,
      mainAxisAlignment: mainAxisAlignment ?? this.mainAxisAlignment,
      crossAxisAlignment: crossAxisAlignment ?? this.crossAxisAlignment,
    );
  }
}
