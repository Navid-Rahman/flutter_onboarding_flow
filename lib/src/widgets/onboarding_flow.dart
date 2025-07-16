import 'package:flutter/material.dart';
import '../models/onboarding_page_model.dart';
import '../models/onboarding_config.dart';
import '../controllers/onboarding_controller.dart';
import '../widgets/onboarding_page_widget.dart';
import '../widgets/progress_indicator_widget.dart';
import '../widgets/navigation_controls.dart';

/// A comprehensive onboarding flow widget that provides a smooth, customizable
/// user introduction experience for Flutter applications.
///
/// This widget creates a full-screen onboarding flow with swipeable pages,
/// progress indicators, navigation controls, and extensive customization options.
/// It handles all aspects of the onboarding experience including:
/// - Page navigation with animations
/// - Progress tracking and visualization
/// - State persistence across app sessions
/// - Accessibility features for inclusive design
/// - Responsive layout for different screen sizes
///
/// Example usage:
/// ```dart
/// OnboardingFlow(
///   pages: [
///     OnboardingPageModel(
///       title: 'Welcome',
///       description: 'Welcome to our amazing app!',
///       imagePath: 'assets/welcome.png',
///     ),
///     OnboardingPageModel(
///       title: 'Features',
///       description: 'Discover powerful features.',
///       imagePath: 'assets/features.png',
///     ),
///   ],
///   config: OnboardingConfig(
///     showProgressIndicator: true,
///     enableSwipeGesture: true,
///     progressIndicatorType: ProgressIndicatorType.dots,
///   ),
///   onComplete: () {
///     Navigator.pushReplacement(
///       context,
///       MaterialPageRoute(builder: (context) => HomeScreen()),
///     );
///   },
/// )
/// ```
///
/// The widget automatically handles:
/// - Memory management and controller disposal
/// - Responsive design across different screen sizes
/// - Accessibility labels and semantic information
/// - State preservation during configuration changes
/// - Smooth animations between pages
///
/// See also:
/// - [OnboardingPageModel] for page content structure
/// - [OnboardingConfig] for customization options
/// - [OnboardingController] for programmatic control
class OnboardingFlow extends StatefulWidget {
  /// The list of pages to display in the onboarding flow.
  ///
  /// Each page should be an [OnboardingPageModel] containing the content
  /// and configuration for that specific page. The order of pages in this
  /// list determines the navigation sequence.
  ///
  /// Must contain at least one page. Pages are displayed in sequence
  /// and users can navigate between them using swipe gestures (if enabled)
  /// or navigation buttons.
  final List<OnboardingPageModel> pages;

  /// Configuration options for customizing the onboarding flow behavior
  /// and appearance.
  ///
  /// Provides control over:
  /// - Progress indicator type and styling
  /// - Navigation button labels and colors
  /// - Animation types and durations
  /// - Gesture handling preferences
  /// - Accessibility settings
  ///
  /// Defaults to [OnboardingConfig()] with sensible defaults if not provided.
  final OnboardingConfig config;

  /// Callback function invoked when the user completes the onboarding flow.
  ///
  /// This is typically used to navigate to the main application screen,
  /// update user preferences, or trigger other post-onboarding actions.
  /// Called when the user taps the "Done" button on the last page or
  /// uses the skip functionality (if configured).
  ///
  /// Example:
  /// ```dart
  /// onComplete: () {
  ///   // Save onboarding completion status
  ///   SharedPreferences.getInstance().then((prefs) {
  ///     prefs.setBool('onboarding_completed', true);
  ///   });
  ///   
  ///   // Navigate to main app
  ///   Navigator.pushReplacement(
  ///     context,
  ///     MaterialPageRoute(builder: (context) => HomeScreen()),
  ///   );
  /// }
  /// ```
  final VoidCallback? onComplete;

  /// The initial page index to display when the onboarding flow starts.
  ///
  /// Defaults to 0 (first page). Useful for resuming onboarding from
  /// a specific page or testing specific pages during development.
  /// Must be a valid index within the [pages] list bounds.
  ///
  /// Example for resuming from saved progress:
  /// ```dart
  /// initialPage: await OnboardingStorage.getCurrentPage() ?? 0
  /// ```
  final int initialPage;

  /// Creates an onboarding flow widget with the specified pages and configuration.
  ///
  /// Requires [pages] to be a non-empty list of onboarding page models.
  /// All other parameters are optional with sensible defaults.
  ///
  /// The widget automatically sets up the necessary controllers and handles
  /// the complete lifecycle of the onboarding experience.
  const OnboardingFlow({
    super.key,
    required this.pages,
    this.config = const OnboardingConfig(),
    this.onComplete,
    this.initialPage = 0,
  }) : assert(pages.length > 0, 'At least one page must be provided');

  @override
  State<OnboardingFlow> createState() => _OnboardingFlowState();
}

/// Private state class for [OnboardingFlow] that manages the controller
/// lifecycle and builds the onboarding interface.
///
/// Handles:
/// - Controller initialization and disposal
/// - State updates and rebuilds
/// - Layout composition and responsive design
/// - Integration between all onboarding components
class _OnboardingFlowState extends State<OnboardingFlow> {
  /// The main controller that manages onboarding state and navigation.
  ///
  /// Initialized in [initState] with the widget's configuration and
  /// disposed in [dispose] to prevent memory leaks.
  late OnboardingController _controller;

  @override
  void initState() {
    super.initState();
    // Initialize the controller with widget parameters
    _controller = OnboardingController(
      totalPages: widget.pages.length,
      config: widget.config,
      onComplete: widget.onComplete,
      initialPage: widget.initialPage,
    );
  }

  @override
  Widget build(BuildContext context) {
    // Use Scaffold to provide a full-screen layout foundation
    return Scaffold(
      body: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return SafeArea(
            child: Column(
              children: [
                // Progress indicator section
                // Conditionally displayed based on configuration
                if (widget.config.showProgressIndicator)
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: ProgressIndicatorWidget(
                      currentIndex: _controller.currentIndex,
                      totalPages: _controller.totalPages,
                      type: widget.config.progressIndicatorType,
                      activeColor: widget.config.progressIndicatorColor,
                      inactiveColor:
                          widget.config.progressIndicatorBackgroundColor,
                    ),
                  ),

                // Main page content area
                // Uses Expanded to fill available space
                Expanded(
                  child: PageView.builder(
                    controller: _controller.pageController,
                    onPageChanged: _controller.updateCurrentIndex,
                    physics: widget.config.enableSwipeGesture
                        ? const PageScrollPhysics()
                        : const NeverScrollableScrollPhysics(),
                    itemCount: widget.pages.length,
                    itemBuilder: (context, index) {
                      return OnboardingPageWidget(
                        page: widget.pages[index],
                      );
                    },
                  ),
                ),

                // Bottom navigation controls
                // Always present for accessibility and consistent navigation
                NavigationControls(
                  currentIndex: _controller.currentIndex,
                  totalPages: _controller.totalPages,
                  config: widget.config,
                  onSkip: _controller.skip,
                  onBack: _controller.previousPage,
                  onNext: _controller.nextPage,
                  onDone: _controller.complete,
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    // Clean up controller to prevent memory leaks
    _controller.dispose();
    super.dispose();
  }
}
