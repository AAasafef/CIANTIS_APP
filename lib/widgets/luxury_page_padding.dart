import 'package:flutter/material.dart';

class LuxuryPagePadding extends StatelessWidget {
  final Widget child;

  const LuxuryPagePadding({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 24,
        vertical: 10,
      ),
      child: child,
    );
  }
}
