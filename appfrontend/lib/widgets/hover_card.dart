import 'package:flutter/material.dart';
import '../constants/app_dimensions.dart';

class HoverCard extends StatefulWidget {
  final Widget child;
  final double? elevation;
  final double? hoverElevation;
  final Duration? duration;
  final BorderRadius? borderRadius;
  final Color? color;
  final VoidCallback? onTap;

  const HoverCard({
    super.key,
    required this.child,
    this.elevation = AppDimensions.cardElevation,
    this.hoverElevation = AppDimensions.cardHoverElevation,
    this.duration = AppDimensions.hoverDuration,
    this.borderRadius,
    this.color,
    this.onTap,
  });

  @override
  State<HoverCard> createState() => _HoverCardState();
}

class _HoverCardState extends State<HoverCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _elevationAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: widget.duration,
      vsync: this,
    );

    _elevationAnimation = Tween<double>(
      begin: widget.elevation ?? AppDimensions.cardElevation,
      end: widget.hoverElevation ?? AppDimensions.cardHoverElevation,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));

    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 1.02,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _onEnter() {
    _animationController.forward();
  }

  void _onExit() {
    _animationController.reverse();
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => _onEnter(),
      onExit: (_) => _onExit(),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedBuilder(
          animation: _animationController,
          builder: (context, child) {
            return Transform.scale(
              scale: _scaleAnimation.value,
              child: Material(
                elevation: _elevationAnimation.value,
                borderRadius: widget.borderRadius ?? BorderRadius.circular(AppDimensions.borderRadiusMedium),
                color: widget.color ?? Colors.white,
                child: widget.child,
              ),
            );
          },
        ),
      ),
    );
  }
}