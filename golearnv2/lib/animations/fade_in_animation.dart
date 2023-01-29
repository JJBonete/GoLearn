// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class FadeInAnimation extends StatefulWidget {
  const FadeInAnimation({Key? key, required this.child}) : super(key: key);

  //THIS IS THE ANIMATION FOR THE CARDS TO COME INSIDE THE SCREEN

  final Widget child;

  @override
  State<FadeInAnimation> createState() => _FadeInAnimation();
}

class _FadeInAnimation extends State<FadeInAnimation>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;
  late final Animation<double> _scaleAnimation, _opacityAnimation;
  @override
  void initState() {
    _animationController = AnimationController(
        duration: const Duration(milliseconds: 800), vsync: this);
    super.initState();

    _scaleAnimation = Tween<double>(begin: 0.9, end: 1.0).animate(
        CurvedAnimation(parent: _animationController, curve: Curves.easeInOut));

    _opacityAnimation = Tween<double>(begin: 0.50, end: 1.0).animate(
        CurvedAnimation(parent: _animationController, curve: Curves.easeInOut));

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) => Opacity(
        opacity: _opacityAnimation.value,
        child: Transform(
          alignment: Alignment.center,
          transform: Matrix4.identity()..scale(_scaleAnimation.value),
          child: widget.child,
        ),
      ),
    );
  }
}
