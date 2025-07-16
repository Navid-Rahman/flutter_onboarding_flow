import 'package:flutter/material.dart';
import '../models/onboarding_page_model.dart';
import '../models/onboarding_config.dart';

/// A collection of pre-built onboarding templates for common use cases.
///
/// This class provides ready-to-use onboarding flows that can be easily
/// customized and integrated into any Flutter application. Templates cover
/// typical onboarding scenarios including app introductions, feature highlights,
/// permission requests, and complete multi-step flows.
///
/// All templates return lists of [OnboardingPageModel] objects that can be
/// used directly with the [OnboardingFlow] widget. Each template includes
/// sensible styling defaults and can be further customized as needed.
///
/// Example usage:
/// ```dart
/// // Create a complete onboarding flow
/// final pages = OnboardingTemplates.completeTemplate(
///   appName: 'MyApp',
///   appDescription: 'Welcome to the best app ever!',
///   features: [
///     {'title': 'Fast', 'description': 'Lightning fast performance'},
///     {'title': 'Secure', 'description': 'Your data is safe with us'},
///   ],
///   permissions: [
///     {'title': 'Camera Access', 'description': 'For taking photos', 'type': 'camera'},
///   ],
/// );
///
/// // Use with OnboardingFlow
/// OnboardingFlow(
///   pages: pages,
///   config: OnboardingTemplates.getStartedConfig(),
/// )
/// ```
///
/// All templates are designed to be:
/// - Accessible with proper semantic labeling
/// - Responsive across different screen sizes
/// - Consistent with Material Design guidelines
/// - Easy to customize and extend
///
/// See also:
/// - [OnboardingPageModel] for individual page structure
/// - [OnboardingConfig] for flow configuration options
/// - [OnboardingFlow] for the main widget implementation
class OnboardingTemplates {
  /// Creates a welcome page template for introducing users to the application.
  ///
  /// This template generates a single welcoming page that introduces the app
  /// with customizable branding elements. Typically used as the first page
  /// in an onboarding flow to create a positive first impression.
  ///
  /// Parameters:
  /// - [appName]: The name of the application (required)
  /// - [appDescription]: Optional description text. Defaults to a generic welcome message
  /// - [logoAsset]: Optional path to the app logo image asset
  ///
  /// Returns a single-item list containing the welcome page model with
  /// pre-styled title and description text.
  ///
  /// Example:
  /// ```dart
  /// final welcomePage = OnboardingTemplates.welcomeTemplate(
  ///   appName: 'MyApp',
  ///   appDescription: 'The most amazing app you\'ll ever use!',
  ///   logoAsset: 'assets/images/logo.png',
  /// );
  /// ```
  ///
  /// The generated page includes:
  /// - Large, bold title with app name
  /// - Descriptive subtitle
  /// - Optional logo display
  /// - Consistent Material Design styling
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

  /// Creates feature highlight pages showcasing key application capabilities.
  ///
  /// This template generates multiple pages, each highlighting a specific
  /// feature or benefit of the application. Perfect for demonstrating
  /// value propositions and key functionality to new users.
  ///
  /// Parameters:
  /// - [features]: List of feature maps, each containing:
  ///   - 'title': Feature name or headline
  ///   - 'description': Detailed feature explanation
  ///   - 'image': Optional image asset path for visual representation
  ///
  /// Returns a list of pages, one for each feature provided.
  ///
  /// Example:
  /// ```dart
  /// final featurePages = OnboardingTemplates.featureHighlightsTemplate(
  ///   features: [
  ///     {
  ///       'title': 'Smart Analytics',
  ///       'description': 'Get insights into your data with AI-powered analytics',
  ///       'image': 'assets/features/analytics.png',
  ///     },
  ///     {
  ///       'title': 'Real-time Sync',
  ///       'description': 'Your data stays synchronized across all devices',
  ///       'image': 'assets/features/sync.png',
  ///     },
  ///   ],
  /// );
  /// ```
  ///
  /// Each feature page includes:
  /// - Prominent feature title
  /// - Detailed description with proper line spacing
  /// - Optional feature illustration
  /// - Consistent styling across all feature pages
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

  /// Creates permission request pages with appropriate icons and explanations.
  ///
  /// This template generates pages that help users understand why specific
  /// permissions are needed and how they benefit the user experience.
  /// Each permission gets its own page with relevant iconography.
  ///
  /// Parameters:
  /// - [permissions]: List of permission maps, each containing:
  ///   - 'title': Permission name or purpose
  ///   - 'description': Clear explanation of why the permission is needed
  ///   - 'type': Permission type for automatic icon selection
  ///     (camera, location, notifications, storage, microphone, contacts)
  ///
  /// Returns a list of pages, one for each permission with appropriate
  /// Material Design icons and consistent styling.
  ///
  /// Example:
  /// ```dart
  /// final permissionPages = OnboardingTemplates.permissionsTemplate(
  ///   permissions: [
  ///     {
  ///       'title': 'Camera Access',
  ///       'description': 'Take photos and scan QR codes for quick actions',
  ///       'type': 'camera',
  ///     },
  ///     {
  ///       'title': 'Location Services',
  ///       'description': 'Find nearby places and get location-based recommendations',
  ///       'type': 'location',
  ///     },
  ///   ],
  /// );
  /// ```
  ///
  /// Each permission page includes:
  /// - Contextual icon representing the permission type
  /// - Clear, benefit-focused title
  /// - Detailed explanation of permission usage
  /// - User-friendly styling to reduce permission anxiety
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

