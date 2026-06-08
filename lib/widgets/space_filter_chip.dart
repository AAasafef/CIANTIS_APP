import 'package:flutter/material.dart';

class SpaceFilterChip
    extends StatelessWidget {
  final String title;

  final bool selected;

  final VoidCallback onTap;

  const SpaceFilterChip({
    super.key,
    required this.title,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding:
            const EdgeInsets.symmetric(
          horizontal: 18,
          vertical: 12,
        ),
        decoration: BoxDecoration(
          color: selected
              ? const Color(
                  0xFFB08D6D,
                )
              : Colors.white,
          borderRadius:
              BorderRadius.circular(
            18,
          ),
        ),
        child: Text(
          title,
          style: TextStyle(
            color: selected
                ? Colors.white
                : const Color(
                    0xFF2D241D,
                  ),
            fontWeight:
                FontWeight.w500,
          ),
        ),
      ),
    );
  }
}