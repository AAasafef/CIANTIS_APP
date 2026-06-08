import 'package:flutter/material.dart';

class QuickActionPill
    extends StatelessWidget {

  final IconData icon;

  final String text;

  final VoidCallback onTap;

  const QuickActionPill({
    super.key,
    required this.icon,
    required this.text,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,

      child: Container(
        padding:
            const EdgeInsets.symmetric(
          horizontal: 18,
          vertical: 14,
        ),

        decoration: BoxDecoration(
          borderRadius:
              BorderRadius.circular(
            22,
          ),

          color:
              Colors.white
                  .withOpacity(
            .07,
          ),

          border: Border.all(
            color:
                Colors.white
                    .withOpacity(
              .05,
            ),
          ),
        ),

        child: Row(
          mainAxisSize:
              MainAxisSize.min,

          children: [

            Icon(
              icon,
              color: Colors.white,
              size: 18,
            ),

            const SizedBox(width: 10),

            Text(
              text,

              style: const TextStyle(
                color: Colors.white,
                fontSize: 13,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
