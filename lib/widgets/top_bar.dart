import 'package:flutter/material.dart';

import '../theme/ciantis_theme.dart';

class TopBar extends StatelessWidget {
  final bool showGridMenu;

  final VoidCallback onMenuPressed;
  final VoidCallback onGridPressed;

  const TopBar({
    super.key,
    required this.showGridMenu,
    required this.onMenuPressed,
    required this.onGridPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: CiantisTheme.pagePadding,
        vertical: 10,
      ),
      child: Row(
        mainAxisAlignment:
            MainAxisAlignment.spaceBetween,
        children: [

          // SIDE MENU BUTTON
          GestureDetector(
            onTap: onMenuPressed,
            child: const Icon(
              Icons.menu_rounded,
              color: CiantisTheme.white,
              size: 28,
            ),
          ),

          // TITLE
          const Text(
            'the life',
            style: TextStyle(
              color: CiantisTheme.white,
              fontSize:
                  CiantisTheme.appTitleSize,
              fontWeight: FontWeight.w300,
              letterSpacing: 1,
            ),
          ),

          // GRID BUTTON
          GestureDetector(
            onTap: onGridPressed,
            child: Icon(
              showGridMenu
                  ? Icons.close_rounded
                  : Icons.apps_rounded,
              color: CiantisTheme.white,
              size: 28,
            ),
          ),
        ],
      ),
    );
  }
}
