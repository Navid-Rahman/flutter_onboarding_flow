import 'package:flutter/material.dart';
import '../models/onboarding_config.dart';

/// Custom page transitions for onboarding screens
class PageTransitions {
  static Widget buildTransition({
    required Widget child,
    required Animation<double> animation,
    required PageTransitionType type,
    bool reverse = false,
  }) {
    switch (type) {
      case PageTransitionType.slide:
        return SlideTransition(
          position: Tween<Offset>(
            begin: reverse ? const Offset(-1.0, 0.0) : const Offset(1.0, 0.0),
            end: Offset.zero,
          ).animate(animation),
          child: child,
        );
      case PageTransitionType.fade:
        return FadeTransition(
          opacity: animation,
          child: child,
        );
      case PageTransitionType.zoom:
        return ScaleTransition(
          scale: Tween<double>(
            begin: 0.8,
            end: 1.0,
          ).animate(animation),
          child: FadeTransition(
            opacity: animation,
            child: child,
          ),
        );
      case PageTransitionType.scale:
        return ScaleTransition(
          scale: animation,
          child: child,
        );
    }
  }

  static Route<T> createRoute<T>({
    required Widget page,
    required PageTransitionType type,
    Duration duration = const Duration(milliseconds: 300),
    Curve curve = Curves.easeInOut,
    bool reverse = false,
  }) {
    return PageRouteBuilder<T>(
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionDuration: duration,
      reverseTransitionDuration: duration,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        final curvedAnimation = CurvedAnimation(
          parent: animation,
          curve: curve,
        );
        return buildTransition(
          child: child,
          animation: curvedAnimation,
          type: type,
          reverse: reverse,
        );
      },
    );
  }
}
