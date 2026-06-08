import 'package:flutter/material.dart';

class CycleComfortCenterScreen
    extends StatelessWidget {
  const CycleComfortCenterScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final items = [
      'Drink Water',
      'Take Medication',
      'Heating Pad',
      'Rest',
      'Warm Bath',
      'Tea',
      'Sleep',
      'Journal',
    ];

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
                          'Comfort',
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
                          'SELF CARE',
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
                child: GridView.builder(
                  itemCount: items.length,
                  gridDelegate:
                      const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                    childAspectRatio: 1.25,
                  ),
                  itemBuilder:
                      (context, index) {
                    return Container(
                      decoration: BoxDecoration(
                        color: const Color(
                          0xFFFBF8F4,
                        ).withOpacity(.9),
                        borderRadius:
                            BorderRadius.circular(
                          22,
                        ),
                        border: Border.all(
                          color: const Color(
                            0xFFE2D8CD,
                          ),
                          width: .7,
                        ),
                      ),
                      alignment:
                          Alignment.center,
                      child: Text(
                        items[index],
                        textAlign:
                            TextAlign.center,
                        style: const TextStyle(
                          color:
                              Color(0xFF241D18),
                          fontSize: 15,
                          fontWeight:
                              FontWeight.w300,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
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