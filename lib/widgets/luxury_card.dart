import 'package:flutter/material.dart';

import '../theme/ciantis_theme.dart';

import 'glass_container.dart';

class LuxuryCard extends StatelessWidget {
  final IconData icon;

  final String title;

  final String subtitle;

  final Widget? trailing;

  final VoidCallback? onTap;

  const LuxuryCard({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    this.trailing,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: 16,
      ),

      child: GestureDetector(
        onTap: onTap,

        child: GlassContainer(
          padding: const EdgeInsets.all(
            18,
          ),

          borderRadius:
              CiantisTheme.radiusLarge,

          child: Row(
            crossAxisAlignment:
                CrossAxisAlignment.start,

            children: [

              // ICON
              Icon(
                icon,
                color:
                    CiantisTheme.white,
                size: 30,
              ),

              const SizedBox(width: 16),

              // TEXT
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
                            FontWeight
                                .w300,
                      ),
                    ),

                    const SizedBox(
                      height: 6,
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

              const SizedBox(width: 16),

              // TRAILING
              if (trailing != null)
                trailing!,
            ],
          ),
        ),
      ),
    );
  }
}
