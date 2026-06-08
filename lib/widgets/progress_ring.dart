import 'package:flutter/material.dart';

import '../theme/ciantis_theme.dart';

class ProgressRing extends StatelessWidget {
  final String text;

  const ProgressRing({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 54,
      width: 54,
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.white.withOpacity(.25),
        ),
        shape: BoxShape.circle,
      ),
      child: Center(
        child: Text(
          text,
          style: const TextStyle(
            color: CiantisTheme.white,
            fontSize: 12,
          ),
        ),
      ),
    );
  }
}
