import 'package:flutter/material.dart';

import '../theme/ciantis_theme.dart';

import 'bottom_nav_bar.dart';
import 'luxury_app_bar_spacing.dart';
import 'side_menu.dart';
import 'top_bar.dart';

class CiantisScreenShell extends StatefulWidget {
  final Widget child;

  const CiantisScreenShell({
    super.key,
    required this.child,
  });

  @override
  State<CiantisScreenShell> createState() =>
      _CiantisScreenShellState();
}

class _CiantisScreenShellState
    extends State<CiantisScreenShell> {

  final GlobalKey<ScaffoldState>
      scaffoldKey =
      GlobalKey<ScaffoldState>();

  bool showGridMenu = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,

      drawer: const SideMenu(),

      body: Stack(
        children: [

          // BACKGROUND
          Container(
            decoration: const BoxDecoration(
              gradient:
                  CiantisTheme.mainGradient,
            ),
          ),

          // OVERLAY
          Container(
            color: Colors.black.withOpacity(
              CiantisTheme.overlayOpacity,
            ),
          ),

          SafeArea(
            child: Column(
              children: [

                // TOP BAR
                TopBar(
                  showGridMenu:
                      showGridMenu,

                  onMenuPressed: () {
                    scaffoldKey
                        .currentState
                        ?.openDrawer();
                  },

                  onGridPressed: () {
                    setState(() {
                      showGridMenu =
                          !showGridMenu;
                    });
                  },
                ),

                const LuxuryAppBarSpacing(),

                // PAGE CONTENT
                Expanded(
                  child: widget.child,
                ),
              ],
            ),
          ),

          // BOTTOM BAR
          BottomNavBar(
            showGridMenu:
                showGridMenu,

            onMenuPressed: () {
              setState(() {
                showGridMenu =
                    !showGridMenu;
              });
            },
          ),
        ],
      ),
    );
  }
}
