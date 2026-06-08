import 'package:flutter/material.dart';

class SpaceEmptyState
    extends StatelessWidget {
  final String title;

  final String subtitle;

  final IconData icon;

  const SpaceEmptyState({
    super.key,
    required this.title,
    required this.subtitle,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding:
            const EdgeInsets.all(
          30,
        ),
        child: Column(
          mainAxisAlignment:
              MainAxisAlignment
                  .center,
          children: [
            Container(
              height: 110,
              width: 110,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius:
                    BorderRadius.circular(
                  34,
                ),
              ),
              child: Icon(
                icon,
                size: 50,
                color: const Color(
                  0xFFB08D6D,
                ),
              ),
            ),

            const SizedBox(
              height: 28,
            ),

            Text(
              title,
              textAlign:
                  TextAlign.center,
              style: const TextStyle(
                fontSize: 28,
                fontWeight:
                    FontWeight.w300,
                color: Color(
                  0xFF2D241D,
                ),
              ),
            ),

            const SizedBox(
              height: 14,
            ),

            Text(
              subtitle,
              textAlign:
                  TextAlign.center,
              style: TextStyle(
                fontSize: 15,
                height: 1.7,
                color: Colors.black
                    .withOpacity(
                  .55,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}