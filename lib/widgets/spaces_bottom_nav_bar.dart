import 'package:flutter/material.dart';

class SpacesBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const SpacesBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(24, 0, 24, 18),
        child: Container(
          height: 78,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(30),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(.05),
                blurRadius: 20,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _item(
                index: 0,
                icon: Icons.grid_view_rounded,
                label: 'Spaces',
              ),
              _item(
                index: 1,
                icon: Icons.calendar_month_outlined,
                label: 'Calendar',
              ),
              _centerItem(),
              _item(
                index: 3,
                icon: Icons.mic_none_rounded,
                label: 'AI',
              ),
              _item(
                index: 4,
                icon: Icons.settings_outlined,
                label: 'Settings',
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _centerItem() {
    return GestureDetector(
      onTap: () {
        onTap(2);
      },
      child: Container(
        height: 58,
        width: 58,
        decoration: BoxDecoration(
          color: const Color(0xFF2D241D),
          borderRadius: BorderRadius.circular(24),
        ),
        child: const Icon(
          Icons.apps_rounded,
          color: Colors.white,
          size: 30,
        ),
      ),
    );
  }

  Widget _item({
    required int index,
    required IconData icon,
    required String label,
  }) {
    final selected = currentIndex == index;

    return GestureDetector(
      onTap: () {
        onTap(index);
      },
      child: SizedBox(
        width: 54,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: selected
                  ? const Color(0xFF2D241D)
                  : const Color(0xFF6E5846),
              size: 25,
            ),
            const SizedBox(height: 4),
            Text(
              label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: selected
                    ? const Color(0xFF2D241D)
                    : const Color(0xFF6E5846),
                fontSize: 10,
                fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}