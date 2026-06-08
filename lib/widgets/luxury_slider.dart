import 'package:flutter/material.dart';

import '../theme/ciantis_theme.dart';

class LuxurySlider extends StatelessWidget {
  final double value;
  final ValueChanged<double> onChanged;

  const LuxurySlider({
    super.key,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Slider(
      value: value,
      min: 0,
      max: 1,
      divisions: 100,
      activeColor: CiantisTheme.white,
      inactiveColor: Colors.white.withOpacity(.15),
      onChanged: onChanged,
    );
  }
}
