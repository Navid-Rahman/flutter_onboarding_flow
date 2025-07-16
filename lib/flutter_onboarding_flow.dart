/// A comprehensive Flutter package for creating beautiful, customizable onboarding flows.
///
/// This library provides everything needed to implement a professional onboarding
/// experience in Flutter applications, including:
///
/// ## Core Components
/// - **[OnboardingFlow]**: Main widget for creating the complete onboarding experience
/// - **[OnboardingPageModel]**: Data model for individual onboarding pages
/// - **[OnboardingConfig]**: Configuration class for customizing flow behavior
/// - **[OnboardingController]**: Controller for programmatic navigation and state management
///
/// ## UI Components
/// - **[OnboardingPageWidget]**: Individual page display with flexible content support
/// - **[ProgressIndicatorWidget]**: Customizable progress indicators (dots, bar, or hidden)
/// - **[NavigationControls]**: Navigation buttons with accessibility support
///
/// ## Utilities
/// - **[OnboardingStorage]**: Persistent storage for completion status and progress
/// - **[PageTransitions]**: Smooth page transition animations
/// - **[OnboardingTemplates]**: Pre-built templates for common onboarding scenarios
///
/// ## Quick Start
/// 
/// ### Basic Usage
/// ```dart
/// import 'package:flutter_onboarding_flow/flutter_onboarding_flow.dart';
///
/// class MyOnboardingScreen extends StatelessWidget {
///   @override
///   Widget build(BuildContext context) {
///     return OnboardingFlow(
///       pages: [
///         OnboardingPageModel(
///           title: 'Welcome!',
///           description: 'Welcome to our amazing app',
///           imageAsset: 'assets/welcome.png',
///         ),
///         OnboardingPageModel(
///           title: 'Features',
///           description: 'Discover powerful features',
///           imageAsset: 'assets/features.png',
///         ),
///       ],
///       config: OnboardingConfig(
///         showProgressIndicator: true,
///         enableSwipeGesture: true,
///       ),
///       onComplete: () {
///         Navigator.pushReplacement(
///           context,
///           MaterialPageRoute(builder: (context) => HomeScreen()),
///         );
///       },
///     );
///   }
/// }
/// ```
///
/// ### Using Templates
/// ```dart
/// // Create a complete onboarding flow with templates
/// final pages = OnboardingTemplates.completeTemplate(
///   appName: 'MyApp',
///   appDescription: 'The best app for productivity',
///   features: [
///     {'title': 'Fast', 'description': 'Lightning fast performance'},
///     {'title': 'Secure', 'description': 'Your data is protected'},
///   ],
/// );
///
/// OnboardingFlow(
///   pages: pages,
///   config: OnboardingTemplates.getStartedConfig(),
///   onComplete: () => _navigateToHome(),
/// )
/// ```
///
/// ### Advanced Configuration
/// ```dart
/// OnboardingFlow(
///   pages: myPages,
///   config: OnboardingConfig(
///     showSkipButton: true,
///     showBackButton: true,
///     progressIndicatorType: ProgressIndicatorType.bar,
///     animationDuration: Duration(milliseconds: 500),
///     animationCurve: Curves.easeInOutCubic,
///     autoSave: true,
///   ),
///   onComplete: () => _handleCompletion(),
/// )
/// ```
///
/// ## Key Features
/// - **🎨 Highly Customizable**: Control every aspect of appearance and behavior
/// - **📱 Responsive Design**: Works beautifully on all screen sizes
/// - **♿ Accessibility**: Full accessibility support with semantic labels
/// - **💾 State Persistence**: Automatically save and restore progress
/// - **🎭 Rich Animations**: Smooth transitions and customizable animations
/// - **📚 Ready-to-Use Templates**: Quick setup with pre-built templates
/// - **🎯 Type Safe**: Full null safety and strong typing
/// - **🧪 Well Tested**: Comprehensive test coverage
///
/// ## Supported Platforms
/// - ✅ Android
/// - ✅ iOS  
/// - ✅ Web
/// - ✅ Desktop (Windows, macOS, Linux)
///
/// For detailed documentation and examples, visit the package repository
/// or check the individual class documentation.
library flutter_onboarding_flow;

export 'src/models/onboarding_page_model.dart';
export 'src/models/onboarding_config.dart';
export 'src/widgets/onboarding_page_widget.dart';
export 'src/widgets/onboarding_flow.dart';
export 'src/widgets/progress_indicator_widget.dart';
export 'src/widgets/navigation_controls.dart';
export 'src/controllers/onboarding_controller.dart';
export 'src/services/onboarding_storage.dart';
export 'src/templates/onboarding_templates.dart';
export 'src/animations/page_transitions.dart';
