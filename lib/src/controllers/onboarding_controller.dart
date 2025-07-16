import 'package:flutter/material.dart';
import '../models/onboarding_config.dart';
import '../services/onboarding_storage.dart';

/// A controller class that manages onboarding state, navigation, and user interactions.
///
/// This controller extends [ChangeNotifier] to provide reactive state management
/// for the onboarding flow. It handles page navigation, progress tracking,
/// animation states, and storage integration.
///
/// The controller coordinates between the UI components and business logic,
/// ensuring smooth transitions and proper state management throughout the
/// onboarding experience.
///
/// Example usage:
/// ```dart
/// final controller = OnboardingController(
///   totalPages: 4,
///   config: OnboardingConfig(),
///   onComplete: () => navigateToMainApp(),
/// );
/// ```
class OnboardingController extends ChangeNotifier {
  /// The PageController that manages the PageView widget
  final PageController _pageController;

  /// The configuration object containing all onboarding settings
  final OnboardingConfig _config;

  /// The total number of pages in the onboarding flow
  final int _totalPages;

  /// Callback function to execute when onboarding is completed
  final VoidCallback? _onComplete;

  /// The current page index (0-based)
  int _currentIndex = 0;

  /// Flag to prevent multiple simultaneous animations
  bool _isAnimating = false;

  /// Creates a new onboarding controller with the specified configuration.
  ///
  /// Parameters:
  /// - [totalPages]: The total number of pages in the onboarding flow
  /// - [config]: Configuration object defining behavior and appearance
  /// - [onComplete]: Optional callback to execute when onboarding completes
  /// - [initialPage]: Starting page index (defaults to 0)
  ///
  /// The controller automatically initializes the PageController and sets up
  /// the initial state based on the provided parameters.
  OnboardingController({
    required int totalPages,
    required OnboardingConfig config,
    VoidCallback? onComplete,
    int initialPage = 0,
  })  : _totalPages = totalPages,
        _config = config,
        _onComplete = onComplete,
        _pageController = PageController(initialPage: initialPage),
        _currentIndex = initialPage;

  // Public getters for accessing controller state

  /// The PageController instance for the onboarding PageView.
  /// This is used by the UI to control page navigation and listen to page changes.
  PageController get pageController => _pageController;

  /// The current page index (0-based).
  /// This value is reactive and notifies listeners when it changes.
  int get currentIndex => _currentIndex;

  /// The total number of pages in the onboarding flow.
  /// This is immutable after controller creation.
  int get totalPages => _totalPages;

  /// Whether the current page is the first page in the flow.
  /// Used to conditionally show/hide the back button.
  bool get isFirstPage => _currentIndex == 0;

  /// Whether the current page is the last page in the flow.
  /// Used to show the completion button instead of next button.
  bool get isLastPage => _currentIndex == _totalPages - 1;

  /// Whether a page transition animation is currently in progress.
  /// Used to prevent multiple simultaneous navigation attempts.
  bool get isAnimating => _isAnimating;

  /// Navigates to the next page in the onboarding flow.
  ///
  /// This method performs the following actions:
  /// 1. Checks if navigation is allowed (not animating, not on last page)
  /// 2. Sets animation flag to prevent concurrent navigations
  /// 3. Animates to the next page using configured duration and curve
  /// 4. Updates storage if auto-save is enabled
  /// 5. Notifies listeners of state changes
  ///
  /// The method is safe to call multiple times as it includes guards
  /// against concurrent execution.
  Future<void> nextPage() async {
    // Guard against invalid navigation attempts
    if (_isAnimating || isLastPage) return;

    // Set animation flag to prevent concurrent navigation
    _isAnimating = true;
    notifyListeners();

    // Perform the page transition animation
    await _pageController.nextPage(
      duration: _config.animationDuration,
      curve: _config.animationCurve,
    );

    // Clear animation flag and notify listeners
    _isAnimating = false;
    notifyListeners();

    // Save progress if auto-save is enabled
    if (_config.autoSave) {
      await OnboardingStorage.setCurrentPageIndex(
        key: _config.storageKey,
        index: _currentIndex,
      );
    }
  }

