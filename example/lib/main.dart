import 'package:flutter/material.dart';
import 'package:flutter_onboarding_flow/flutter_onboarding_flow.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Onboarding Flow Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: const OnboardingDemo(),
    );
  }
}

class OnboardingDemo extends StatefulWidget {
  const OnboardingDemo({super.key});

  @override
  State<OnboardingDemo> createState() => _OnboardingDemoState();
}

class _OnboardingDemoState extends State<OnboardingDemo> {
  bool _showOnboarding = true;

  @override
  void initState() {
    super.initState();
    _checkOnboardingStatus();
  }

  Future<void> _checkOnboardingStatus() async {
    final isCompleted = await OnboardingStorage.isOnboardingCompleted();
    setState(() {
      _showOnboarding = !isCompleted;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_showOnboarding) {
      return OnboardingFlow(
        pages: _createOnboardingPages(),
        config: const OnboardingConfig(
          showSkipButton: true,
          showBackButton: true,
          showProgressIndicator: true,
          progressIndicatorType: ProgressIndicatorType.dots,
          progressIndicatorColor: Colors.blue,
          progressIndicatorBackgroundColor: Colors.grey,
          skipButtonText: 'Skip',
          nextButtonText: 'Next',
          doneButtonText: 'Get Started',
          backButtonText: 'Back',
          animationDuration: Duration(milliseconds: 300),
          animationCurve: Curves.easeInOut,
          enableSwipeGesture: true,
          autoSave: true,
        ),
        onComplete: () {
          setState(() {
            _showOnboarding = false;
          });
        },
      );
    }

    return const MainApp();
  }

  List<OnboardingPageModel> _createOnboardingPages() {
    return [
      OnboardingPageModel(
        title: 'Welcome to MyApp',
        description:
            'Discover amazing features and get the most out of your experience',
        customWidget: const Icon(
          Icons.waving_hand,
          size: 100,
          color: Colors.orange,
        ),
        backgroundColor: Colors.blue.shade50,
        titleStyle: const TextStyle(
          fontSize: 28,
          fontWeight: FontWeight.bold,
          color: Colors.black87,
        ),
        descriptionStyle: const TextStyle(
          fontSize: 16,
          color: Colors.black54,
          height: 1.5,
        ),
      ),
      OnboardingPageModel(
        title: 'Stay Organized',
        description:
            'Keep track of your tasks and projects with our intuitive interface',
        customWidget: const Icon(
          Icons.checklist,
          size: 100,
          color: Colors.green,
        ),
        backgroundColor: Colors.green.shade50,
        titleStyle: const TextStyle(
          fontSize: 28,
          fontWeight: FontWeight.bold,
          color: Colors.black87,
        ),
        descriptionStyle: const TextStyle(
          fontSize: 16,
          color: Colors.black54,
          height: 1.5,
        ),
      ),
      OnboardingPageModel(
        title: 'Collaborate Seamlessly',
        description:
            'Work together with your team in real-time and boost productivity',
        customWidget: const Icon(
          Icons.group,
          size: 100,
          color: Colors.purple,
        ),
        backgroundColor: Colors.purple.shade50,
        titleStyle: const TextStyle(
          fontSize: 28,
          fontWeight: FontWeight.bold,
          color: Colors.black87,
        ),
        descriptionStyle: const TextStyle(
          fontSize: 16,
          color: Colors.black54,
          height: 1.5,
        ),
      ),
      OnboardingPageModel(
        title: 'You\'re All Set!',
        description:
            'Let\'s start your journey with MyApp. Tap below to begin exploring!',
        customWidget: const Icon(
          Icons.rocket_launch,
          size: 100,
          color: Colors.blue,
        ),
        backgroundColor: Colors.blue.shade50,
        titleStyle: const TextStyle(
          fontSize: 28,
          fontWeight: FontWeight.bold,
          color: Colors.black87,
        ),
        descriptionStyle: const TextStyle(
          fontSize: 16,
          color: Colors.black54,
          height: 1.5,
        ),
      ),
    ];
  }
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Main App'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.check_circle,
              size: 80,
              color: Colors.green,
            ),
            const SizedBox(height: 20),
            const Text(
              'Welcome to the Main App!',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'Onboarding completed successfully',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: () async {
                final navigator = Navigator.of(context);
                await OnboardingStorage.resetOnboarding();
                // Restart the app or navigate back to onboarding
                navigator.pushReplacement(
                  MaterialPageRoute(
                    builder: (_) => const OnboardingDemo(),
                  ),
                );
              },
              child: const Text('Reset Onboarding'),
            ),
          ],
        ),
      ),
    );
  }
}
