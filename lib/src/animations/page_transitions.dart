import 'package:flutter/material.dart';
import '../models/onboarding_config.dart';

/// A utility class for creating custom page transition animations in onboarding flows.
/// 
/// This class provides various transition types including slide, fade, zoom, and scale
/// animations. It supports both forward and reverse transitions for a complete
/// navigation experience.
/// 
/// The class is designed to work seamlessly with the onboarding configuration
/// system and provides smooth, performant animations between pages.
/// 
/// Example usage:
/// ```dart
/// final transition = PageTransitions.buildTransition(
///   child: nextPage,
///   animation: animationController,
///   type: PageTransitionType.slide,
/// );
/// ```
class PageTransitions {
  /// Private constructor to prevent instantiation.
  /// This class only provides static utility methods.
  PageTransitions._();

  /// Builds a transition widget based on the specified animation type.
  /// 
  /// This method creates the appropriate transition widget for the given
  /// [PageTransitionType]. Each transition type provides a different visual
  /// effect when moving between onboarding pages.
  /// 
  /// Parameters:
  /// - [child]: The widget to apply the transition to (usually the new page)
  /// - [animation]: The animation controller driving the transition
  /// - [type]: The type of transition animation to apply
  /// - [reverse]: Whether this is a reverse transition (for back navigation)
  /// 
  /// Returns:
  /// A [Widget] with the applied transition animation.
  /// 
  /// Supported transition types:
  /// - [PageTransitionType.slide]: Horizontal slide animation
  /// - [PageTransitionType.fade]: Opacity fade animation
  /// - [PageTransitionType.zoom]: Scale with fade for zoom effect
  /// - [PageTransitionType.scale]: Simple scale animation
  static Widget buildTransition({
    required Widget child,
    required Animation<double> animation,
    required PageTransitionType type,
    bool reverse = false,
  }) {
    switch (type) {
      case PageTransitionType.slide:
        // Horizontal slide transition - slides from right to left by default
        // When reverse is true, slides from left to right (for back navigation)
        return SlideTransition(
          position: Tween<Offset>(
            begin: reverse ? const Offset(-1.0, 0.0) : const Offset(1.0, 0.0),
            end: Offset.zero,
          ).animate(animation),
          child: child,
        );
      case PageTransitionType.fade:
        // Simple opacity fade transition - smooth and subtle
        return FadeTransition(
          opacity: animation,
          child: child,
        );
      case PageTransitionType.zoom:
        // Combined scale and fade transition for a zoom effect
        // Starts slightly smaller (0.8) and fades in simultaneously
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
        // Pure scale transition - grows from 0 to full size
        return ScaleTransition(
          scale: animation,
          child: child,
        );
    }
  }

  /// Creates a complete route with the specified transition animation.
  /// 
  /// This method is useful for programmatic navigation where you need
  /// to create a custom route with onboarding-style transitions. It wraps
  /// the [buildTransition] method in a complete [Route] object.
  /// 
  /// Parameters:
  /// - [page]: The destination page widget
  /// - [type]: The type of transition animation
  /// - [duration]: Animation duration (defaults to 300ms)
  /// - [curve]: Animation curve (defaults to Curves.easeInOut)
  /// - [reverse]: Whether this is a reverse transition
  /// 
  /// Returns:
  /// A [Route<T>] that can be used with Navigator.push() or similar methods.
  /// 
  /// Example:
  /// ```dart
  /// final route = PageTransitions.createRoute(
  ///   page: NextPage(),
  ///   type: PageTransitionType.fade,
  ///   duration: Duration(milliseconds: 500),
  /// );
  /// Navigator.of(context).push(route);
  /// ```
  static Route<T> createRoute<T>({
    required Widget page,
    required PageTransitionType type,
    Duration duration = const Duration(milliseconds: 300),
    Curve curve = Curves.easeInOut,
    bool reverse = false,
  }) {
    return PageRouteBuilder<T>(
      // The page builder provides the destination widget
      pageBuilder: (context, animation, secondaryAnimation) => page,
      
      // Set both forward and reverse transition durations
      transitionDuration: duration,
      reverseTransitionDuration: duration,
      
      // Build the actual transition animation
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        // Apply the specified curve to the animation
        final curvedAnimation = CurvedAnimation(
          parent: animation,
          curve: curve,
        );
        
        // Return the transition widget
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
