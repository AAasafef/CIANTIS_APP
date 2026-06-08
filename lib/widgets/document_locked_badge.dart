import 'package:flutter/material.dart';

class DocumentLockedBadge extends StatelessWidget {
  const DocumentLockedBadge({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 7,
      ),
      decoration: BoxDecoration(
        color: const Color(0xFF2D241D),
        borderRadius: BorderRadius.circular(18),
      ),
      child: const Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.lock_outline,
            color: Colors.white,
            size: 13,
          ),
          SizedBox(width: 6),
          Text(
            'Secured',
            style: TextStyle(
              color: Colors.white,
              fontSize: 11,
              letterSpacing: .6,
            ),
          ),
        ],
      ),
    );
  }
}