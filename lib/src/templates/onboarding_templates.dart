import 'package:flutter/material.dart';
import '../models/onboarding_page_model.dart';
import '../models/onboarding_config.dart';

/// Pre-built onboarding templates
class OnboardingTemplates {
  /// Welcome template - introduces the app
  static List<OnboardingPageModel> welcomeTemplate({
    required String appName,
    String? appDescription,
    String? logoAsset,
  }) {
    return [
      OnboardingPageModel(
        title: 'Welcome to $appName',
        description:
            appDescription ?? 'Let\'s get you started with a quick tour',
        imageAsset: logoAsset,
        titleStyle: const TextStyle(
          fontSize: 28,
          fontWeight: FontWeight.bold,
          color: Colors.black87,
        ),
        descriptionStyle: const TextStyle(
          fontSize: 16,
          color: Colors.black54,
        ),
      ),
    ];
  }

  /// Feature highlights template
  static List<OnboardingPageModel> featureHighlightsTemplate({
    required List<Map<String, String>> features,
  }) {
    return features.map((feature) {
      return OnboardingPageModel(
        title: feature['title'] ?? '',
        description: feature['description'] ?? '',
        imageAsset: feature['image'],
        titleStyle: const TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.w600,
          color: Colors.black87,
        ),
        descriptionStyle: const TextStyle(
          fontSize: 14,
          color: Colors.black54,
          height: 1.5,
        ),
      );
    }).toList();
  }

  /// Permissions template
  static List<OnboardingPageModel> permissionsTemplate({
    required List<Map<String, String>> permissions,
  }) {
    return permissions.map((permission) {
      return OnboardingPageModel(
        title: permission['title'] ?? '',
        description: permission['description'] ?? '',
        customWidget: Icon(
          _getPermissionIcon(permission['type']),
          size: 80,
          color: Colors.blue,
        ),
        titleStyle: const TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.w600,
          color: Colors.black87,
        ),
        descriptionStyle: const TextStyle(
          fontSize: 14,
          color: Colors.black54,
          height: 1.6,
        ),
      );
    }).toList();
  }

  /// Complete onboarding template combining all elements
  static List<OnboardingPageModel> completeTemplate({
    required String appName,
    String? appDescription,
    String? logoAsset,
    List<Map<String, String>>? features,
    List<Map<String, String>>? permissions,
  }) {
    final pages = <OnboardingPageModel>[];

    // Welcome page
    pages.addAll(welcomeTemplate(
      appName: appName,
      appDescription: appDescription,
      logoAsset: logoAsset,
    ));

    // Feature pages
    if (features != null && features.isNotEmpty) {
      pages.addAll(featureHighlightsTemplate(features: features));
    }

    // Permission pages
    if (permissions != null && permissions.isNotEmpty) {
      pages.addAll(permissionsTemplate(permissions: permissions));
    }

    return pages;
  }

  /// Get started configuration
  static OnboardingConfig getStartedConfig() {
    return const OnboardingConfig(
      showSkipButton: true,
      showBackButton: true,
      showProgressIndicator: true,
      progressIndicatorType: ProgressIndicatorType.dots,
      skipButtonText: 'Skip',
      nextButtonText: 'Next',
      doneButtonText: 'Get Started',
      backButtonText: 'Back',
      animationDuration: Duration(milliseconds: 300),
      animationCurve: Curves.easeInOut,
      enableSwipeGesture: true,
      autoSave: true,
    );
  }

  static IconData _getPermissionIcon(String? type) {
    switch (type?.toLowerCase()) {
      case 'camera':
        return Icons.camera_alt;
      case 'location':
        return Icons.location_on;
      case 'notifications':
        return Icons.notifications;
      case 'storage':
        return Icons.storage;
      case 'microphone':
        return Icons.mic;
      case 'contacts':
        return Icons.contacts;
      default:
        return Icons.security;
    }
  }
}
