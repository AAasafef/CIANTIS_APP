import 'package:flutter/material.dart';

import 'daily_devotional_service.dart';

class DailyDevotionalScreen extends StatelessWidget {
  const DailyDevotionalScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4EFE8),
      body: FutureBuilder<DailyDevotional>(
        future: DailyDevotionalService.getTodayDevotional(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(
                color: Color(0xFF2D241D),
              ),
            );
          }

          final devotional = snapshot.data!;

          return SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(
                24,
                24,
                24,
                40,
              ),
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      height: 52,
                      width: 52,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius:
                            BorderRadius.circular(20),
                      ),
                      child: const Icon(
                        Icons.arrow_back_rounded,
                        color: Color(0xFF2D241D),
                      ),
                    ),
                  ),

                  const SizedBox(height: 28),

                  const Text(
                    'Daily Devotional',
                    style: TextStyle(
                      fontSize: 34,
                      fontWeight: FontWeight.w300,
                      color: Color(0xFF2D241D),
                      letterSpacing: -.8,
                    ),
                  ),

                  const SizedBox(height: 22),

                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius:
                          BorderRadius.circular(30),
                    ),
                    child: Column(
                      crossAxisAlignment:
                          CrossAxisAlignment.start,
                      children: [
                        Text(
                          devotional.reference,
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF6E5846),
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          '"${devotional.verse}"',
                          style: const TextStyle(
                            fontSize: 24,
                            height: 1.5,
                            color: Color(0xFF2D241D),
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 18),

                  _SectionCard(
                    title: 'Devotional Reflection',
                    content: devotional.reflection,
                  ),

                  const SizedBox(height: 14),

                  _SectionCard(
                    title: 'Prayer',
                    content: devotional.prayer,
                  ),

                  const SizedBox(height: 14),

                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius:
                          BorderRadius.circular(26),
                    ),
                    child: Column(
                      crossAxisAlignment:
                          CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Journal Response',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF2D241D),
                          ),
                        ),
                        const SizedBox(height: 14),
                        TextField(
                          maxLines: 8,
                          decoration: InputDecoration(
                            hintText:
                                'Write your thoughts, reflections, or prayers...',
                            filled: true,
                            fillColor:
                                const Color(0xFFF8F4EF),
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.circular(20),
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 24),

                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: 58,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                BorderRadius.circular(24),
                          ),
                          alignment: Alignment.center,
                          child: const Text(
                            'Save',
                            style: TextStyle(
                              color: Color(0xFF2D241D),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(width: 12),

                      Expanded(
                        child: Container(
                          height: 58,
                          decoration: BoxDecoration(
                            color: Color(0xFF2D241D),
                            borderRadius:
                                BorderRadius.circular(24),
                          ),
                          alignment: Alignment.center,
                          child: const Text(
                            'Mark Complete',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class _SectionCard extends StatelessWidget {
  final String title;
  final String content;

  const _SectionCard({
    required this.title,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(26),
      ),
      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Color(0xFF2D241D),
            ),
          ),
          const SizedBox(height: 12),
          Text(
            content,
            style: const TextStyle(
              fontSize: 15,
              height: 1.65,
              color: Color(0xFF4E4035),
            ),
          ),
        ],
      ),
    );
  }
}