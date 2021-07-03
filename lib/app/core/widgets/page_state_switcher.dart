import 'package:centic_bids/app/core/app_constants.dart';
import 'package:flutter/material.dart';

class PageStateSwitcher extends StatelessWidget {
  final Widget child;
  final int animationDuration;

  PageStateSwitcher(
      {Key? key,
      required this.child,
      this.animationDuration = AppConstants.animation_duration ~/ 2})
      : super(key: key);

  final Tween<double> tween = Tween<double>(begin: 0.0, end: 1.0);

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      key: Key(child.toString()),
      tween: tween,
      duration: Duration(milliseconds: animationDuration),
      curve: Curves.easeInOutCubic,
      builder: (context, value, child) => Opacity(
        opacity: value,
        child: Transform.scale(
            scale: 0.95 + (0.05 * value),
            child: child),
      ),
      child: child,
    );
  }
}
