import 'package:flutter/material.dart';

class SpaceActionCard
    extends StatelessWidget {
  final String title;

  final String subtitle;

  final IconData icon;

  final VoidCallback onTap;

  const SpaceActionCard({
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
              height: 64,
              width: 64,
              decoration: BoxDecoration(
                color: const Color(
                  0xFFF4EFE8,
                ),
                borderRadius:
                    BorderRadius.circular(
                  20,
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
              width: 18,
            ),

            Expanded(
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment
                        .start,
                children: [
                  Text(
                    title,
                    style:
                        const TextStyle(
                      fontSize: 18,
                      fontWeight:
                          FontWeight
                              .w500,
                      color: Color(
                        0xFF2D241D,
                      ),
                    ),
                  ),

                  const SizedBox(
                    height: 8,
                  ),

                  Text(
                    subtitle,
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

            Icon(
              Icons
                  .arrow_forward_ios_rounded,
              size: 18,
              color: Colors.black
                  .withOpacity(.35),
            ),
          ],
        ),
      ),
    );
  }
}