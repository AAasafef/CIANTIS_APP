import 'package:flutter/material.dart';

import '../theme/ciantis_theme.dart';

class OnboardingOptionCard
    extends StatelessWidget {

  final String title;

  final String subtitle;

  final bool selected;

  final VoidCallback onTap;

  const OnboardingOptionCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,

      child: AnimatedContainer(
        duration:
            const Duration(
          milliseconds: 250,
        ),

        margin:
            const EdgeInsets.only(
          bottom: 16,
        ),

        padding:
            const EdgeInsets.all(22),

        decoration: BoxDecoration(
          color: selected
              ? Colors.white
                  .withOpacity(.18)
              : Colors.white
                  .withOpacity(.08),

          borderRadius:
              BorderRadius.circular(
            26,
          ),

          border: Border.all(
            color: selected
                ? CiantisTheme.white
                : Colors.white
                    .withOpacity(.08),

            width: 1.3,
          ),
        ),

        child: Row(
          children: [

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
                      color:
                          CiantisTheme
                              .white,

                      fontSize: 18,

                      fontWeight:
                          FontWeight.w300,
                    ),
                  ),

                  const SizedBox(
                    height: 8,
                  ),

                  Text(
                    subtitle,
                    style:
                        const TextStyle(
                      color:
                          CiantisTheme
                              .whiteSoft,

                      fontSize: 13,

                      height: 1.5,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(width: 18),

            AnimatedContainer(
              duration:
                  const Duration(
                milliseconds: 250,
              ),

              height: 28,
              width: 28,

              decoration: BoxDecoration(
                shape: BoxShape.circle,

                color: selected
                    ? Colors.white
                    : Colors.transparent,

                border: Border.all(
                  color:
                      Colors.white,
                ),
              ),

              child: selected
                  ? const Icon(
                      Icons.check,
                      size: 18,
                      color:
                          Colors.black,
                    )
                  : null,
            ),
          ],
        ),
      ),
    );
  }
}
