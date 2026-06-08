import 'package:flutter/material.dart';

import '../../widgets/grid_menu.dart';
import '../../widgets/spaces_bottom_nav_bar.dart';

import '../calendar/calendar_screen.dart';
import '../settings/settings_screen.dart';
import '../shared/coming_soon_screen.dart';
import '../spaces/spaces_screen.dart';

class BeautySpaceScreen extends StatefulWidget {
  const BeautySpaceScreen({
    super.key,
  });

  @override
  State<BeautySpaceScreen> createState() =>
      _BeautySpaceScreenState();
}

class _BeautySpaceScreenState
    extends State<BeautySpaceScreen> {
  final ScrollController scrollController =
      ScrollController();

  bool showBottomNav = true;

  int homeBackgroundIndex = 0;
  int menuBackgroundIndex = 1;

  final List<String> beautyBackgrounds = const [
    'assets/images/spaces/beauty.jpg',
    'assets/images/spaces/home.jpg',
    'assets/images/spaces/library.jpg',
    'assets/images/spaces/spiritual.jpg',
    'assets/images/spaces/health.jpg',
    'assets/images/spaces/business.jpg',
    'assets/images/spaces/travel.jpg',
    'assets/images/spaces/documents.jpg',
    'assets/images/spaces/school.jpg',
    'assets/images/spaces/kids.jpg',
    'assets/images/spaces/reserve.jpg',
    'assets/images/spaces/finance.jpg',
    'assets/images/spaces/career.jpg',
    'assets/images/spaces/projects.jpg',
  ];

  @override
  void initState() {
    super.initState();

    scrollController.addListener(() {
      final direction =
          scrollController.position.userScrollDirection;

      if (direction.toString().contains('reverse') &&
          showBottomNav) {
        setState(() {
          showBottomNav = false;
        });
      }

      if (direction.toString().contains('forward') &&
          !showBottomNav) {
        setState(() {
          showBottomNav = true;
        });
      }
    });
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  void _openGridMenu() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (_) {
        return const GridMenu();
      },
    );
  }

  void _openScreen(Widget screen) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => screen,
      ),
    );
  }

  void _handleBottomNavTap(int index) {
    if (index == 0) {
      _openScreen(
        const SpacesScreen(),
      );
      return;
    }

    if (index == 1) {
      _openScreen(
        const CalendarScreen(),
      );
      return;
    }

    if (index == 2) {
      _openGridMenu();
      return;
    }

    if (index == 3) {
      _openScreen(
        const ComingSoonScreen(
          title: 'AI',
          subtitle:
              'Your assistant for beauty planning, routines, reminders, product tracking, and style notes will connect here.',
          icon: Icons.auto_awesome_rounded,
        ),
      );
      return;
    }

    if (index == 4) {
      _openScreen(
        const SettingsScreen(),
      );
    }
  }

  void _openComingSoon(
    String title,
    String subtitle,
    IconData icon,
  ) {
    _openScreen(
      ComingSoonScreen(
        title: title,
        subtitle: subtitle,
        icon: icon,
      ),
    );
  }

  void _openThemeChooser() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (_) {
        return _ThemeTargetSheet(
          onHomeTap: () {
            Navigator.pop(context);
            _openBackgroundPicker(
              title: 'Beauty Home Background',
              currentIndex: homeBackgroundIndex,
              onSelected: (index) {
                setState(() {
                  homeBackgroundIndex = index;
                });
              },
            );
          },
          onMenuTap: () {
            Navigator.pop(context);
            _openBackgroundPicker(
              title: 'Side Menu Background',
              currentIndex: menuBackgroundIndex,
              onSelected: (index) {
                setState(() {
                  menuBackgroundIndex = index;
                });
              },
            );
          },
        );
      },
    );
  }

  void _openBackgroundPicker({
    required String title,
    required int currentIndex,
    required ValueChanged<int> onSelected,
  }) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (_) {
        return _BackgroundPickerSheet(
          title: title,
          backgrounds: beautyBackgrounds,
          currentIndex: currentIndex,
          onSelected: onSelected,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final homeBackground =
        beautyBackgrounds[homeBackgroundIndex];

    final menuBackground =
        beautyBackgrounds[menuBackgroundIndex];

    return Scaffold(
      backgroundColor: const Color(0xFFF4EFE8),
      drawer: _BeautySideDrawer(
        backgroundPath: menuBackground,
        onOpen: _openComingSoon,
        onThemeTap: _openThemeChooser,
      ),
      extendBody: true,

      bottomNavigationBar: AnimatedSlide(
        duration: const Duration(milliseconds: 260),
        curve: Curves.easeOutCubic,
        offset:
            showBottomNav ? Offset.zero : const Offset(0, 1.25),
        child: AnimatedOpacity(
          duration: const Duration(milliseconds: 220),
          opacity: showBottomNav ? 1 : 0,
          child: SpacesBottomNavBar(
            currentIndex: 0,
            onTap: _handleBottomNavTap,
          ),
        ),
      ),

      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              homeBackground,
              fit: BoxFit.cover,
              errorBuilder: (
                context,
                error,
                stackTrace,
              ) {
                return Container(
                  color: const Color(0xFFF4EFE8),
                );
              },
            ),
          ),
          Positioned.fill(
            child: Container(
              color: const Color(0xFFF4EFE8)
                  .withOpacity(.84),
            ),
          ),
          SafeArea(
            child: SingleChildScrollView(
              controller: scrollController,
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.fromLTRB(
                24,
                24,
                24,
                128,
              ),
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment:
                        CrossAxisAlignment.start,
                    children: [
                      const Expanded(
                        child: Column(
                          crossAxisAlignment:
                              CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Beauty',
                              style: TextStyle(
                                fontSize: 48,
                                height: .95,
                                fontWeight: FontWeight.w300,
                                letterSpacing: -1.6,
                                color: Color(0xFF241D18),
                              ),
                            ),
                            SizedBox(height: 10),
                            Text(
                              'APPEARANCE SPACE',
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w300,
                                letterSpacing: 3.2,
                                color: Color(0xFF8B7D72),
                              ),
                            ),
                          ],
                        ),
                      ),
                      _TopIconButton(
                        icon: Icons.search_rounded,
                        onTap: () {
                          _openComingSoon(
                            'Beauty Search',
                            'Search hair notes, skin routines, product lists, outfits, fragrance notes, and beauty photos here.',
                            Icons.search_rounded,
                          );
                        },
                      ),
                    ],
                  ),

                  const SizedBox(height: 28),

                  _HeroBeautyCard(
                    onTap: () {
                      _openComingSoon(
                        'Today’s Beauty Plan',
                        'Your hair, skin, nails, outfit, fragrance, and beauty prep for the day will appear here.',
                        Icons.spa_outlined,
                      );
                    },
                  ),

                  const SizedBox(height: 22),

                  const Text(
                    'Beauty Focus',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w300,
                      letterSpacing: -.4,
                      color: Color(0xFF241D18),
                    ),
                  ),

                  const SizedBox(height: 14),

                  Row(
                    children: [
                      Expanded(
                        child: _MetricCard(
                          label: 'Hair',
                          value: '0',
                          subtitle: 'Updates',
                          icon: Icons.water_drop_outlined,
                          onTap: () {
                            _openComingSoon(
                              'Hair Journal',
                              'Track wash days, growth, trims, color, extensions, treatments, photos, and product reactions.',
                              Icons.water_drop_outlined,
                            );
                          },
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _MetricCard(
                          label: 'Skin',
                          value: '0',
                          subtitle: 'Notes',
                          icon: Icons.face_retouching_natural_outlined,
                          onTap: () {
                            _openComingSoon(
                              'Skin Care',
                              'Track routines, products, breakouts, sensitivity, glow progress, facials, and photos.',
                              Icons.face_retouching_natural_outlined,
                            );
                          },
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _MetricCard(
                          label: 'Nails',
                          value: '0',
                          subtitle: 'Sets',
                          icon: Icons.back_hand_outlined,
                          onTap: () {
                            _openComingSoon(
                              'Nail Care',
                              'Track manicures, pedicures, nail health, Gel-X sets, inspo, and maintenance.',
                              Icons.back_hand_outlined,
                            );
                          },
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 22),

                  _InsightCard(
                    title: 'Health Sync',
                    subtitle:
                        'Weight, water, sleep, steps, and nutrition stay owned by Health, but beauty can use the glow-up insights.',
                    icon: Icons.sync_alt_rounded,
                    imagePath: 'assets/images/spaces/health.jpg',
                    onTap: () {
                      _openComingSoon(
                        'Health Sync',
                        'Beauty will display shared insights from Health without taking over medical or wellness tracking.',
                        Icons.sync_alt_rounded,
                      );
                    },
                  ),

                  const SizedBox(height: 14),

                  _SimpleCard(
                    title: 'Hair',
                    subtitle:
                        'Growth, wash day, trims, color, products, extensions, silk press, and photos.',
                    icon: Icons.auto_fix_high_outlined,
                    onTap: () {
                      _openComingSoon(
                        'Hair',
                        'Your full hair journal and maintenance planner will live here.',
                        Icons.auto_fix_high_outlined,
                      );
                    },
                  ),

                  const SizedBox(height: 14),

                  _SimpleCard(
                    title: 'Skin',
                    subtitle:
                        'Morning routine, night routine, products, facials, acne, sensitivity, and photos.',
                    icon: Icons.face_retouching_natural_outlined,
                    onTap: () {
                      _openComingSoon(
                        'Skin',
                        'Your skin care routine, product tracker, and progress photos will live here.',
                        Icons.face_retouching_natural_outlined,
                      );
                    },
                  ),

                  const SizedBox(height: 14),

                  _SimpleCard(
                    title: 'Nails',
                    subtitle:
                        'Manicure history, pedicure care, nail health, inspo, shape, length, and color notes.',
                    icon: Icons.back_hand_outlined,
                    onTap: () {
                      _openComingSoon(
                        'Nails',
                        'Your manicure, pedicure, and nail health tracker will live here.',
                        Icons.back_hand_outlined,
                      );
                    },
                  ),

                  const SizedBox(height: 14),

                  _SimpleCard(
                    title: 'Makeup',
                    subtitle:
                        'Favorite looks, tutorials, products, expiration dates, shades, and glam notes.',
                    icon: Icons.brush_outlined,
                    onTap: () {
                      _openComingSoon(
                        'Makeup',
                        'Your makeup inventory, looks, shades, and tutorials will live here.',
                        Icons.brush_outlined,
                      );
                    },
                  ),

                  const SizedBox(height: 14),

                  _SimpleCard(
                    title: 'Fashion',
                    subtitle:
                        'Closet, outfit planner, sizes, wishlist, capsule wardrobe, and style photos.',
                    icon: Icons.checkroom_outlined,
                    onTap: () {
                      _openComingSoon(
                        'Fashion',
                        'Your closet, outfit planner, wishlist, and style gallery will live here.',
                        Icons.checkroom_outlined,
                      );
                    },
                  ),

                  const SizedBox(height: 14),

                  _SimpleCard(
                    title: 'Fragrance',
                    subtitle:
                        'Perfume collection, layering combos, moods, occasions, favorites, and wishlist.',
                    icon: Icons.local_florist_outlined,
                    onTap: () {
                      _openComingSoon(
                        'Fragrance',
                        'Your perfume collection, layering notes, and signature scent planner will live here.',
                        Icons.local_florist_outlined,
                      );
                    },
                  ),

                  const SizedBox(height: 14),

                  _SimpleCard(
                    title: 'Progress Photos',
                    subtitle:
                        'Hair, skin, nails, style, teeth, body confidence, and beauty transformation photos.',
                    icon: Icons.photo_camera_outlined,
                    onTap: () {
                      _openComingSoon(
                        'Progress Photos',
                        'Beauty progress photos will stay focused on appearance. Weight-loss tracking stays in Health.',
                        Icons.photo_camera_outlined,
                      );
                    },
                  ),

                  const SizedBox(height: 14),

                  _SimpleCard(
                    title: 'Beauty Library',
                    subtitle:
                        'Saved tutorials, inspiration, product reviews, routines, beauty books, and certificates.',
                    icon: Icons.collections_bookmark_outlined,
                    onTap: () {
                      _openComingSoon(
                        'Beauty Library',
                        'Your saved beauty education, tutorials, reviews, and inspiration will live here.',
                        Icons.collections_bookmark_outlined,
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _BeautySideDrawer extends StatelessWidget {
  final String backgroundPath;
  final VoidCallback onThemeTap;

  final void Function(
    String title,
    String subtitle,
    IconData icon,
  ) onOpen;

  const _BeautySideDrawer({
    required this.backgroundPath,
    required this.onOpen,
    required this.onThemeTap,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: const Color(0xFFF4EFE8),
      width: MediaQuery.of(context).size.width * .78,
      child: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              backgroundPath,
              fit: BoxFit.cover,
              errorBuilder: (
                context,
                error,
                stackTrace,
              ) {
                return Container(
                  color: const Color(0xFFF4EFE8),
                );
              },
            ),
          ),
          Positioned.fill(
            child: Container(
              color: const Color(0xFFF4EFE8)
                  .withOpacity(.86),
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(
                22,
                24,
                22,
                24,
              ),
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Beauty',
                    style: TextStyle(
                      fontSize: 38,
                      height: .95,
                      fontWeight: FontWeight.w300,
                      letterSpacing: -1.1,
                      color: Color(0xFF241D18),
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'SPACE MENU',
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w300,
                      letterSpacing: 3,
                      color: Color(0xFF8B7D72),
                    ),
                  ),

                  const SizedBox(height: 32),

                  Expanded(
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Column(
                        children: [
                          _DrawerSectionTitle(
                            title: 'Main',
                          ),
                          _DrawerItem(
                            title: 'Dashboard',
                            subtitle: 'Beauty home',
                            icon: Icons.grid_view_rounded,
                            onTap: () {
                              Navigator.pop(context);
                            },
                          ),
                          _DrawerItem(
                            title: 'Today’s Beauty Plan',
                            subtitle: 'Prep and reminders',
                            icon: Icons.spa_outlined,
                            onTap: () {
                              Navigator.pop(context);
                              onOpen(
                                'Today’s Beauty Plan',
                                'Your daily beauty prep, routines, and reminders will live here.',
                                Icons.spa_outlined,
                              );
                            },
                          ),
                          _DrawerItem(
                            title: 'Progress Photos',
                            subtitle: 'Appearance timeline',
                            icon: Icons.photo_camera_outlined,
                            onTap: () {
                              Navigator.pop(context);
                              onOpen(
                                'Progress Photos',
                                'Track beauty progress photos without mixing up Health data.',
                                Icons.photo_camera_outlined,
                              );
                            },
                          ),

                          const SizedBox(height: 20),

                          _DrawerSectionTitle(
                            title: 'Beauty Areas',
                          ),
                          _DrawerItem(
                            title: 'Hair',
                            subtitle: 'Growth, wash, color',
                            icon: Icons.auto_fix_high_outlined,
                            onTap: () {
                              Navigator.pop(context);
                              onOpen(
                                'Hair',
                                'Hair growth, wash days, trims, treatments, color, extensions, and photos.',
                                Icons.auto_fix_high_outlined,
                              );
                            },
                          ),
                          _DrawerItem(
                            title: 'Skin',
                            subtitle: 'Routine and glow',
                            icon: Icons.face_retouching_natural_outlined,
                            onTap: () {
                              Navigator.pop(context);
                              onOpen(
                                'Skin',
                                'Skin care routines, products, facials, breakouts, sensitivity, and progress.',
                                Icons.face_retouching_natural_outlined,
                              );
                            },
                          ),
                          _DrawerItem(
                            title: 'Nails',
                            subtitle: 'Hands and feet',
                            icon: Icons.back_hand_outlined,
                            onTap: () {
                              Navigator.pop(context);
                              onOpen(
                                'Nails',
                                'Manicures, pedicures, nail health, nail inspo, and maintenance.',
                                Icons.back_hand_outlined,
                              );
                            },
                          ),
                          _DrawerItem(
                            title: 'Makeup',
                            subtitle: 'Looks and products',
                            icon: Icons.brush_outlined,
                            onTap: () {
                              Navigator.pop(context);
                              onOpen(
                                'Makeup',
                                'Makeup products, looks, tutorials, shades, and expiration tracking.',
                                Icons.brush_outlined,
                              );
                            },
                          ),
                          _DrawerItem(
                            title: 'Fashion',
                            subtitle: 'Closet and outfits',
                            icon: Icons.checkroom_outlined,
                            onTap: () {
                              Navigator.pop(context);
                              onOpen(
                                'Fashion',
                                'Closet inventory, outfit planning, sizes, wishlist, and style notes.',
                                Icons.checkroom_outlined,
                              );
                            },
                          ),
                          _DrawerItem(
                            title: 'Fragrance',
                            subtitle: 'Scents and layering',
                            icon: Icons.local_florist_outlined,
                            onTap: () {
                              Navigator.pop(context);
                              onOpen(
                                'Fragrance',
                                'Perfume collection, layering notes, signature scents, and wishlist.',
                                Icons.local_florist_outlined,
                              );
                            },
                          ),

                          const SizedBox(height: 20),

                          _DrawerSectionTitle(
                            title: 'Shared With Health',
                          ),
                          _DrawerItem(
                            title: 'Health Sync',
                            subtitle: 'View only',
                            icon: Icons.sync_alt_rounded,
                            onTap: () {
                              Navigator.pop(context);
                              onOpen(
                                'Health Sync',
                                'Beauty can view weight, water, sleep, steps, and nutrition insights, but Health owns the tracking.',
                                Icons.sync_alt_rounded,
                              );
                            },
                          ),
                          _DrawerItem(
                            title: 'Measurements',
                            subtitle: 'Clothing fit notes',
                            icon: Icons.straighten_outlined,
                            onTap: () {
                              Navigator.pop(context);
                              onOpen(
                                'Measurements',
                                'Measurements here focus on clothing fit and appearance. Health keeps medical/body tracking.',
                                Icons.straighten_outlined,
                              );
                            },
                          ),

                          const SizedBox(height: 20),

                          _DrawerSectionTitle(
                            title: 'Tools',
                          ),
                          _DrawerItem(
                            title: 'Product Inventory',
                            subtitle: 'Beauty products',
                            icon: Icons.inventory_2_outlined,
                            onTap: () {
                              Navigator.pop(context);
                              onOpen(
                                'Product Inventory',
                                'Track hair, skin, nail, makeup, fragrance, and beauty tools here.',
                                Icons.inventory_2_outlined,
                              );
                            },
                          ),
                          _DrawerItem(
                            title: 'Beauty Library',
                            subtitle: 'Saved inspiration',
                            icon: Icons.collections_bookmark_outlined,
                            onTap: () {
                              Navigator.pop(context);
                              onOpen(
                                'Beauty Library',
                                'Saved tutorials, routines, inspiration, product reviews, and beauty education.',
                                Icons.collections_bookmark_outlined,
                              );
                            },
                          ),
                          _DrawerItem(
                            title: 'Settings',
                            subtitle: 'Beauty preferences',
                            icon: Icons.settings_outlined,
                            onTap: () {
                              Navigator.pop(context);
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) =>
                                      const SettingsScreen(),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 14),

                  Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Container(
                          height: 48,
                          width: 48,
                          decoration: BoxDecoration(
                            color: const Color(0xFF241D18),
                            borderRadius:
                                BorderRadius.circular(16),
                          ),
                          child: const Icon(
                            Icons.home_rounded,
                            color: Color(0xFFF8F4EE),
                            size: 22,
                          ),
                        ),
                      ),
                      const Spacer(),
                      GestureDetector(
                        onTap: onThemeTap,
                        child: Container(
                          height: 48,
                          width: 48,
                          decoration: BoxDecoration(
                            color: const Color(0xFFFBF8F4)
                                .withOpacity(.94),
                            borderRadius:
                                BorderRadius.circular(16),
                            border: Border.all(
                              color: const Color(0xFFE1D6CA),
                              width: .7,
                            ),
                          ),
                          child: const Icon(
                            Icons.wallpaper_rounded,
                            color: Color(0xFF241D18),
                            size: 22,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ThemeTargetSheet extends StatelessWidget {
  final VoidCallback onHomeTap;
  final VoidCallback onMenuTap;

  const _ThemeTargetSheet({
    required this.onHomeTap,
    required this.onMenuTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(
        22,
        18,
        22,
        34,
      ),
      decoration: const BoxDecoration(
        color: Color(0xFFF6F1EA),
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(28),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment:
            CrossAxisAlignment.start,
        children: [
          const Text(
            'Change Background',
            style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.w300,
              color: Color(0xFF241D18),
              letterSpacing: -.5,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Choose what you want to change. Home and menu stay separate.',
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w300,
              color: Color(0xFF6F6258),
              height: 1.4,
            ),
          ),
          const SizedBox(height: 20),
          _SheetOption(
            title: 'Beauty Home Background',
            subtitle: 'Changes only the main Beauty dashboard.',
            icon: Icons.home_outlined,
            onTap: onHomeTap,
          ),
          const SizedBox(height: 12),
          _SheetOption(
            title: 'Side Menu Background',
            subtitle: 'Changes only the swipe menu.',
            icon: Icons.menu_open_rounded,
            onTap: onMenuTap,
          ),
        ],
      ),
    );
  }
}

class _BackgroundPickerSheet extends StatefulWidget {
  final String title;
  final List<String> backgrounds;
  final int currentIndex;
  final ValueChanged<int> onSelected;

  const _BackgroundPickerSheet({
    required this.title,
    required this.backgrounds,
    required this.currentIndex,
    required this.onSelected,
  });

  @override
  State<_BackgroundPickerSheet> createState() =>
      _BackgroundPickerSheetState();
}

class _BackgroundPickerSheetState
    extends State<_BackgroundPickerSheet> {
  late int selectedIndex;
  late PageController pageController;

  @override
  void initState() {
    super.initState();

    selectedIndex = widget.currentIndex;

    pageController = PageController(
      initialPage: selectedIndex,
      viewportFraction: .72,
    );
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  void _select(int index) {
    setState(() {
      selectedIndex = index;
    });

    widget.onSelected(index);

    pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 260),
      curve: Curves.easeOutCubic,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height:
          MediaQuery.of(context).size.height * .78,
      padding: const EdgeInsets.fromLTRB(
        20,
        18,
        20,
        28,
      ),
      decoration: const BoxDecoration(
        color: Color(0xFFF6F1EA),
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(30),
        ),
      ),
      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,
        children: [
          Text(
            widget.title,
            style: const TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.w300,
              color: Color(0xFF241D18),
              letterSpacing: -.5,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Swipe big previews or tap the small strip below.',
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w300,
              color: Color(0xFF6F6258),
            ),
          ),
          const SizedBox(height: 18),
          Expanded(
            child: PageView.builder(
              controller: pageController,
              physics: const BouncingScrollPhysics(),
              itemCount: widget.backgrounds.length,
              onPageChanged: (index) {
                setState(() {
                  selectedIndex = index;
                });

                widget.onSelected(index);
              },
              itemBuilder: (context, index) {
                final selected =
                    selectedIndex == index;

                return AnimatedScale(
                  scale: selected ? 1 : .92,
                  duration:
                      const Duration(milliseconds: 220),
                  child: Container(
                    margin: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      borderRadius:
                          BorderRadius.circular(26),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black
                              .withOpacity(.16),
                          blurRadius: 24,
                          offset: const Offset(0, 14),
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius:
                          BorderRadius.circular(26),
                      child: Stack(
                        children: [
                          Positioned.fill(
                            child: Image.asset(
                              widget.backgrounds[index],
                              fit: BoxFit.cover,
                              errorBuilder: (
                                context,
                                error,
                                stackTrace,
                              ) {
                                return Container(
                                  color:
                                      const Color(0xFFEADFD4),
                                );
                              },
                            ),
                          ),
                          Positioned.fill(
                            child: Container(
                              color: Colors.black
                                  .withOpacity(.22),
                            ),
                          ),
                          Positioned(
                            left: 18,
                            right: 18,
                            bottom: 18,
                            child: Text(
                              'Option ${index + 1}',
                              style: const TextStyle(
                                color: Color(0xFFFFF9F1),
                                fontSize: 22,
                                fontWeight:
                                    FontWeight.w300,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 74,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              itemCount: widget.backgrounds.length,
              itemBuilder: (context, index) {
                final selected =
                    selectedIndex == index;

                return GestureDetector(
                  onTap: () {
                    _select(index);
                  },
                  child: Container(
                    width: 62,
                    margin: const EdgeInsets.only(
                      right: 10,
                    ),
                    decoration: BoxDecoration(
                      borderRadius:
                          BorderRadius.circular(18),
                      border: Border.all(
                        color: selected
                            ? const Color(0xFF241D18)
                            : const Color(0xFFE1D6CA),
                        width: selected ? 2 : .7,
                      ),
                    ),
                    child: ClipRRect(
                      borderRadius:
                          BorderRadius.circular(16),
                      child: Image.asset(
                        widget.backgrounds[index],
                        fit: BoxFit.cover,
                        errorBuilder: (
                          context,
                          error,
                          stackTrace,
                        ) {
                          return Container(
                            color:
                                const Color(0xFFEADFD4),
                          );
                        },
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _SheetOption extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final VoidCallback onTap;

  const _SheetOption({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color(0xFFFBF8F4),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: const Color(0xFFE1D6CA),
            width: .7,
          ),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              color: const Color(0xFF8B6F55),
              size: 23,
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      color: Color(0xFF241D18),
                      fontSize: 15,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      color: Color(0xFF6F6258),
                      fontSize: 12,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DrawerSectionTitle extends StatelessWidget {
  final String title;

  const _DrawerSectionTitle({
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: 10,
      ),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          title.toUpperCase(),
          style: const TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.w300,
            letterSpacing: 2.6,
            color: Color(0xFF8B7D72),
          ),
        ),
      ),
    );
  }
}

class _DrawerItem extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final VoidCallback onTap;

  const _DrawerItem({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(
          bottom: 10,
        ),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: const Color(0xFFFBF8F4)
              .withOpacity(.88),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: const Color(0xFFE2D8CD),
            width: .7,
          ),
        ),
        child: Row(
          children: [
            Container(
              height: 42,
              width: 42,
              decoration: BoxDecoration(
                color: const Color(0xFFF0E6DB),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Icon(
                icon,
                size: 21,
                color: const Color(0xFF8B6F55),
              ),
            ),
            const SizedBox(width: 13),
            Expanded(
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      color: Color(0xFF241D18),
                      fontSize: 15,
                      fontWeight: FontWeight.w300,
                      letterSpacing: -.1,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Color(0xFF6F6258),
                      fontSize: 11,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ],
              ),
            ),
            const Icon(
              Icons.chevron_right_rounded,
              color: Color(0xFF9A8D83),
              size: 21,
            ),
          ],
        ),
      ),
    );
  }
}

class _TopIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const _TopIconButton({
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 48,
        width: 48,
        decoration: BoxDecoration(
          color: const Color(0xFFFBF8F4)
              .withOpacity(.92),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: const Color(0xFFE2D8CD),
            width: .7,
          ),
        ),
        child: Icon(
          icon,
          color: const Color(0xFF241D18),
          size: 22,
        ),
      ),
    );
  }
}

class _HeroBeautyCard extends StatelessWidget {
  final VoidCallback onTap;

  const _HeroBeautyCard({
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 230,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(28),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(.10),
              blurRadius: 26,
              offset: const Offset(0, 16),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(28),
          child: Stack(
            children: [
              Positioned.fill(
                child: Image.asset(
                  'assets/images/spaces/beauty.jpg',
                  fit: BoxFit.cover,
                  errorBuilder: (
                    context,
                    error,
                    stackTrace,
                  ) {
                    return Container(
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            Color(0xFFEADFD4),
                            Color(0xFFCAB8A8),
                            Color(0xFF8B6F55),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.black.withOpacity(.08),
                        Colors.black.withOpacity(.22),
                        Colors.black.withOpacity(.66),
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 20,
                right: 20,
                bottom: 20,
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'TODAY’S BEAUTY PLAN',
                      style: TextStyle(
                        color: Color(0xFFE8D6B8),
                        fontSize: 10,
                        fontWeight: FontWeight.w300,
                        letterSpacing: 2.4,
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'Soft, polished, prepared.',
                      style: TextStyle(
                        color: Color(0xFFFFF9F1),
                        fontSize: 25,
                        fontWeight: FontWeight.w300,
                        letterSpacing: -.4,
                        height: 1.15,
                      ),
                    ),
                    const SizedBox(height: 7),
                    Text(
                      'Hair • Skin • Nails • Style',
                      style: TextStyle(
                        color: Colors.white.withOpacity(.74),
                        fontSize: 12,
                        fontWeight: FontWeight.w300,
                        letterSpacing: 1.4,
                      ),
                    ),
                    const SizedBox(height: 14),
                    Row(
                      children: [
                        _HeroTextAction(
                          label: 'Hair',
                          onTap: onTap,
                        ),
                        const SizedBox(width: 18),
                        _HeroTextAction(
                          label: 'Skin',
                          onTap: onTap,
                        ),
                        const SizedBox(width: 18),
                        _HeroTextAction(
                          label: 'Outfit',
                          onTap: onTap,
                        ),
                        const SizedBox(width: 18),
                        _HeroTextAction(
                          label: 'Photos',
                          onTap: onTap,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _HeroTextAction extends StatelessWidget {
  final String label;
  final VoidCallback onTap;

  const _HeroTextAction({
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Text(
        label,
        style: const TextStyle(
          color: Color(0xFFC6A06B),
          fontSize: 11,
          fontWeight: FontWeight.w300,
          letterSpacing: 1.6,
        ),
      ),
    );
  }
}

class _MetricCard extends StatelessWidget {
  final String label;
  final String value;
  final String subtitle;
  final IconData icon;
  final VoidCallback onTap;

  const _MetricCard({
    required this.label,
    required this.value,
    required this.subtitle,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 116,
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: const Color(0xFFFBF8F4)
              .withOpacity(.88),
          borderRadius: BorderRadius.circular(22),
          border: Border.all(
            color: const Color(0xFFE2D8CD),
            width: .7,
          ),
        ),
        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,
          children: [
            Icon(
              icon,
              color: const Color(0xFF8B6F55),
              size: 21,
            ),
            const Spacer(),
            Text(
              value,
              style: const TextStyle(
                color: Color(0xFF241D18),
                fontSize: 28,
                fontWeight: FontWeight.w300,
                height: 1,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              label,
              style: const TextStyle(
                color: Color(0xFF241D18),
                fontSize: 12,
                fontWeight: FontWeight.w400,
              ),
            ),
            Text(
              subtitle,
              style: const TextStyle(
                color: Color(0xFF8B7D72),
                fontSize: 10,
                fontWeight: FontWeight.w300,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _InsightCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final String imagePath;
  final VoidCallback onTap;

  const _InsightCard({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.imagePath,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 150,
        decoration: BoxDecoration(
          color: const Color(0xFFFBF8F4)
              .withOpacity(.90),
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: const Color(0xFFE2D8CD),
            width: .7,
          ),
        ),
        child: Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(18),
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,
                  children: [
                    Icon(
                      icon,
                      color: const Color(0xFF8B6F55),
                      size: 22,
                    ),
                    const Spacer(),
                    Text(
                      title,
                      style: const TextStyle(
                        color: Color(0xFF241D18),
                        fontSize: 18,
                        fontWeight: FontWeight.w300,
                        letterSpacing: -.2,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      subtitle,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Color(0xFF6F6258),
                        fontSize: 12,
                        fontWeight: FontWeight.w300,
                        height: 1.35,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(24),
                bottomRight: Radius.circular(24),
              ),
              child: SizedBox(
                width: 118,
                height: double.infinity,
                child: Image.asset(
                  imagePath,
                  fit: BoxFit.cover,
                  errorBuilder: (
                    context,
                    error,
                    stackTrace,
                  ) {
                    return Container(
                      color: const Color(0xFFEADFD4),
                      child: const Icon(
                        Icons.favorite_border_rounded,
                        color: Color(0xFF8B6F55),
                        size: 30,
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SimpleCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final VoidCallback onTap;

  const _SimpleCard({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: const Color(0xFFFBF8F4)
              .withOpacity(.88),
          borderRadius: BorderRadius.circular(22),
          border: Border.all(
            color: const Color(0xFFE2D8CD),
            width: .7,
          ),
        ),
        child: Row(
          children: [
            Container(
              height: 44,
              width: 44,
              decoration: BoxDecoration(
                color: const Color(0xFFF0E6DB),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Icon(
                icon,
                color: const Color(0xFF8B6F55),
                size: 22,
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      color: Color(0xFF241D18),
                      fontSize: 16,
                      fontWeight: FontWeight.w300,
                      letterSpacing: -.1,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    subtitle,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Color(0xFF6F6258),
                      fontSize: 12,
                      fontWeight: FontWeight.w300,
                      height: 1.35,
                    ),
                  ),
                ],
              ),
            ),
            const Icon(
              Icons.chevron_right_rounded,
              color: Color(0xFF9A8D83),
              size: 22,
            ),
          ],
        ),
      ),
    );
  }
}