import 'package:flutter/material.dart';
import '../models/onboarding_page_model.dart';

/// A widget that displays a single onboarding page with its content and styling.
/// 
/// This widget renders the visual content of an onboarding page including
/// title, description, and optional image or custom widget. It applies
/// the styling and layout configuration specified in the [OnboardingPageModel].
/// 
/// The widget is fully responsive and accessible, with proper semantic
/// labeling for screen readers. It supports both image assets and custom
/// widgets for maximum design flexibility.
/// 
/// The layout prioritizes custom widgets over image assets when both are
/// provided, ensuring predictable rendering behavior.
/// 
/// Example usage:
/// ```dart
/// OnboardingPageWidget(
///   page: OnboardingPageModel(
///     title: 'Welcome',
///     description: 'Get started with our app',
///     customWidget: Icon(Icons.star, size: 100),
///   ),
/// )
/// ```
class OnboardingPageWidget extends StatelessWidget {
  /// The onboarding page model containing all content and styling information.
  /// This model defines what content to display and how to style it.
  final OnboardingPageModel page;

  /// Creates an onboarding page widget with the specified page model.
  /// 
  /// The [page] parameter is required and contains all the necessary
  /// information to render the page content and apply styling.
  const OnboardingPageWidget({
    super.key,
    required this.page,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      // Apply page-specific background color if provided
      color: page.backgroundColor,
      // Apply custom padding or use default
      padding: page.padding ?? const EdgeInsets.all(24.0),
      child: Column(
        // Apply custom alignment or use defaults
        mainAxisAlignment: page.mainAxisAlignment ?? MainAxisAlignment.center,
        crossAxisAlignment:
            page.crossAxisAlignment ?? CrossAxisAlignment.center,
        children: [
          // Visual content section (image or custom widget)
          // Custom widget takes precedence over image asset
          if (page.customWidget != null)
            Flexible(child: page.customWidget!)
          else if (page.imageAsset != null)
            Flexible(
              child: Semantics(
                image: true,
                label: 'Onboarding illustration',
                child: Image.asset(
                  page.imageAsset!,
                  fit: BoxFit.contain, // Ensure image fits within bounds
                ),
              ),
            ),

          // Add spacing if visual content exists
          if (page.customWidget != null || page.imageAsset != null)
            const SizedBox(height: 32),

          // Title section with semantic header labeling
          Semantics(
            header: true, // Mark as header for accessibility
            child: Text(
              page.title,
              style:
                  page.titleStyle ?? Theme.of(context).textTheme.headlineMedium,
              textAlign: TextAlign.center,
            ),
          ),

          // Spacing between title and description
          const SizedBox(height: 16),

          // Description section
          Text(
            page.description,
            style:
                page.descriptionStyle ?? Theme.of(context).textTheme.bodyLarge,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
