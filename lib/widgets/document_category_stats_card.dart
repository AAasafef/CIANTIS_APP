import 'package:flutter/material.dart';

class DocumentCategoryStatsCard
    extends StatelessWidget {
  final String title;

  final String amount;

  final IconData icon;

  const DocumentCategoryStatsCard({
    super.key,
    required this.title,
    required this.amount,
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
            CrossAxisAlignment
                .start,
        children: [
          Row(
            children: [
              Container(
                height: 54,
                width: 54,
                decoration:
                    BoxDecoration(
                  color:
                      const Color(
                    0xFFF4EFE8,
                  ),
                  borderRadius:
                      BorderRadius.circular(
                    18,
                  ),
                ),
                child: Icon(
                  icon,
                  color:
                      const Color(
                    0xFF6E5846,
                  ),
                ),
              ),

              const Spacer(),

              Container(
                padding:
                    const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 5,
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
                child: const Text(
                  'Vault',
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight:
                        FontWeight.w600,
                    color: Color(
                      0xFF6E5846,
                    ),
                  ),
                ),
              ),
            ],
          ),

          const Spacer(),

          Text(
            amount,
            style:
                const TextStyle(
              fontSize: 28,
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
            title,
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
    );
  }
}