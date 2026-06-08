import 'package:flutter/material.dart';

class SpaceSectionTitle
    extends StatelessWidget {
  final String title;

  final String? actionText;

  final VoidCallback? onTap;

  const SpaceSectionTitle({
    super.key,
    required this.title,
    this.actionText,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 24,
              fontWeight:
                  FontWeight.w400,
              color: Color(
                0xFF2D241D,
              ),
            ),
          ),
        ),

        if (actionText != null)
          GestureDetector(
            onTap: onTap,
            child: Text(
              actionText!,
              style: const TextStyle(
                fontSize: 14,
                fontWeight:
                    FontWeight.w500,
                color: Color(
                  0xFFB08D6D,
                ),
              ),
            ),
          ),
      ],
    );
  }
}