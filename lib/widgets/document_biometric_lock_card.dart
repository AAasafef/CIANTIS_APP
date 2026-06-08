import 'package:flutter/material.dart';

class DocumentBiometricLockCard
    extends StatelessWidget {
  final VoidCallback onTap;

  const DocumentBiometricLockCard({
    super.key,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(
          24,
        ),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [
              Color(0xFF2D241D),
              Color(0xFF47372B),
            ],
          ),
          borderRadius: BorderRadius.circular(
            32,
          ),
        ),
        child: Row(
          children: [
            Container(
              height: 72,
              width: 72,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(
                  .12,
                ),
                borderRadius:
                    BorderRadius.circular(
                  22,
                ),
              ),
              child: const Icon(
                Icons.fingerprint,
                color: Colors.white,
                size: 34,
              ),
            ),

            const SizedBox(
              width: 20,
            ),

            Expanded(
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Biometric Vault Lock',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight:
                          FontWeight.w500,
                    ),
                  ),

                  const SizedBox(
                    height: 10,
                  ),

                  Text(
                    'Protect sensitive files using fingerprint or Face ID authentication.',
                    style: TextStyle(
                      color: Colors.white
                          .withOpacity(.82),
                      fontSize: 14,
                      height: 1.6,
                    ),
                  ),
                ],
              ),
            ),

            Icon(
              Icons.arrow_forward_ios_rounded,
              color: Colors.white.withOpacity(
                .55,
              ),
              size: 18,
            ),
          ],
        ),
      ),
    );
  }
}