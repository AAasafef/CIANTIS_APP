import 'package:flutter/material.dart';

class SpaceStatusChip
    extends StatelessWidget {
  final String title;

  final IconData icon;

  const SpaceStatusChip({
    super.key,
    required this.title,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:
          const EdgeInsets.symmetric(
        horizontal: 14,
        vertical: 10,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius:
            BorderRadius.circular(
          18,
        ),
      ),
      child: Row(
        mainAxisSize:
            MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 18,
            color: const Color(
              0xFF6E5846,
            ),
          ),

          const SizedBox(
            width: 8,
          ),

          Text(
            title,
            style: const TextStyle(
              fontSize: 13,
              fontWeight:
                  FontWeight.w500,
              color: Color(
                0xFF2D241D,
              ),
            ),
          ),
        ],
      ),
    );
  }
}