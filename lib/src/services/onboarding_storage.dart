import 'package:shared_preferences/shared_preferences.dart';

/// Service for managing onboarding completion status
class OnboardingStorage {
  static const String _defaultKey = 'onboarding_completed';

  /// Check if onboarding has been completed
  static Future<bool> isOnboardingCompleted({String key = _defaultKey}) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(key) ?? false;
  }

  /// Mark onboarding as completed
  static Future<void> setOnboardingCompleted({
    String key = _defaultKey,
    bool completed = true,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(key, completed);
  }

  /// Reset onboarding status
  static Future<void> resetOnboarding({String key = _defaultKey}) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(key);
  }

  /// Get current page index (for resuming onboarding)
  static Future<int> getCurrentPageIndex({String key = _defaultKey}) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt('${key}_current_page') ?? 0;
  }

  /// Save current page index
  static Future<void> setCurrentPageIndex({
    String key = _defaultKey,
    required int index,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('${key}_current_page', index);
  }
}
