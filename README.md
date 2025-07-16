# Flutter Onboarding Flow

A highly customizable onboarding flow package for Flutter with swipeable screens, progress indicators, templates, and accessibility support.

## Features

- ✅ **Swipeable Screens**: Smooth page transitions with gesture support
- ✅ **Progress Indicators**: Dots, bars, or custom progress indicators
- ✅ **Pre-built Templates**: Welcome, feature highlights, and permissions templates
- ✅ **Local Storage**: Automatic onboarding completion tracking
- ✅ **Accessibility Support**: Screen reader and keyboard navigation support
- ✅ **Customizable Transitions**: Slide, fade, zoom, and scale animations
- ✅ **Highly Customizable**: Extensive styling and configuration options
- ✅ **Null Safety**: Full null safety support

## Installation

Add this to your package's `pubspec.yaml` file:

```yaml
dependencies:
  flutter_onboarding_flow: ^1.0.0
```

Then run:

```bash
flutter pub get
```

## Quick Start

```dart
import 'package:flutter/material.dart';
import 'package:flutter_onboarding_flow/flutter_onboarding_flow.dart';

class MyOnboarding extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return OnboardingFlow(
      pages: [
        OnboardingPageModel(
          title: 'Welcome',
          description: 'Welcome to our amazing app!',
          customWidget: Icon(Icons.waving_hand, size: 100),
        ),
        OnboardingPageModel(
          title: 'Features',
          description: 'Discover all the great features',
          customWidget: Icon(Icons.star, size: 100),
        ),
        OnboardingPageModel(
          title: 'Get Started',
          description: 'You\'re all set! Let\'s begin.',
          customWidget: Icon(Icons.rocket_launch, size: 100),
        ),
      ],
      onComplete: () {
        // Navigate to main app
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => MainApp()),
        );
      },
    );
  }
}
```

## Usage

### Basic Usage

```dart
OnboardingFlow(
  pages: [
    OnboardingPageModel(
      title: 'Welcome',
      description: 'Welcome to our app',
      imageAsset: 'assets/images/welcome.png',
    ),
    // Add more pages...
  ],
  onComplete: () {
    // Handle completion
  },
)
```

### Advanced Configuration

```dart
OnboardingFlow(
  pages: pages,
  config: OnboardingConfig(
    showSkipButton: true,
    showBackButton: true,
    showProgressIndicator: true,
    progressIndicatorType: ProgressIndicatorType.bar,
    progressIndicatorColor: Colors.blue,
    skipButtonText: 'Skip Tutorial',
    nextButtonText: 'Continue',
    doneButtonText: 'Start Using App',
    animationDuration: Duration(milliseconds: 500),
    animationCurve: Curves.easeInOutCubic,
    enableSwipeGesture: true,
    autoSave: true,
  ),
  onComplete: () => Navigator.pushReplacement(
    context,
    MaterialPageRoute(builder: (_) => MainApp()),
  ),
)
```

### Using Templates

```dart
// Welcome template
final pages = OnboardingTemplates.welcomeTemplate(
  appName: 'MyApp',
  appDescription: 'The best app ever created',
);

// Feature highlights template
final featurePages = OnboardingTemplates.featureHighlightsTemplate(
  features: [
    {'title': 'Fast', 'description': 'Lightning fast performance'},
    {'title': 'Secure', 'description': 'Your data is safe with us'},
    {'title': 'Easy', 'description': 'Simple and intuitive interface'},
  ],
);

// Permissions template
final permissionPages = OnboardingTemplates.permissionsTemplate(
  permissions: [
    {
      'title': 'Camera Access',
      'description': 'We need camera access to take photos',
      'type': 'camera'
    },
    {
      'title': 'Location Access',
      'description': 'Location helps us provide better services',
      'type': 'location'
    },
  ],
);
```

### Storage Management

