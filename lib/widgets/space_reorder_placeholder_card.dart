import 'package:flutter/material.dart';

class SpaceReorderPlaceholderCard
    extends StatelessWidget {
  const SpaceReorderPlaceholderCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(
        22,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius:
            BorderRadius.circular(
          30,
        ),
      ),
      child: Row(
        children: [
          Container(
            height: 62,
            width: 62,
            decoration: BoxDecoration(
              color: const Color(
                0xFFF4EFE8,
              ),
              borderRadius:
                  BorderRadius.circular(
                20,
              ),
            ),
            child: const Icon(
              Icons.reorder_rounded,
              color: Color(
                0xFF6E5846,
              ),
            ),
          ),

          const SizedBox(
            width: 18,
          ),

          Expanded(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment
                      .start,
              children: [
                const Text(
                  'Future Space Management',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight:
                        FontWeight.w500,
                    color: Color(
                      0xFF2D241D,
                    ),
                  ),
                ),

                const SizedBox(
                  height: 8,
                ),

                Text(
                  'Reorder, hide, customize, and lock spaces later.',
                  style: TextStyle(
                    fontSize: 13,
                    height: 1.5,
                    color: Colors.black
                        .withOpacity(
                      .55,
                    ),
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