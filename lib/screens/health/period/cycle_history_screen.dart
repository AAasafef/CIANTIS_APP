import 'package:flutter/material.dart';

class CycleHistoryScreen extends StatelessWidget {
  const CycleHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4EFE8),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(
            24,
            20,
            24,
            24,
          ),
          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  _BackButtonBox(
                    onTap: () => Navigator.pop(context),
                  ),
                  const SizedBox(width: 14),
                  const Expanded(
                    child: Column(
                      crossAxisAlignment:
                          CrossAxisAlignment.start,
                      children: [
                        Text(
                          'History',
                          style: TextStyle(
                            fontSize: 42,
                            height: .95,
                            fontWeight: FontWeight.w300,
                            letterSpacing: -1.4,
                            color: Color(0xFF241D18),
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'PAST CYCLES',
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w300,
                            letterSpacing: 3,
                            color: Color(0xFF8B7D72),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              Expanded(
                child: ListView(
                  physics:
                      const BouncingScrollPhysics(),
                  children: const [
                    _CycleCard(
                      title:
                          'May 12 - May 17',
                      subtitle:
                          '29 day cycle',
                    ),
                    _CycleCard(
                      title:
                          'April 13 - April 18',
                      subtitle:
                          '30 day cycle',
                    ),
                    _CycleCard(
                      title:
                          'March 14 - March 19',
                      subtitle:
                          '28 day cycle',
                    ),
                    _CycleCard(
                      title:
                          'February 15 - February 20',
                      subtitle:
                          '29 day cycle',
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _CycleCard extends StatelessWidget {
  final String title;
  final String subtitle;

  const _CycleCard({
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin:
          const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color:
            const Color(0xFFFBF8F4).withOpacity(.9),
        borderRadius:
            BorderRadius.circular(22),
        border: Border.all(
          color: const Color(0xFFE2D8CD),
          width: .7,
        ),
      ),
      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: Color(0xFF241D18),
              fontSize: 18,
              fontWeight: FontWeight.w300,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            subtitle,
            style: const TextStyle(
              color: Color(0xFF8B7D72),
              fontSize: 13,
              fontWeight: FontWeight.w300,
            ),
          ),
        ],
      ),
    );
  }
}

class _BackButtonBox extends StatelessWidget {
  final VoidCallback onTap;

  const _BackButtonBox({
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 42,
        width: 42,
        decoration: BoxDecoration(
          color: const Color(
            0xFFFBF8F4,
          ).withOpacity(.9),
          borderRadius:
              BorderRadius.circular(14),
          border: Border.all(
            color: const Color(0xFFE2D8CD),
            width: .7,
          ),
        ),
        child: const Icon(
          Icons.chevron_left_rounded,
          color: Color(0xFF241D18),
        ),
      ),
    );
  }
}