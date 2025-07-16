import 'package:flutter/material.dart';
import '../models/onboarding_config.dart';
import '../services/onboarding_storage.dart';

/// Controller for managing onboarding state and navigation
class OnboardingController extends ChangeNotifier {
  final PageController _pageController;
  final OnboardingConfig _config;
  final int _totalPages;
  final VoidCallback? _onComplete;

  int _currentIndex = 0;
  bool _isAnimating = false;

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

  // Getters
  PageController get pageController => _pageController;
  int get currentIndex => _currentIndex;
  int get totalPages => _totalPages;
  bool get isFirstPage => _currentIndex == 0;
  bool get isLastPage => _currentIndex == _totalPages - 1;
  bool get isAnimating => _isAnimating;

  /// Navigate to next page
  Future<void> nextPage() async {
    if (_isAnimating || isLastPage) return;

    _isAnimating = true;
    notifyListeners();

    await _pageController.nextPage(
      duration: _config.animationDuration,
      curve: _config.animationCurve,
    );

    _isAnimating = false;
    notifyListeners();

    if (_config.autoSave) {
      await OnboardingStorage.setCurrentPageIndex(
        key: _config.storageKey,
        index: _currentIndex,
      );
    }
  }

  /// Navigate to previous page
  Future<void> previousPage() async {
    if (_isAnimating || isFirstPage) return;

    _isAnimating = true;
    notifyListeners();

    await _pageController.previousPage(
      duration: _config.animationDuration,
      curve: _config.animationCurve,
    );

    _isAnimating = false;
    notifyListeners();

    if (_config.autoSave) {
      await OnboardingStorage.setCurrentPageIndex(
        key: _config.storageKey,
        index: _currentIndex,
      );
    }
  }

  /// Navigate to specific page
  Future<void> goToPage(int index) async {
    if (_isAnimating || index < 0 || index >= _totalPages) return;

    _isAnimating = true;
    notifyListeners();

    await _pageController.animateToPage(
      index,
      duration: _config.animationDuration,
      curve: _config.animationCurve,
    );

    _isAnimating = false;
    notifyListeners();

    if (_config.autoSave) {
      await OnboardingStorage.setCurrentPageIndex(
        key: _config.storageKey,
        index: _currentIndex,
      );
    }
  }

  /// Skip onboarding
  Future<void> skip() async {
    if (_config.autoSave) {
      await OnboardingStorage.setOnboardingCompleted(
        key: _config.storageKey,
        completed: true,
      );
    }
    _onComplete?.call();
  }

  /// Complete onboarding
  Future<void> complete() async {
    if (_config.autoSave) {
      await OnboardingStorage.setOnboardingCompleted(
        key: _config.storageKey,
        completed: true,
      );
    }
    _onComplete?.call();
  }

  /// Update current index (called by PageView)
  void updateCurrentIndex(int index) {
    _currentIndex = index;
    notifyListeners();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}
