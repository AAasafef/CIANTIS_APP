import 'package:flutter/material.dart';

class ReserveHomeScreen extends StatelessWidget {
  const ReserveHomeScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4EFE8),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.start,
            children: [
              const Text(
                'Reserve',
                style: TextStyle(
                  fontSize: 46,
                  fontWeight: FontWeight.w300,
                  letterSpacing: -1.4,
                  color: Color(0xFF241D18),
                ),
              ),

              const SizedBox(height: 8),

              const Text(
                'PRIVATE VAULT',
                style: TextStyle(
                  fontSize: 11,
                  letterSpacing: 3,
                  color: Color(0xFF8B7D72),
                ),
              ),

              const SizedBox(height: 30),

              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius:
                      BorderRadius.circular(28),
                ),
                child: const Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.shield_outlined,
                      size: 34,
                      color: Color(0xFF6E5846),
                    ),
                    SizedBox(height: 16),
                    Text(
                      'Reserve is ready.',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight:
                            FontWeight.w300,
                        color: Color(0xFF241D18),
                      ),
                    ),
                    SizedBox(height: 12),
                    Text(
                      'Passwords, legal records, emergency information, secure documents, account details, and private files will live here.',
                      style: TextStyle(
                        height: 1.6,
                        color: Color(0xFF8B7D72),
                      ),
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