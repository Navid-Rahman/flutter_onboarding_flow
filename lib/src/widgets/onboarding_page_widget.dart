import 'package:flutter/material.dart';
import '../models/onboarding_page_model.dart';

/// Widget for displaying a single onboarding page
class OnboardingPageWidget extends StatelessWidget {
  final OnboardingPageModel page;

  const OnboardingPageWidget({
    super.key,
    required this.page,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: page.backgroundColor,
      padding: page.padding ?? const EdgeInsets.all(24.0),
      child: Column(
        mainAxisAlignment: page.mainAxisAlignment ?? MainAxisAlignment.center,
        crossAxisAlignment:
            page.crossAxisAlignment ?? CrossAxisAlignment.center,
        children: [
          // Custom widget takes precedence over image
          if (page.customWidget != null)
            Flexible(child: page.customWidget!)
          else if (page.imageAsset != null)
            Flexible(
              child: Semantics(
                image: true,
                label: 'Onboarding illustration',
                child: Image.asset(
                  page.imageAsset!,
                  fit: BoxFit.contain,
                ),
              ),
            ),

          if (page.customWidget != null || page.imageAsset != null)
            const SizedBox(height: 32),

          // Title
          Semantics(
            header: true,
            child: Text(
              page.title,
              style:
                  page.titleStyle ?? Theme.of(context).textTheme.headlineMedium,
              textAlign: TextAlign.center,
            ),
          ),

          const SizedBox(height: 16),

          // Description
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
