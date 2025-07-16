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
}
