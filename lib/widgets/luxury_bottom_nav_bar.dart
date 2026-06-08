import 'package:flutter/material.dart';

import 'app_drawer_sheet.dart';

class LuxuryBottomNavBar
    extends StatelessWidget {

  final int currentIndex;

  final Function(int)
      onTap;

  const LuxuryBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  void openAppDrawer(
    BuildContext context,
  ) {

    showModalBottomSheet(
      context: context,

      backgroundColor:
          Colors.transparent,

      isScrollControlled: true,

      builder: (_) {
        return const AppDrawerSheet();
      },
    );
  }

  @override
  Widget build(BuildContext context) {

    return Container(
      margin:
          const EdgeInsets.only(
        left: 20,
        right: 20,
        bottom: 18,
      ),

      padding:
          const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 10,
      ),

      decoration: BoxDecoration(
        borderRadius:
            BorderRadius.circular(
          28,
        ),

        color:
            Colors.white
                .withOpacity(
          .08,
        ),

        border: Border.all(
          color:
              Colors.white
                  .withOpacity(
            .08,
          ),
        ),
      ),

      child: Row(
        mainAxisAlignment:
            MainAxisAlignment
                .spaceBetween,

        children: [

          _navItem(
            index: 0,
            icon:
                Icons.home_filled,
          ),

          _navItem(
            index: 1,
            icon:
                Icons.layers_outlined,
          ),

          _centerButton(
            context,
          ),

          _navItem(
            index: 3,
            icon:
                Icons.favorite_border,
          ),

          _navItem(
            index: 4,
            icon:
                Icons.person_outline,
          ),
        ],
      ),
    );
  }

  Widget _navItem({
    required int index,
    required IconData icon,
  }) {

    final bool active =
        currentIndex == index;

    return GestureDetector(
      onTap: () {

        onTap(index);
      },

      child: AnimatedContainer(
        duration:
            const Duration(
          milliseconds: 220,
        ),

        height: 52,
        width: 52,

        decoration: BoxDecoration(
          shape: BoxShape.circle,

          color:
              active
                  ? Colors.white
                      .withOpacity(
                    .12,
                  )
                  : Colors.transparent,
        ),

        child: Icon(
          icon,

          color:
              active
                  ? Colors.white
                  : Colors.white54,
        ),
      ),
    );
  }

  Widget _centerButton(
    BuildContext context,
  ) {

    return GestureDetector(
      onTap: () {

        openAppDrawer(
          context,
        );
      },

      child: Container(
        height: 62,
        width: 62,

        decoration: BoxDecoration(
          shape: BoxShape.circle,

          gradient: LinearGradient(
            colors: [

              Colors.white
                  .withOpacity(
                .18,
              ),

              Colors.white
                  .withOpacity(
                .05,
              ),
            ],
          ),

          border: Border.all(
            color:
                Colors.white
                    .withOpacity(
              .12,
            ),
          ),
        ),

        child: const Icon(
          Icons.grid_view_rounded,
          color: Colors.white,
        ),
      ),
    );
  }
}