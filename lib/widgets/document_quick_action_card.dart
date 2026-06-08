import 'package:flutter/material.dart';

class DocumentQuickActionCard
    extends StatelessWidget {
  final String title;

  final String subtitle;

  final IconData icon;

  final VoidCallback onTap;

  const DocumentQuickActionCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 190,
        padding: const EdgeInsets.all(
          20,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius:
              BorderRadius.circular(
            28,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black
                  .withOpacity(
                .04,
              ),
              blurRadius: 18,
              offset: const Offset(
                0,
                10,
              ),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  height: 56,
                  width: 56,
                  decoration: BoxDecoration(
                    color: const Color(
                      0xFFF4EFE8,
                    ),
                    borderRadius:
                        BorderRadius.circular(
                      18,
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

                Container(
                  padding:
                      const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration:
                      BoxDecoration(
                    color:
                        const Color(
                      0xFFF4EFE8,
                    ),
                    borderRadius:
                        BorderRadius.circular(
                      999,
                    ),
                  ),
                  child: const Icon(
                    Icons.arrow_forward_ios_rounded,
                    size: 12,
                    color: Color(
                      0xFF6E5846,
                    ),
                  ),
                ),
              ],
            ),

            const Spacer(),

            Text(
              title,
              style:
                  const TextStyle(
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

            Expanded(
              child: Text(
                subtitle,
                style:
                    TextStyle(
                  fontSize: 13,
                  height: 1.5,
                  color: Colors.black
                      .withOpacity(
                    .55,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}