import 'package:flutter/material.dart';

import '../theme/ciantis_theme.dart';

class EditIconButton extends StatelessWidget {
  final VoidCallback onPressed;

  const EditIconButton({
    super.key,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(.10),
          shape: BoxShape.circle,
        ),
        child: const Icon(
          Icons.edit_outlined,
          color: CiantisTheme.white,
          size: 20,
        ),
      ),
    );
  }
}
