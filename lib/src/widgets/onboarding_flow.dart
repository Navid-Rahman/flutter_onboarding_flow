import 'package:flutter/material.dart';
import '../models/onboarding_page_model.dart';
import '../models/onboarding_config.dart';
import '../controllers/onboarding_controller.dart';
import '../widgets/onboarding_page_widget.dart';
import '../widgets/progress_indicator_widget.dart';
import '../widgets/navigation_controls.dart';

/// Main onboarding flow widget
class OnboardingFlow extends StatefulWidget {
  final List<OnboardingPageModel> pages;
  final OnboardingConfig config;
  final VoidCallback? onComplete;
  final int initialPage;

  const OnboardingFlow({
    Key? key,
    required this.pages,
    this.config = const OnboardingConfig(),
    this.onComplete,
    this.initialPage = 0,
  }) : super(key: key);

  @override
  State<OnboardingFlow> createState() => _OnboardingFlowState();
}

class _OnboardingFlowState extends State<OnboardingFlow> {
  late OnboardingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = OnboardingController(
      totalPages: widget.pages.length,
      config: widget.config,
      onComplete: widget.onComplete,
      initialPage: widget.initialPage,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return SafeArea(
            child: Column(
              children: [
                // Progress indicator
                if (widget.config.showProgressIndicator)
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: ProgressIndicatorWidget(
                      currentIndex: _controller.currentIndex,
                      totalPages: _controller.totalPages,
                      type: widget.config.progressIndicatorType,
                      activeColor: widget.config.progressIndicatorColor,
                      inactiveColor: widget.config.progressIndicatorBackgroundColor,
                    ),
                  ),

                // Page content
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

                // Navigation controls
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
    _controller.dispose();
    super.dispose();
  }
}
