import 'package:flutter/material.dart';

class ComingSoonScreen extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;

  const ComingSoonScreen({
    super.key,
    required this.title,
    required this.subtitle,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4EFE8),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      height: 48,
                      width: 48,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(18),
                      ),
                      child: const Icon(
                        Icons.arrow_back,
                        color: Color(0xFF2D241D),
                      ),
                    ),
                  ),
                ],
              ),
              const Spacer(),
              Container(
                height: 110,
                width: 110,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(34),
                ),
                child: Icon(
                  icon,
                  size: 50,
                  color: const Color(0xFFB08D6D),
                ),
              ),
              const SizedBox(height: 28),
              Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.w300,
                  color: Color(0xFF2D241D),
                ),
              ),
              const SizedBox(height: 14),
              Text(
                subtitle,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 15,
                  height: 1.7,
                  color: Colors.black.withOpacity(.55),
                ),
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}