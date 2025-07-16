import 'package:shared_preferences/shared_preferences.dart';

/// A service class for managing onboarding completion status and progress using local storage.
/// 
/// This class provides a simple interface for storing and retrieving onboarding-related
/// data using SharedPreferences. It supports multiple onboarding flows through custom keys
/// and maintains both completion status and current page progress.
/// 
/// Example usage:
/// ```dart
/// // Check if onboarding is completed
/// final isCompleted = await OnboardingStorage.isOnboardingCompleted();
/// 
/// // Mark onboarding as completed
/// await OnboardingStorage.setOnboardingCompleted();
/// 
/// // Reset onboarding for testing
/// await OnboardingStorage.resetOnboarding();
/// ```
class OnboardingStorage {
  /// The default SharedPreferences key used for storing onboarding completion status.
  /// This can be overridden in method calls to support multiple onboarding flows.
  static const String _defaultKey = 'onboarding_completed';

  /// Checks if the onboarding flow has been completed by the user.
  /// 
  /// Returns `true` if the onboarding was previously marked as completed,
  /// `false` otherwise. This method is typically called on app startup
  /// to determine whether to show the onboarding flow.
  /// 
  /// Parameters:
  /// - [key]: Optional custom storage key. Defaults to [_defaultKey].
  /// 
  /// Returns:
  /// A [Future<bool>] indicating the completion status.
  /// 
  /// Example:
  /// ```dart
  /// final shouldShowOnboarding = !(await OnboardingStorage.isOnboardingCompleted());
  /// ```
  static Future<bool> isOnboardingCompleted({String key = _defaultKey}) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(key) ?? false;
  }

  /// Marks the onboarding flow as completed or not completed.
  /// 
  /// This method is typically called when the user finishes the onboarding
  /// flow or when you want to programmatically control the completion status.
  /// 
  /// Parameters:
  /// - [key]: Optional custom storage key. Defaults to [_defaultKey].
  /// - [completed]: Whether onboarding should be marked as completed. Defaults to `true`.
  /// 
  /// Example:
  /// ```dart
  /// // Mark as completed
  /// await OnboardingStorage.setOnboardingCompleted();
  /// 
  /// // Mark as not completed
  /// await OnboardingStorage.setOnboardingCompleted(completed: false);
  /// ```
  static Future<void> setOnboardingCompleted({
    String key = _defaultKey,
    bool completed = true,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(key, completed);
  }

  /// Resets the onboarding status, effectively marking it as not completed.
  /// 
  /// This method removes the completion status from storage, which will
  /// cause [isOnboardingCompleted] to return `false`. Useful for testing
  /// or allowing users to replay the onboarding experience.
  /// 
  /// Parameters:
  /// - [key]: Optional custom storage key. Defaults to [_defaultKey].
  /// 
  /// Example:
  /// ```dart
  /// // Reset onboarding (user will see it again)
  /// await OnboardingStorage.resetOnboarding();
  /// ```
  static Future<void> resetOnboarding({String key = _defaultKey}) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(key);
  }

  /// Retrieves the current page index from storage.
  /// 
  /// This method allows the onboarding flow to resume from where the user
  /// left off if they exit the app mid-flow. Returns 0 if no page index
  /// has been saved.
  /// 
  /// Parameters:
  /// - [key]: Optional custom storage key. Defaults to [_defaultKey].
  /// 
  /// Returns:
  /// A [Future<int>] representing the last saved page index (0-based).
  /// 
  /// Example:
  /// ```dart
  /// final lastPage = await OnboardingStorage.getCurrentPageIndex();
  /// // Resume onboarding from lastPage
  /// ```
  static Future<int> getCurrentPageIndex({String key = _defaultKey}) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt('${key}_current_page') ?? 0;
  }

  /// Saves the current page index to storage.
  /// 
  /// This method is typically called automatically by the onboarding controller
  /// to track user progress through the flow. It enables resuming from the
  /// correct page if the user exits and returns to the app.
  /// 
  /// Parameters:
  /// - [key]: Optional custom storage key. Defaults to [_defaultKey].
  /// - [index]: The current page index to save (0-based).
  /// 
  /// Example:
  /// ```dart
  /// // Save current progress
  /// await OnboardingStorage.setCurrentPageIndex(index: 2);
  /// ```
  static Future<void> setCurrentPageIndex({
    String key = _defaultKey,
    required int index,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('${key}_current_page', index);
  }
}
