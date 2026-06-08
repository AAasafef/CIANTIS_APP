import 'package:flutter/material.dart';

class SideMenuTile
    extends StatelessWidget {

  final IconData icon;

  final String title;

  final bool active;

  final VoidCallback onTap;

  const SideMenuTile({
    super.key,
    required this.icon,
    required this.title,
    required this.onTap,
    this.active = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,

      child: AnimatedContainer(
        duration:
            const Duration(
          milliseconds: 220,
        ),

        margin:
            const EdgeInsets.only(
          bottom: 10,
        ),

        padding:
            const EdgeInsets.symmetric(
          horizontal: 18,
          vertical: 16,
        ),

        decoration: BoxDecoration(
          borderRadius:
              BorderRadius.circular(
            22,
          ),

          color:
              active
                  ? Colors.white
                      .withOpacity(
                    .10,
                  )
                  : Colors.transparent,
        ),

        child: Row(
          children: [

            Icon(
              icon,

              color:
                  active
                      ? Colors.white
                      : Colors.white70,

              size: 22,
            ),

            const SizedBox(width: 16),

            Expanded(
              child: Text(
                title,

                style: TextStyle(
                  color:
                      active
                          ? Colors.white
                          : Colors.white70,

                  fontSize: 15,
                  fontWeight:
                      FontWeight.w400,
                ),
              ),
            ),

            if (active)
              Container(
                height: 8,
                width: 8,

                decoration:
                    const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
