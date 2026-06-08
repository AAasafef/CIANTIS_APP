import 'package:flutter/material.dart';

import 'daily_devotional_screen.dart';
import 'daily_devotional_service.dart';

class DashboardDevotionalCard extends StatelessWidget {
  final AnimationController pulseController;
  final VoidCallback onCheckIn;

  const DashboardDevotionalCard({
    super.key,
    required this.pulseController,
    required this.onCheckIn,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<DailyDevotional>(
      future: DailyDevotionalService.getTodayDevotional(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Container(
            height: 160,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(28),
            ),
            child: const Center(
              child: CircularProgressIndicator(
                color: Color(0xFF2D241D),
              ),
            ),
          );
        }

        final devotional = snapshot.data!;

        return Container(
          width: double.infinity,
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(28),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    height: 38,
                    width: 38,
                    decoration: BoxDecoration(
                      color: const Color(0xFFF4EFE8),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: const Icon(
                      Icons.menu_book_rounded,
                      color: Color(0xFF6E5846),
                      size: 21,
                    ),
                  ),
                  const SizedBox(width: 12),
                  const Expanded(
                    child: Text(
                      'Daily Devotional',
                      style: TextStyle(
                        color: Color(0xFF2D241D),
                        fontSize: 20,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  const Text(
                    '0/3',
                    style: TextStyle(
                      color: Color(0xFF6E5846),
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 14),
              Text(
                devotional.reference,
                style: const TextStyle(
                  color: Color(0xFF6E5846),
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                '"${devotional.verse}"',
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: Colors.black.withOpacity(.72),
                  fontSize: 15,
                  height: 1.45,
                ),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) =>
                              const DailyDevotionalScreen(),
                        ),
                      );
                    },
                    child: const Text(
                      'Read More',
                      style: TextStyle(
                        color: Color(0xFF2D241D),
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  const Spacer(),
                  AnimatedBuilder(
                    animation: pulseController,
                    builder: (context, child) {
                      final glow =
                          0.10 + (pulseController.value * 0.16);

                      return GestureDetector(
                        onTap: onCheckIn,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 10,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xFF2D241D),
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: const Color(0xFF2D241D)
                                    .withOpacity(glow),
                                blurRadius: 18,
                                spreadRadius: 1,
                              ),
                            ],
                          ),
                          child: const Text(
                            'Check In ✨',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}