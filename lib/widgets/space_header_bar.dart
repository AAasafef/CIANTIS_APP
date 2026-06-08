import 'package:flutter/material.dart';

class SpaceHeaderBar
    extends StatelessWidget {

  final String title;

  final VoidCallback onMenuTap;

  final VoidCallback onSettingsTap;

  const SpaceHeaderBar({
    super.key,
    required this.title,
    required this.onMenuTap,
    required this.onSettingsTap,
  });

  @override
  Widget build(BuildContext context) {

    return Row(
      children: [

        GestureDetector(
          onTap: onMenuTap,

          child: Container(
            height: 48,
            width: 48,

            decoration:
                BoxDecoration(
              color:
                  Colors.white
                      .withOpacity(
                .08,
              ),

              borderRadius:
                  BorderRadius.circular(
                18,
              ),
            ),

            child: const Icon(
              Icons.menu,
              color: Colors.white,
            ),
          ),
        ),

        const SizedBox(
          width: 16,
        ),

        Expanded(
          child: Text(
            title,

            style: const TextStyle(
              color: Colors.white,

              fontSize: 32,

              fontWeight:
                  FontWeight.w300,

              letterSpacing: -.8,
            ),
          ),
        ),

        GestureDetector(
          onTap: onSettingsTap,

          child: Container(
            height: 48,
            width: 48,

            decoration:
                BoxDecoration(
              color:
                  Colors.white
                      .withOpacity(
                .08,
              ),

              borderRadius:
                  BorderRadius.circular(
                18,
              ),
            ),

            child: const Icon(
              Icons.settings_outlined,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}