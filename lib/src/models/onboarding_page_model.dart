import 'package:flutter/material.dart';

/// Represents a single onboarding page with all its content and styling
class OnboardingPageModel {
  final String title;
  final String description;
  final String? imageAsset;
  final Widget? customWidget;
  final Color? backgroundColor;
  final TextStyle? titleStyle;
  final TextStyle? descriptionStyle;
  final EdgeInsets? padding;
  final MainAxisAlignment? mainAxisAlignment;
  final CrossAxisAlignment? crossAxisAlignment;

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
