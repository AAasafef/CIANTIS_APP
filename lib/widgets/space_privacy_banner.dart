import 'package:flutter/material.dart';

class SpacePrivacyBanner
    extends StatelessWidget {
  final bool locked;

  const SpacePrivacyBanner({
    super.key,
    required this.locked,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(
        20,
      ),
      decoration: BoxDecoration(
        color: locked
            ? const Color(
                0xFF47372B,
              )
            : Colors.white,
        borderRadius:
            BorderRadius.circular(
          28,
        ),
      ),
      child: Row(
        children: [
          Container(
            height: 58,
            width: 58,
            decoration: BoxDecoration(
              color: locked
                  ? Colors.white
                      .withOpacity(.12)
                  : const Color(
                      0xFFF4EFE8,
                    ),
              borderRadius:
                  BorderRadius.circular(
                18,
              ),
            ),
            child: Icon(
              locked
                  ? Icons.lock_outline
                  : Icons.shield_outlined,
              color: locked
                  ? Colors.white
                  : const Color(
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
                  locked
                      ? 'Protected Space'
                      : 'Security Available',
                  style: TextStyle(
                    color: locked
                        ? Colors.white
                        : const Color(
                            0xFF2D241D,
                          ),
                    fontSize: 18,
                    fontWeight:
                        FontWeight.w500,
                  ),
                ),

                const SizedBox(
                  height: 8,
                ),

                Text(
                  locked
                      ? 'Biometric and encrypted protection enabled for sensitive content.'
                      : 'Additional protection tools can be enabled later.',
                  style: TextStyle(
                    color: locked
                        ? Colors.white
                            .withOpacity(.82)
                        : Colors.black
                            .withOpacity(
                          .55,
                        ),
                    height: 1.5,
                    fontSize: 13,
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