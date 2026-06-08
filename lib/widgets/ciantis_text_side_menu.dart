import 'package:flutter/material.dart';

import '../screens/dashboard/dashboard_screen.dart';

class CiantisTextSideMenu extends StatefulWidget {
  final String title;
  final String subtitle;
  final Map<String, List<String>> drawerTabs;
  final String selectedCategory;
  final String selectedSubCategory;
  final Function(String category) onMainTabSelected;
  final Function(String category, String subCategory)
      onSubTabSelected;
  final bool showHomeShortcut;

  const CiantisTextSideMenu({
    super.key,
    required this.title,
    required this.subtitle,
    required this.drawerTabs,
    required this.selectedCategory,
    required this.selectedSubCategory,
    required this.onMainTabSelected,
    required this.onSubTabSelected,
    this.showHomeShortcut = true,
  });

  @override
  State<CiantisTextSideMenu> createState() =>
      _CiantisTextSideMenuState();
}

class _CiantisTextSideMenuState
    extends State<CiantisTextSideMenu> {
  final Set<String> expandedDrawerTabs = {};

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: MediaQuery.of(context).size.width * .78,
      backgroundColor:
          const Color(0xFF5B5149).withOpacity(.97),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(
            28,
            34,
            24,
            24,
          ),
          child: Column(
            children: [
              Expanded(
                child: ListView(
                  physics: const BouncingScrollPhysics(),
                  children: [
                    Text(
                      widget.title,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 42,
                        fontWeight: FontWeight.w300,
                        letterSpacing: -1,
                      ),
                    ),

                    const SizedBox(height: 8),

                    Text(
                      widget.subtitle,
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 12,
                        letterSpacing: 4,
                      ),
                    ),

                    const SizedBox(height: 28),

                    Container(
                      height: 1,
                      color: Colors.white.withOpacity(.16),
                    ),

                    const SizedBox(height: 26),

                    ...widget.drawerTabs.entries.map(
                      (entry) {
                        final title = entry.key;
                        final children = entry.value;

                        if (children.isEmpty) {
                          return _drawerMainTab(title);
                        }

                        return _drawerExpandableTab(
                          title: title,
                          children: children,
                        );
                      },
                    ),
                  ],
                ),
              ),

              if (widget.showHomeShortcut)
                Align(
                  alignment: Alignment.bottomLeft,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (_) =>
                              const DashboardScreen(),
                        ),
                        (route) => false,
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(
                        top: 14,
                        left: 2,
                      ),
                      child: Icon(
                        Icons.home_outlined,
                        size: 22,
                        color: Colors.white.withOpacity(.42),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _drawerMainTab(String title) {
    final isSelected =
        widget.selectedCategory == title;

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        Navigator.pop(context);
        widget.onMainTabSelected(title);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 13,
        ),
        child: Row(
          children: [
            AnimatedContainer(
              duration: const Duration(
                milliseconds: 180,
              ),
              height: 22,
              width: 3,
              decoration: BoxDecoration(
                color: isSelected
                    ? const Color(0xFFE7D6C8)
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(12),
              ),
            ),

            const SizedBox(width: 14),

            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  color: isSelected
                      ? Colors.white
                      : Colors.white.withOpacity(.78),
                  fontSize: 21,
                  fontWeight: isSelected
                      ? FontWeight.w400
                      : FontWeight.w300,
                  height: 1.25,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _drawerExpandableTab({
    required String title,
    required List<String> children,
  }) {
    final isSelected =
        widget.selectedCategory == title;

    final isExpanded =
        expandedDrawerTabs.contains(title);

    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () {
              setState(() {
                if (isExpanded) {
                  expandedDrawerTabs.remove(title);
                } else {
                  expandedDrawerTabs.add(title);
                }
              });

              widget.onMainTabSelected(title);
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 13,
              ),
              child: Row(
                children: [
                  AnimatedContainer(
                    duration: const Duration(
                      milliseconds: 180,
                    ),
                    height: 22,
                    width: 3,
                    decoration: BoxDecoration(
                      color: isSelected
                          ? const Color(0xFFE7D6C8)
                          : Colors.transparent,
                      borderRadius:
                          BorderRadius.circular(12),
                    ),
                  ),

                  const SizedBox(width: 14),

                  Expanded(
                    child: Text(
                      title,
                      style: TextStyle(
                        color: isSelected
                            ? Colors.white
                            : Colors.white
                                .withOpacity(.78),
                        fontSize: 21,
                        fontWeight: isSelected
                            ? FontWeight.w400
                            : FontWeight.w300,
                        height: 1.25,
                      ),
                    ),
                  ),

                  AnimatedRotation(
                    turns: isExpanded ? .5 : 0,
                    duration: const Duration(
                      milliseconds: 180,
                    ),
                    child: Icon(
                      Icons.keyboard_arrow_down_rounded,
                      color:
                          Colors.white.withOpacity(.78),
                      size: 26,
                    ),
                  ),
                ],
              ),
            ),
          ),

          AnimatedCrossFade(
            firstChild: const SizedBox.shrink(),
            secondChild: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                _drawerSubTab(
                  'All',
                  parentTitle: title,
                ),

                ...children.map(
                  (sub) {
                    return _drawerSubTab(
                      sub,
                      parentTitle: title,
                    );
                  },
                ),

                const SizedBox(height: 8),
              ],
            ),
            crossFadeState: isExpanded
                ? CrossFadeState.showSecond
                : CrossFadeState.showFirst,
            duration: const Duration(
              milliseconds: 180,
            ),
          ),
        ],
      ),
    );
  }

  Widget _drawerSubTab(
    String title, {
    required String parentTitle,
  }) {
    final isSelected =
        widget.selectedCategory == parentTitle &&
            widget.selectedSubCategory == title;

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        Navigator.pop(context);
        widget.onSubTabSelected(parentTitle, title);
      },
      child: Padding(
        padding: const EdgeInsets.fromLTRB(
          34,
          8,
          0,
          8,
        ),
        child: Row(
          children: [
            AnimatedContainer(
              duration: const Duration(
                milliseconds: 180,
              ),
              height: 6,
              width: 6,
              decoration: BoxDecoration(
                color: isSelected
                    ? const Color(0xFFE7D6C8)
                    : Colors.white.withOpacity(.32),
                shape: BoxShape.circle,
              ),
            ),

            const SizedBox(width: 14),

            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  color: isSelected
                      ? Colors.white
                      : Colors.white.withOpacity(.62),
                  fontSize: 16,
                  fontWeight: isSelected
                      ? FontWeight.w400
                      : FontWeight.w300,
                  height: 1.3,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}