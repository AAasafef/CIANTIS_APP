import 'package:flutter/material.dart';

import '../theme/ciantis_theme.dart';

class LuxuryProgressBar extends StatelessWidget {
  final double value;

  const LuxuryProgressBar({
    super.key,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(
        20,
      ),
      child: LinearProgressIndicator(
        value: value,
        minHeight: 10,
        backgroundColor:
            Colors.white.withOpacity(.08),
        valueColor:
            const AlwaysStoppedAnimation(
          CiantisTheme.white,
        ),
      ),
    );
  }
}
