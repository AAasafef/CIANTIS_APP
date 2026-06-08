import 'package:flutter/material.dart';

class SpaceMiniStatCard
    extends StatelessWidget {
  final String value;

  final String label;

  final IconData icon;

  const SpaceMiniStatCard({
    super.key,
    required this.value,
    required this.label,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 170,
      padding: const EdgeInsets.all(
        20,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius:
            BorderRadius.circular(
          28,
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
            value,
            style: const TextStyle(
              fontSize: 30,
              fontWeight:
                  FontWeight.w300,
              color: Color(
                0xFF2D241D,
              ),
            ),
          ),

          const SizedBox(
            height: 8,
          ),

          Text(
            label,
            style: TextStyle(
              fontSize: 13,
              color: Colors.black
                  .withOpacity(.55),
            ),
          ),
        ],
      ),
    );
  }
}