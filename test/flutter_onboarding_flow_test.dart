import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_onboarding_flow/flutter_onboarding_flow.dart';

void main() {
  group('OnboardingPageModel', () {
    test('should create OnboardingPageModel with required fields', () {
      const page = OnboardingPageModel(
        title: 'Test Title',
        description: 'Test Description',
      );

      expect(page.title, 'Test Title');
      expect(page.description, 'Test Description');
      expect(page.imageAsset, null);
      expect(page.customWidget, null);
    });

    test('should create copy with modified fields', () {
      const page = OnboardingPageModel(
        title: 'Original Title',
        description: 'Original Description',
      );

      final copiedPage = page.copyWith(title: 'New Title');

      expect(copiedPage.title, 'New Title');
      expect(copiedPage.description, 'Original Description');
    });
  });

  group('OnboardingConfig', () {
    test('should create OnboardingConfig with default values', () {
      const config = OnboardingConfig();

      expect(config.showSkipButton, true);
      expect(config.showBackButton, true);
      expect(config.showProgressIndicator, true);
      expect(config.progressIndicatorType, ProgressIndicatorType.dots);
      expect(config.skipButtonText, 'Skip');
      expect(config.nextButtonText, 'Next');
      expect(config.doneButtonText, 'Get Started');
      expect(config.backButtonText, 'Back');
      expect(config.enableSwipeGesture, true);
      expect(config.autoSave, true);
    });

    test('should create OnboardingConfig with custom values', () {
      const config = OnboardingConfig(
        showSkipButton: false,
        progressIndicatorType: ProgressIndicatorType.bar,
        skipButtonText: 'Custom Skip',
      );

      expect(config.showSkipButton, false);
      expect(config.progressIndicatorType, ProgressIndicatorType.bar);
      expect(config.skipButtonText, 'Custom Skip');
    });
  });

  group('OnboardingTemplates', () {
    test('should create welcome template', () {
      final pages = OnboardingTemplates.welcomeTemplate(
        appName: 'Test App',
        appDescription: 'Test Description',
      );

      expect(pages.length, 1);
      expect(pages.first.title, 'Welcome to Test App');
      expect(pages.first.description, 'Test Description');
    });

    test('should create feature highlights template', () {
      final features = [
        {'title': 'Feature 1', 'description': 'Description 1'},
        {'title': 'Feature 2', 'description': 'Description 2'},
      ];

      final pages = OnboardingTemplates.featureHighlightsTemplate(
        features: features,
      );

      expect(pages.length, 2);
      expect(pages.first.title, 'Feature 1');
      expect(pages.first.description, 'Description 1');
      expect(pages.last.title, 'Feature 2');
      expect(pages.last.description, 'Description 2');
    });

    test('should create permissions template', () {
      final permissions = [
        {'title': 'Camera Access', 'description': 'Allow camera access', 'type': 'camera'},
        {'title': 'Location Access', 'description': 'Allow location access', 'type': 'location'},
      ];

      final pages = OnboardingTemplates.permissionsTemplate(
        permissions: permissions,
      );

      expect(pages.length, 2);
      expect(pages.first.title, 'Camera Access');
      expect(pages.first.description, 'Allow camera access');
      expect(pages.last.title, 'Location Access');
      expect(pages.last.description, 'Allow location access');
    });
  });
}
