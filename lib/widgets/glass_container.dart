import 'dart:ui';
import 'package:flutter/material.dart';

import '../theme/ciantis_theme.dart';

class GlassContainer extends StatelessWidget {
  final Widget child;
  final EdgeInsets padding;
  final double borderRadius;

  const GlassContainer({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(24),
    this.borderRadius = CiantisTheme.radiusXLarge,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(
        borderRadius,
      ),
      child: BackdropFilter(
        filter: ImageFilter.blur(
          sigmaX: CiantisTheme.blurLight,
          sigmaY: CiantisTheme.blurLight,
        ),
        child: Container(
          padding: padding,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(
              CiantisTheme.glassOpacity,
            ),
            borderRadius: BorderRadius.circular(
              borderRadius,
            ),
            border: Border.all(
              color: Colors.white.withOpacity(
                CiantisTheme.glassBorderOpacity,
              ),
            ),
          ),
          child: child,
        ),
      ),
    );
  }
}
