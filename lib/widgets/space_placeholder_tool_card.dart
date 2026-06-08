import 'package:flutter/material.dart';

class SpacePlaceholderToolCard
    extends StatelessWidget {
  final String title;

  final IconData icon;

  const SpacePlaceholderToolCard({
    super.key,
    required this.title,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120,
      padding: const EdgeInsets.all(
        18,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius:
            BorderRadius.circular(
          26,
        ),
      ),
      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,
        children: [
          Container(
            height: 52,
            width: 52,
            decoration: BoxDecoration(
              color: const Color(
                0xFFF4EFE8,
              ),
              borderRadius:
                  BorderRadius.circular(
                16,
              ),
            ),
            child: Icon(
              icon,
              color: const Color(
                0xFF6E5846,
              ),
            ),
          ),

          const Spacer(),

          Text(
            title,
            style: const TextStyle(
              fontSize: 15,
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