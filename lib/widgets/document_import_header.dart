import 'package:flutter/material.dart';

class DocumentImportHeader
    extends StatelessWidget {
  const DocumentImportHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(
        26,
      ),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            Color(0xFFB08D6D),
            Color(0xFFD9C3AF),
          ],
        ),
        borderRadius: BorderRadius.circular(
          32,
        ),
      ),
      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                height: 60,
                width: 60,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(
                    .18,
                  ),
                  borderRadius:
                      BorderRadius.circular(
                    20,
                  ),
                ),
                child: const Icon(
                  Icons.cloud_upload_outlined,
                  color: Colors.white,
                  size: 28,
                ),
              ),

              const Spacer(),

              Container(
                padding:
                    const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(
                    .14,
                  ),
                  borderRadius:
                      BorderRadius.circular(
                    18,
                  ),
                ),
                child: const Text(
                  'SMART IMPORT',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 11,
                    letterSpacing: 1.2,
                    fontWeight:
                        FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(
            height: 24,
          ),

          const Text(
            'Import & Organize Instantly',
            style: TextStyle(
              color: Colors.white,
              fontSize: 28,
              fontWeight:
                  FontWeight.w300,
              height: 1.2,
            ),
          ),

          const SizedBox(
            height: 12,
          ),

          Text(
            'Ciantis intelligently scans, categorizes, and secures your documents automatically.',
            style: TextStyle(
              color: Colors.white.withOpacity(
                .92,
              ),
              fontSize: 14,
              height: 1.6,
            ),
          ),
        ],
      ),
    );
  }
}