import 'package:flutter/material.dart';

class DocumentCategoryChip
    extends StatelessWidget {
  final String title;

  final bool selected;

  final VoidCallback onTap;

  const DocumentCategoryChip({
    super.key,
    required this.title,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,

      child: AnimatedContainer(
        duration:
            const Duration(
          milliseconds: 250,
        ),

        margin:
            const EdgeInsets.only(
          right: 12,
        ),

        padding:
            const EdgeInsets.symmetric(
          horizontal: 18,
          vertical: 12,
        ),

        decoration: BoxDecoration(
          color: selected
              ? const Color(
                  0xFF2D241D,
                )
              : Colors.white,

          borderRadius:
              BorderRadius.circular(
            22,
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

            fontSize: 13,

            fontWeight:
                FontWeight.w500,
          ),
        ),
      ),
    );
  }
}