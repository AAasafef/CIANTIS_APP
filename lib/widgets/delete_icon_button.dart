import 'package:flutter/material.dart';

class DeleteIconButton extends StatelessWidget {
  final VoidCallback onPressed;

  const DeleteIconButton({
    super.key,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.all(
          10,
        ),
        decoration: BoxDecoration(
          color: Colors.red.withOpacity(
            .12,
          ),
          shape: BoxShape.circle,
        ),
        child: const Icon(
          Icons.delete_outline,
          color: Colors.redAccent,
          size: 20,
        ),
      ),
    );
  }
}
