import 'package:flutter/material.dart';

class LuxurySectionSpacing extends StatelessWidget {
  final double height;

  const LuxurySectionSpacing({
    super.key,
    this.height = 30,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
    );
  }
}
