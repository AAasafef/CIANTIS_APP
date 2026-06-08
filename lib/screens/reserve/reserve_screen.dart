import 'package:flutter/material.dart';

import '../../widgets/ciantis_side_drawer.dart';

class ReserveScreen extends StatelessWidget {
  const ReserveScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4EFE8),
      drawer: const CiantisSideDrawer(),
      drawerEnableOpenDragGesture: true,
      appBar: AppBar(
        backgroundColor: const Color(0xFFF4EFE8),
        elevation: 0,
        iconTheme: const IconThemeData(
          color: Color(0xFF2D241D),
        ),
        title: const Text(
          'Reserve',
          style: TextStyle(
            color: Color(0xFF2D241D),
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Reserve',
                style: TextStyle(
                  fontSize: 46,
                  height: .95,
                  fontWeight: FontWeight.w300,
                  letterSpacing: -1.4,
                  color: Color(0xFF241D18),
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'PRIVATE VAULT',
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w300,
                  letterSpacing: 3.2,
                  color: Color(0xFF8B7D72),
                ),
              ),
              const SizedBox(height: 32),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.lock_outline_rounded,
                      color: Color(0xFF6E5846),
                      size: 34,
                    ),
                    SizedBox(height: 20),
                    Text(
                      'Your secure reserve space is ready.',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w300,
                        color: Color(0xFF2D241D),
                      ),
                    ),
                    SizedBox(height: 12),
                    Text(
                      'Passwords, private documents, IDs, records, and important stored information will live here.',
                      style: TextStyle(
                        fontSize: 14,
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