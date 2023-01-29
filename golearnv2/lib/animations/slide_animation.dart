// ignore_for_file: prefer_const_constructors, no_leading_underscores_for_local_identifiers

import 'package:flutter/material.dart';
import 'package:golearnv2/configs/constants.dart';
import 'package:golearnv2/enums/slide_direction.dart';

class SlideAnimation extends StatefulWidget {
  const SlideAnimation({
    required this.child,
    required this.direction,
    this.animate = true,
    Key? key,
    this.reset,
    this.animationCompleted,
    this.animationDuration = kSlideAwayDuration,
    this.animationDelay = 0,
  }) : super(key: key);

  final Widget child;
  final SlideDirection direction;
  final bool animate;
  final bool? reset;
  final VoidCallback? animationCompleted;
  final int animationDuration;
  final int animationDelay;

  @override
  State<SlideAnimation> createState() => _SlideAnimation();
}

class _SlideAnimation extends State<SlideAnimation>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;

  @override
  void initState() {
    _animationController = AnimationController(
        duration: Duration(milliseconds: widget.animationDuration), vsync: this)
      ..addListener(() {
        if (_animationController.isCompleted) {
          widget.animationCompleted?.call();
        }
      });

    super.initState();
  }

  @override
  void didUpdateWidget(covariant SlideAnimation oldWidget) {
    if (widget.reset == true) {
      _animationController.reset();
    }

    if (widget.animate) {
      if (widget.animationDelay > 0) {
        Future.delayed(Duration(milliseconds: widget.animationDelay), () {
          if (mounted) {
            _animationController.forward();
          }
        });
      } else {
        _animationController.forward();
      }
    }

    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    late final Animation<Offset> _animation;
    Tween<Offset> tween;

    switch (widget.direction) {
      //THIS IS A LIST OF ALL POSSIBLE EASEINOUT ANIMATION OF THE FLASHCARD
      case SlideDirection.leftAway:
        tween =
            Tween<Offset>(begin: const Offset(0, 0), end: const Offset(-1, 0));
        break;
      case SlideDirection.rightAway:
        tween =
            Tween<Offset>(begin: const Offset(0, 0), end: const Offset(1, 0));
        break;
      case SlideDirection.leftIn:
        tween =
            Tween<Offset>(begin: const Offset(-1, 0), end: const Offset(0, 0));
        break;
      case SlideDirection.rightIn:
        tween =
            Tween<Offset>(begin: const Offset(1, 0), end: const Offset(0, 0));
        break;
      case SlideDirection.upIn:
        tween =
            Tween<Offset>(begin: const Offset(0, 1), end: const Offset(0, 0));
        break;
      case SlideDirection.none:
        tween =
            Tween<Offset>(begin: const Offset(0, 0), end: const Offset(0, 0));
        break;
    }

    _animation = tween.animate(
        CurvedAnimation(parent: _animationController, curve: Curves.easeInOut));
    return SlideTransition(
      position: _animation,
      child: widget.child,
    );
  }
}