  /// Navigates to the previous page in the onboarding flow.
  ///
  /// Similar to [nextPage], but navigates backwards. Includes the same
  /// safety checks and state management. This method is typically called
  /// when the user taps the back button.
  Future<void> previousPage() async {
    // Guard against invalid navigation attempts
    if (_isAnimating || isFirstPage) return;

    // Set animation flag to prevent concurrent navigation
    _isAnimating = true;
    notifyListeners();

    // Perform the previous page transition animation
    await _pageController.previousPage(
      duration: _config.animationDuration,
      curve: _config.animationCurve,
    );

    // Clear animation flag and notify listeners
    _isAnimating = false;
    notifyListeners();

    // Save progress if auto-save is enabled
    if (_config.autoSave) {
      await OnboardingStorage.setCurrentPageIndex(
        key: _config.storageKey,
        index: _currentIndex,
      );
    }
  }

  /// Navigates directly to a specific page in the onboarding flow.
  /// 
  /// This method allows jumping to any page within the valid range.
  /// It's useful for implementing features like page indicators that
  /// allow direct navigation to specific pages.
  /// 
  /// Parameters:
  /// - [index]: The target page index (0-based)
  /// 
  /// The method validates the index and prevents navigation if:
  /// - An animation is already in progress
  /// - The index is out of bounds (< 0 or >= totalPages)
  Future<void> goToPage(int index) async {
    // Validate navigation request
    if (_isAnimating || index < 0 || index >= _totalPages) return;

    // Set animation flag to prevent concurrent navigation
    _isAnimating = true;
    notifyListeners();

    // Animate to the specified page
    await _pageController.animateToPage(
      index,
      duration: _config.animationDuration,
      curve: _config.animationCurve,
    );

    // Clear animation flag and notify listeners
    _isAnimating = false;
    notifyListeners();

    // Save progress if auto-save is enabled
    if (_config.autoSave) {
      await OnboardingStorage.setCurrentPageIndex(
        key: _config.storageKey,
        index: _currentIndex,
      );
    }
  }

  /// Skips the onboarding flow entirely and marks it as completed.
  /// 
  /// This method is called when the user taps the skip button. It immediately
  /// marks the onboarding as completed in storage (if auto-save is enabled)
  /// and triggers the completion callback.
  /// 
  /// The method bypasses any remaining pages and takes the user directly
  /// to the main application experience.
  Future<void> skip() async {
    // Save completion status if auto-save is enabled
    if (_config.autoSave) {
      await OnboardingStorage.setOnboardingCompleted(
        key: _config.storageKey,
        completed: true,
      );
    }
    
    // Trigger completion callback
    _onComplete?.call();
  }

  /// Completes the onboarding flow normally after reaching the last page.
  /// 
  /// This method is called when the user taps the completion button on
  /// the final onboarding page. It marks the onboarding as completed
  /// and triggers the completion callback.
  /// 
  /// Unlike [skip], this method indicates that the user has gone through
  /// the entire onboarding experience.
  Future<void> complete() async {
    // Save completion status if auto-save is enabled
    if (_config.autoSave) {
      await OnboardingStorage.setOnboardingCompleted(
        key: _config.storageKey,
        completed: true,
      );
    }
    
    // Trigger completion callback
    _onComplete?.call();
  }

  /// Updates the current page index when the PageView changes.
  /// 
  /// This method is called by the PageView widget whenever the user
  /// swipes to a new page or when programmatic navigation occurs.
  /// It ensures the controller's state stays synchronized with the
  /// actual page position.
  /// 
  /// Parameters:
  /// - [index]: The new current page index
  /// 
  /// This method should only be called by the PageView's onPageChanged callback.
  void updateCurrentIndex(int index) {
    _currentIndex = index;
    notifyListeners();
  }

  /// Disposes of the controller and its resources.
  /// 
  /// This method should be called when the onboarding flow is no longer
  /// needed to prevent memory leaks. It disposes of the PageController
  /// and calls the parent dispose method.
  /// 
  /// The method is typically called automatically by the framework
  /// when the associated widget is disposed.
  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}
