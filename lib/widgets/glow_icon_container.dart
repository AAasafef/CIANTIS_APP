import 'package:flutter/material.dart';

import '../theme/ciantis_theme.dart';

class GlowIconContainer extends StatelessWidget {
  final IconData icon;
  final double size;

  const GlowIconContainer({
    super.key,
    required this.icon,
    this.size = 28,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 62,
      width: 62,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(.10),
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Colors.white.withOpacity(.08),
            blurRadius: 18,
            spreadRadius: 1,
          ),
        ],
      ),
      child: Icon(
        icon,
        color: CiantisTheme.white,
        size: size,
      ),
    );
  }
}
