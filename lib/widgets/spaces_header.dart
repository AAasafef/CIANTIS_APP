import 'package:flutter/material.dart';

class SpacesHeader extends StatelessWidget {
  final VoidCallback onMenuTap;

  const SpacesHeader({
    super.key,
    required this.onMenuTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Expanded(
              child: Text(
                'Ciantis',
                style: TextStyle(
                  fontSize: 42,
                  fontWeight: FontWeight.w300,
                  letterSpacing: -1,
                  color: Color(0xFF2D241D),
                ),
              ),
            ),
            GestureDetector(
              onTap: onMenuTap,
              child: Container(
                height: 54,
                width: 54,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(18),
                ),
                child: const Icon(
                  Icons.menu_rounded,
                  color: Color(0xFF2D241D),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Text(
          'Your luxury life operating system.',
          style: TextStyle(
            fontSize: 15,
            color: Colors.black.withOpacity(.55),
          ),
        ),
      ],
    );
  }
}