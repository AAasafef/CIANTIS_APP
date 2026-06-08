import 'package:flutter/material.dart';

class DocumentRecentActivityTile
    extends StatelessWidget {
  final String title;

  final String subtitle;

  final IconData icon;

  const DocumentRecentActivityTile({
    super.key,
    required this.title,
    required this.subtitle,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        bottom: 14,
      ),
      padding: const EdgeInsets.all(
        18,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(
          24,
        ),
      ),
      child: Row(
        children: [
          Container(
            height: 52,
            width: 52,
            decoration: BoxDecoration(
              borderRadius:
                  BorderRadius.circular(
                18,
              ),
              color: const Color(
                0xFFF4EFE8,
              ),
            ),
            child: Icon(
              icon,
              color: const Color(
                0xFF6E5846,
              ),
            ),
          ),

          const SizedBox(
            width: 16,
          ),

          Expanded(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
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

                const SizedBox(
                  height: 6,
                ),

                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.black
                        .withOpacity(.55),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}