  /// Creates a comprehensive onboarding flow combining multiple template types.
  ///
  /// This is a convenience method that creates a complete onboarding experience
  /// by combining welcome, feature highlight, and permission pages in a logical
  /// sequence. Perfect for apps that need a full introduction flow.
  ///
  /// Parameters:
  /// - [appName]: Application name for the welcome page (required)
  /// - [appDescription]: Optional custom welcome description
  /// - [logoAsset]: Optional app logo for branding
  /// - [features]: Optional list of features to highlight
  /// - [permissions]: Optional list of permissions to request
  ///
  /// Returns a complete list of pages in logical order:
  /// 1. Welcome page
  /// 2. Feature highlight pages (if provided)
  /// 3. Permission request pages (if provided)
  ///
  /// Example:
  /// ```dart
  /// final completeFlow = OnboardingTemplates.completeTemplate(
  ///   appName: 'PhotoApp',
  ///   appDescription: 'The best way to organize and share your photos',
  ///   logoAsset: 'assets/logo.png',
  ///   features: [
  ///     {'title': 'AI Organization', 'description': 'Automatically organize photos'},
  ///     {'title': 'Cloud Backup', 'description': 'Never lose a memory'},
  ///   ],
  ///   permissions: [
  ///     {'title': 'Photo Access', 'description': 'To organize your photos', 'type': 'storage'},
  ///     {'title': 'Camera Access', 'description': 'To take new photos', 'type': 'camera'},
  ///   ],
  /// );
  /// ```
  ///
  /// The template automatically:
  /// - Orders pages logically for best user experience
  /// - Applies consistent styling across all page types
  /// - Handles empty sections gracefully
  /// - Ensures proper information architecture
  static List<OnboardingPageModel> completeTemplate({
    required String appName,
    String? appDescription,
    String? logoAsset,
    List<Map<String, String>>? features,
    List<Map<String, String>>? permissions,
  }) {
    final pages = <OnboardingPageModel>[];

    // Add welcome page as the foundation
    pages.addAll(welcomeTemplate(
      appName: appName,
      appDescription: appDescription,
      logoAsset: logoAsset,
    ));

    // Add feature highlight pages if provided
    if (features != null && features.isNotEmpty) {
      pages.addAll(featureHighlightsTemplate(features: features));
    }

    // Add permission request pages if provided
    if (permissions != null && permissions.isNotEmpty) {
      pages.addAll(permissionsTemplate(permissions: permissions));
    }

    return pages;
  }

  /// Provides a pre-configured onboarding configuration optimized for getting started flows.
  ///
  /// This configuration includes sensible defaults for most onboarding scenarios,
  /// emphasizing user control and smooth interactions. The configuration enables
  /// all navigation options and provides a complete user experience.
  ///
  /// Returns an [OnboardingConfig] with:
  /// - Skip functionality enabled for user autonomy
  /// - Back navigation for flexibility
  /// - Dot-style progress indicators for visual feedback
  /// - Smooth animations with standard Material durations
  /// - Swipe gestures enabled for intuitive navigation
  /// - Auto-save functionality for session persistence
  /// - User-friendly button labels
  ///
  /// Example:
  /// ```dart
  /// OnboardingFlow(
  ///   pages: myPages,
  ///   config: OnboardingTemplates.getStartedConfig(),
  /// )
  /// ```
  ///
  /// This configuration can be further customized:
  /// ```dart
  /// final config = OnboardingTemplates.getStartedConfig().copyWith(
  ///   progressIndicatorColor: Colors.blue,
  ///   nextButtonText: 'Continue',
  /// );
  /// ```
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

  /// Maps permission type strings to appropriate Material Design icons.
  ///
  /// This private helper method provides consistent iconography for
  /// permission request pages. Supports common permission types and
  /// falls back to a generic security icon for unknown types.
  ///
  /// Supported permission types:
  /// - 'camera': Camera/photo capture permissions
  /// - 'location': GPS and location services
  /// - 'notifications': Push notification permissions
  /// - 'storage': File system and storage access
  /// - 'microphone': Audio recording permissions
  /// - 'contacts': Address book access
  /// - Default: Generic security icon for unknown types
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