```dart
// Check if onboarding is completed
final isCompleted = await OnboardingStorage.isOnboardingCompleted();

// Mark onboarding as completed
await OnboardingStorage.setOnboardingCompleted(completed: true);

// Reset onboarding
await OnboardingStorage.resetOnboarding();

// Get current page index
final currentPage = await OnboardingStorage.getCurrentPageIndex();
```

## Customization

### Page Customization

```dart
OnboardingPageModel(
  title: 'Custom Page',
  description: 'This is a custom page',
  imageAsset: 'assets/image.png',
  backgroundColor: Colors.blue.shade50,
  titleStyle: TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.bold,
    color: Colors.black87,
  ),
  descriptionStyle: TextStyle(
    fontSize: 16,
    color: Colors.black54,
    height: 1.5,
  ),
  padding: EdgeInsets.all(32),
  mainAxisAlignment: MainAxisAlignment.center,
  crossAxisAlignment: CrossAxisAlignment.center,
  customWidget: Container(
    width: 200,
    height: 200,
    decoration: BoxDecoration(
      color: Colors.blue,
      borderRadius: BorderRadius.circular(20),
    ),
    child: Icon(Icons.star, size: 80, color: Colors.white),
  ),
)
```

### Progress Indicators

```dart
OnboardingConfig(
  progressIndicatorType: ProgressIndicatorType.dots, // or .bar, .none
  progressIndicatorColor: Colors.blue,
  progressIndicatorBackgroundColor: Colors.grey.shade300,
)
```

### Transitions

```dart
OnboardingConfig(
  transitionType: PageTransitionType.slide, // slide, fade, zoom, scale
  animationDuration: Duration(milliseconds: 300),
  animationCurve: Curves.easeInOut,
)
```

## API Reference

### OnboardingPageModel

| Property           | Type                | Description                    |
| ------------------ | ------------------- | ------------------------------ |
| title              | String              | Page title                     |
| description        | String              | Page description               |
| imageAsset         | String?             | Asset path for image           |
| customWidget       | Widget?             | Custom widget instead of image |
| backgroundColor    | Color?              | Page background color          |
| titleStyle         | TextStyle?          | Title text style               |
| descriptionStyle   | TextStyle?          | Description text style         |
| padding            | EdgeInsets?         | Page padding                   |
| mainAxisAlignment  | MainAxisAlignment?  | Column main axis alignment     |
| crossAxisAlignment | CrossAxisAlignment? | Column cross axis alignment    |

### OnboardingConfig

| Property                         | Type                  | Default       | Description              |
| -------------------------------- | --------------------- | ------------- | ------------------------ |
| showSkipButton                   | bool                  | true          | Show skip button         |
| showBackButton                   | bool                  | true          | Show back button         |
| showProgressIndicator            | bool                  | true          | Show progress indicator  |
| progressIndicatorType            | ProgressIndicatorType | dots          | Progress indicator type  |
| progressIndicatorColor           | Color?                | null          | Active progress color    |
| progressIndicatorBackgroundColor | Color?                | null          | Inactive progress color  |
| skipButtonText                   | String                | 'Skip'        | Skip button text         |
| nextButtonText                   | String                | 'Next'        | Next button text         |
| doneButtonText                   | String                | 'Get Started' | Done button text         |
| backButtonText                   | String                | 'Back'        | Back button text         |
| animationDuration                | Duration              | 300ms         | Page transition duration |
| animationCurve                   | Curve                 | easeInOut     | Page transition curve    |
| enableSwipeGesture               | bool                  | true          | Enable swipe navigation  |
| autoSave                         | bool                  | true          | Auto-save progress       |

## Accessibility

The package includes comprehensive accessibility support:

- **Screen Reader Support**: All elements have proper semantic labels
- **Keyboard Navigation**: Full keyboard navigation support
- **Focus Management**: Proper focus management between pages
- **Contrast**: Respects system contrast preferences
- **Text Scaling**: Supports dynamic text scaling

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
