import 'package:flutter/material.dart';

class LuxuryScrollView extends StatelessWidget {
  final Widget child;

  const LuxuryScrollView({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: child,
    );
  }
}
