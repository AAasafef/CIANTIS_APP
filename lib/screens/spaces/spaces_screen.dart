import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../models/space_model.dart';
import '../../services/spaces_service.dart';

import '../../widgets/ciantis_side_drawer.dart';
import '../../widgets/grid_menu.dart';

import '../beauty/beauty_space_screen.dart';
import '../business/business_screen.dart';
import '../calendar/calendar_screen.dart';
import '../documents/documents_screen.dart';
import '../family/family_kids_screen.dart';
import '../health/health_screen.dart';
import '../library/library_screen.dart';
import '../reserve/reserve_screen.dart';
import '../school/school_space_screen.dart';
import '../settings/settings_screen.dart';
import '../shared/coming_soon_screen.dart';
import '../spiritual/spiritual_transition_screen.dart';

import 'select_spaces_screen.dart';
import 'space_home_screen.dart';

class SpacesScreen extends StatefulWidget {
  const SpacesScreen({
    super.key,
  });

  @override
  State<SpacesScreen> createState() => _SpacesScreenState();
}

class _SpacesScreenState extends State<SpacesScreen> {
  int currentIndex = 0;
  int pageIndex = 0;

  bool loading = true;
  bool showBottomNav = true;

  final PageController pageController = PageController();
  final FocusNode keyboardFocusNode = FocusNode();
  final SpacesService spacesService = SpacesService.instance;

  List<SpaceModel> activeSpaces = [];

  @override
  void initState() {
    super.initState();
    _loadActiveSpaces();
  }

  Future<void> _loadActiveSpaces() async {
    await spacesService.loadSavedSpaces();

    if (!mounted) return;

    setState(() {
      activeSpaces = spacesService.activeSpaces;
      loading = false;
    });
  }

  void _openGridMenu(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (_) {
        return const GridMenu();
      },
    );
  }

  void _openManageSpaces() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => const SelectSpacesScreen(),
      ),
    );
  }

  void _goToNextPage() {
    final totalPages = activeSpaces.length + 1;

    if (pageIndex < totalPages - 1) {
      pageController.nextPage(
        duration: const Duration(milliseconds: 360),
        curve: Curves.easeOutCubic,
      );
    }
  }

  void _goToPreviousPage() {
    if (pageIndex > 0) {
      pageController.previousPage(
        duration: const Duration(milliseconds: 360),
        curve: Curves.easeOutCubic,
      );
    }
  }

  void _goToOverviewPage() {
    if (pageIndex > 0) {
      pageController.animateToPage(
        0,
        duration: const Duration(milliseconds: 360),
        curve: Curves.easeOutCubic,
      );
    }
  }

  void _openSpace(
    BuildContext context,
    SpaceModel space,
  ) {
    if (space.id == 'library') {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => const LibraryScreen(),
        ),
      );
      return;
    }

    if (space.id == 'documents') {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => const DocumentsScreen(),
        ),
      );
      return;
    }

    if (space.id == 'business') {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => const BusinessScreen(),
        ),
      );
      return;
    }

    if (space.id == 'health') {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => const HealthScreen(),
        ),
      );
      return;
    }

    if (space.id == 'beauty') {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => const BeautySpaceScreen(),
        ),
      );
      return;
    }

    if (space.id == 'family' || space.id == 'family_kids') {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => const FamilyKidsScreen(),
        ),
      );
      return;
    }

    if (space.id == 'school') {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => const SchoolSpaceScreen(),
        ),
      );
      return;
    }

    if (space.id == 'spiritual') {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => SpiritualTransitionScreen(
            space: space,
            mode: SpiritualTransitionMode.enter,
          ),
        ),
      );
      return;
    }

    if (space.id == 'reserve') {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => const ReserveScreen(),
        ),
      );
      return;
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => SpaceHomeScreen(
          space: space,
        ),
      ),
    );
  }

  void _handleBottomNavTap(int index) {
    setState(() {
      currentIndex = index;
    });

    if (index == 0) {
      _goToOverviewPage();
      return;
    }

    if (index == 1) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => const CalendarScreen(),
        ),
      );
      return;
    }

    if (index == 2) {
      _openGridMenu(context);
      return;
    }

    if (index == 3) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => const ComingSoonScreen(
            title: 'AI',
            subtitle:
                'Your assistant for voice commands, summaries, reminders, search, and hands-free navigation will connect here.',
            icon: Icons.auto_awesome_rounded,
          ),
        ),
      );
      return;
    }

    if (index == 4) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => const SettingsScreen(),
        ),
      );
    }
  }

  void _handleVerticalSwipe(DragEndDetails details) {
    final velocity = details.primaryVelocity ?? 0;

    if (velocity < -180) {
      setState(() {
        showBottomNav = true;
      });
      return;
    }

    if (velocity > 180 && pageIndex > 0) {
      setState(() {
        showBottomNav = false;
      });
    }
  }

  @override
  void dispose() {
    pageController.dispose();
    keyboardFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final totalPages = activeSpaces.length + 1;

    if (loading) {
      return const Scaffold(
        backgroundColor: Color(0xFFF6F1EA),
        body: Center(
          child: CircularProgressIndicator(
            color: Color(0xFF241D18),
          ),
        ),
      );
    }

    return KeyboardListener(
      autofocus: true,
      focusNode: keyboardFocusNode,
      onKeyEvent: (event) {
        if (event is! KeyDownEvent) return;

        if (event.logicalKey == LogicalKeyboardKey.arrowRight ||
            event.logicalKey == LogicalKeyboardKey.keyD) {
          _goToNextPage();
        }

        if (event.logicalKey == LogicalKeyboardKey.arrowLeft ||
            event.logicalKey == LogicalKeyboardKey.keyA) {
          _goToPreviousPage();
        }

        if (event.logicalKey == LogicalKeyboardKey.escape) {
          _goToOverviewPage();
        }
      },
      child: ScrollConfiguration(
        behavior: const _DesktopDragScrollBehavior(),
        child: Scaffold(
          backgroundColor: const Color(0xFFF6F1EA),
          drawer: const CiantisSideDrawer(),
          extendBody: true,
          bottomNavigationBar: AnimatedSlide(
            duration: const Duration(milliseconds: 260),
            curve: Curves.easeOutCubic,
            offset: showBottomNav ? Offset.zero : const Offset(0, 1.35),
            child: AnimatedOpacity(
              duration: const Duration(milliseconds: 220),
              opacity: showBottomNav ? 1 : 0,
              child: _SpacesCarouselBottomNav(
                currentIndex: currentIndex,
                onTap: _handleBottomNavTap,
              ),
            ),
          ),
          body: GestureDetector(
            behavior: HitTestBehavior.translucent,
            onVerticalDragEnd: _handleVerticalSwipe,
            child: Listener(
              onPointerSignal: (pointerSignal) {
                if (pointerSignal is PointerScrollEvent) {
                  if (pointerSignal.scrollDelta.dy > 0 ||
                      pointerSignal.scrollDelta.dx > 0) {
                    _goToNextPage();
                  }

                  if (pointerSignal.scrollDelta.dy < 0 ||
                      pointerSignal.scrollDelta.dx < 0) {
                    _goToPreviousPage();
                  }
                }
              },
              child: PageView.builder(
                controller: pageController,
                physics: const BouncingScrollPhysics(),
                itemCount: totalPages,
                onPageChanged: (index) {
                  setState(() {
                    pageIndex = index;
                    showBottomNav = index == 0;
                  });
                },
                itemBuilder: (context, index) {
                  if (index == 0) {
                    return _SpacesWalletOverviewPage(
                      spaces: activeSpaces,
                      onManageSpaces: _openManageSpaces,
                      onPreview: (spaceIndex) {
                        setState(() {
                          showBottomNav = false;
                        });

                        pageController.animateToPage(
                          spaceIndex + 1,
                          duration: const Duration(milliseconds: 420),
                          curve: Curves.easeOutCubic,
                        );
                      },
                      onOpen: (space) {
                        _openSpace(context, space);
                      },
                    );
                  }

                  final space = activeSpaces[index - 1];

                  return _FullScreenSpacePreviewPage(
                    space: space,
                    pageNumber: index + 1,
                    totalPages: totalPages,
                    bottomNavVisible: showBottomNav,
                    onBack: _goToOverviewPage,
                    onOpen: () {
                      _openSpace(context, space);
                    },
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _DesktopDragScrollBehavior extends MaterialScrollBehavior {
  const _DesktopDragScrollBehavior();

  @override
  Set<PointerDeviceKind> get dragDevices {
    return {
      PointerDeviceKind.touch,
      PointerDeviceKind.mouse,
      PointerDeviceKind.trackpad,
      PointerDeviceKind.stylus,
      PointerDeviceKind.unknown,
    };
  }
}

class _SpacesWalletOverviewPage extends StatefulWidget {
  final List<SpaceModel> spaces;
  final VoidCallback onManageSpaces;
  final Function(int index) onPreview;
  final Function(SpaceModel space) onOpen;

  const _SpacesWalletOverviewPage({
    required this.spaces,
    required this.onManageSpaces,
    required this.onPreview,
    required this.onOpen,
  });

  @override
  State<_SpacesWalletOverviewPage> createState() =>
      _SpacesWalletOverviewPageState();
}

class _SpacesWalletOverviewPageState extends State<_SpacesWalletOverviewPage> {
  int selectedIndex = 0;

  late final PageController walletController = PageController(
    viewportFraction: .58,
    initialPage: selectedIndex,
  );

  @override
  void dispose() {
    walletController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final spaces = widget.spaces;

    return Stack(
      children: [
        Positioned.fill(
          child: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xFFF8F4EE),
                  Color(0xFFEAE0D4),
                ],
              ),
            ),
          ),
        ),
        SafeArea(
          bottom: false,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(
              26,
              24,
              26,
              118,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Expanded(
                      child: Text(
                        'Your Spaces',
                        style: TextStyle(
                          fontSize: 44,
                          height: 1,
                          fontWeight: FontWeight.w300,
                          letterSpacing: -1.4,
                          color: Color(0xFF241D18),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: widget.onManageSpaces,
                      child: Container(
                        height: 44,
                        width: 44,
                        decoration: BoxDecoration(
                          color: const Color(0xFFFBF8F4).withOpacity(.94),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: const Color(0xFFE1D6CA),
                            width: .7,
                          ),
                        ),
                        child: const Icon(
                          Icons.tune_rounded,
                          color: Color(0xFF241D18),
                          size: 21,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                const Text(
                  'Swipe to preview or tap a space.',
                  style: TextStyle(
                    fontSize: 15,
                    height: 1.4,
                    fontWeight: FontWeight.w300,
                    color: Color(0xFF6F6258),
                  ),
                ),
                const SizedBox(height: 34),
                Expanded(
                  child: spaces.isEmpty
                      ? const Center(
                          child: Text(
                            'No spaces selected yet. Tap Customize & Add Spaces to choose at least one space.',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 15,
                              height: 1.5,
                              fontWeight: FontWeight.w300,
                              color: Color(0xFF6F6258),
                            ),
                          ),
                        )
                      : PageView.builder(
                          controller: walletController,
                          clipBehavior: Clip.none,
                          physics: const BouncingScrollPhysics(),
                          itemCount: spaces.length,
                          onPageChanged: (index) {
                            setState(() {
                              selectedIndex = index;
                            });
                          },
                          itemBuilder: (context, index) {
                            final space = spaces[index];
                            final selected = selectedIndex == index;

                            return AnimatedScale(
                              duration: const Duration(milliseconds: 260),
                              curve: Curves.easeOutCubic,
                              scale: selected ? 1.045 : .91,
                              child: AnimatedOpacity(
                                duration: const Duration(milliseconds: 260),
                                opacity: selected ? 1 : .82,
                                child: GestureDetector(
                                  onTap: () {
                                    if (selected) {
                                      widget.onPreview(index);
                                    } else {
                                      walletController.animateToPage(
                                        index,
                                        duration: const Duration(
                                          milliseconds: 360,
                                        ),
                                        curve: Curves.easeOutCubic,
                                      );
                                    }
                                  },
                                  onDoubleTap: () {
                                    widget.onOpen(space);
                                  },
                                  child: _WalletSpaceCard(
                                    space: space,
                                    selected: selected,
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                ),
                const SizedBox(height: 20),
                if (spaces.isNotEmpty)
                  _Dots(
                    currentIndex: selectedIndex,
                    total: spaces.length,
                  ),
                const SizedBox(height: 18),
                GestureDetector(
                  onTap: widget.onManageSpaces,
                  child: Container(
                    height: 54,
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(horizontal: 18),
                    decoration: BoxDecoration(
                      color: const Color(0xFF2B2118),
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(.08),
                          blurRadius: 22,
                          offset: const Offset(0, 12),
                        ),
                      ],
                    ),
                    child: const Row(
                      children: [
                        Expanded(
                          child: Text(
                            'Customize & Add Spaces',
                            style: TextStyle(
                              color: Color(0xFFF8F4EE),
                              fontSize: 14,
                              fontWeight: FontWeight.w300,
                              letterSpacing: -.1,
                            ),
                          ),
                        ),
                        Icon(
                          Icons.add_rounded,
                          color: Color(0xFFF8F4EE),
                          size: 22,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _WalletSpaceCard extends StatelessWidget {
  final SpaceModel space;
  final bool selected;

  const _WalletSpaceCard({
    required this.space,
    required this.selected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        left: selected ? 4 : 8,
        right: selected ? 4 : 8,
        top: selected ? 0 : 26,
        bottom: selected ? 8 : 34,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: selected
              ? const Color(0xFFD1B98C).withOpacity(.62)
              : Colors.white.withOpacity(.12),
          width: .55,
        ),
        boxShadow: [
          if (selected)
            BoxShadow(
              color: const Color(0xFFB8955F).withOpacity(.24),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          BoxShadow(
            color: Colors.black.withOpacity(.18),
            blurRadius: 26,
            offset: const Offset(0, 18),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(17),
        child: Stack(
          children: [
            Positioned.fill(
              child: Image.asset(
                space.imagePath,
                fit: BoxFit.cover,
                errorBuilder: (
                  context,
                  error,
                  stackTrace,
                ) {
                  return _MissingSpaceImage(
                    icon: space.icon,
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
                      Colors.black.withOpacity(.10),
                      Colors.black.withOpacity(.24),
                      Colors.black.withOpacity(.84),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              left: 16,
              right: 16,
              bottom: 28,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    space.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Color(0xFFF8F4EE),
                      fontSize: 25,
                      height: 1,
                      fontWeight: FontWeight.w300,
                      letterSpacing: -.5,
                    ),
                  ),
                  const SizedBox(height: 9),
                  Text(
                    _spaceSubtitle(space.id),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: Colors.white.withOpacity(.72),
                      fontSize: 10,
                      fontWeight: FontWeight.w300,
                      letterSpacing: 1.7,
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

class _FullScreenSpacePreviewPage extends StatelessWidget {
  final SpaceModel space;
  final int pageNumber;
  final int totalPages;
  final bool bottomNavVisible;
  final VoidCallback onBack;
  final VoidCallback onOpen;

  const _FullScreenSpacePreviewPage({
    required this.space,
    required this.pageNumber,
    required this.totalPages,
    required this.bottomNavVisible,
    required this.onBack,
    required this.onOpen,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onDoubleTap: onOpen,
      child: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              space.imagePath,
              fit: BoxFit.cover,
              errorBuilder: (
                context,
                error,
                stackTrace,
              ) {
                return _MissingSpaceImage(
                  icon: space.icon,
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
                    Colors.black.withOpacity(.16),
                    Colors.black.withOpacity(.18),
                    Colors.black.withOpacity(.82),
                  ],
                ),
              ),
            ),
          ),
          SafeArea(
            bottom: false,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(
                22,
                18,
                22,
                0,
              ),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: onBack,
                    child: Container(
                      height: 42,
                      width: 42,
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(.24),
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors.white.withOpacity(.12),
                          width: .7,
                        ),
                      ),
                      child: const Icon(
                        Icons.arrow_back_ios_new_rounded,
                        color: Colors.white,
                        size: 17,
                      ),
                    ),
                  ),
                  const Spacer(),
                  Text(
                    '$pageNumber / $totalPages',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                      letterSpacing: 1.2,
                    ),
                  ),
                ],
              ),
            ),
          ),
          AnimatedPositioned(
            duration: const Duration(milliseconds: 260),
            curve: Curves.easeOutCubic,
            left: 26,
            right: 26,
            bottom: bottomNavVisible ? 174 : 88,
            child: Column(
              children: [
                Icon(
                  space.icon,
                  color: Colors.white.withOpacity(.92),
                  size: 30,
                ),
                const SizedBox(height: 12),
                Text(
                  space.title,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Color(0xFFF8F4EE),
                    fontSize: 38,
                    height: 1,
                    fontWeight: FontWeight.w300,
                    letterSpacing: -.8,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  _spaceSubtitle(space.id),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white.withOpacity(.72),
                    fontSize: 11,
                    fontWeight: FontWeight.w300,
                    letterSpacing: 2.2,
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  space.description,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white.withOpacity(.86),
                    fontSize: 15,
                    fontWeight: FontWeight.w300,
                    height: 1.45,
                  ),
                ),
                const SizedBox(height: 28),
                GestureDetector(
                  onTap: onOpen,
                  child: const Text(
                    'ENTER',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xFFC6A06B),
                      fontSize: 10,
                      fontWeight: FontWeight.w300,
                      letterSpacing: 2.6,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _SpacesCarouselBottomNav extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const _SpacesCarouselBottomNav({
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.of(context).padding.bottom;

    return SafeArea(
      top: false,
      child: Padding(
        padding: EdgeInsets.fromLTRB(
          18,
          0,
          18,
          bottomInset > 0 ? 8 : 14,
        ),
        child: Container(
          height: 62,
          padding: const EdgeInsets.symmetric(
            horizontal: 10,
            vertical: 7,
          ),
          decoration: BoxDecoration(
            color: const Color(0xFF241D18).withOpacity(.92),
            borderRadius: BorderRadius.circular(24),
            border: Border.all(
              color: const Color(0xFFD8C7B5).withOpacity(.18),
              width: .7,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(.18),
                blurRadius: 24,
                offset: const Offset(0, 12),
              ),
            ],
          ),
          child: Row(
            children: [
              _SpacesCarouselNavItem(
                index: 0,
                currentIndex: currentIndex,
                icon: Icons.grid_view_rounded,
                label: 'Spaces',
                onTap: onTap,
              ),
              _SpacesCarouselNavItem(
                index: 1,
                currentIndex: currentIndex,
                icon: Icons.calendar_month_rounded,
                label: 'Calendar',
                onTap: onTap,
              ),
              _SpacesCarouselCenterNavItem(
                index: 2,
                currentIndex: currentIndex,
                onTap: onTap,
              ),
              _SpacesCarouselNavItem(
                index: 3,
                currentIndex: currentIndex,
                icon: Icons.mic_none_rounded,
                label: 'AI',
                onTap: onTap,
              ),
              _SpacesCarouselNavItem(
                index: 4,
                currentIndex: currentIndex,
                icon: Icons.settings_rounded,
                label: 'Settings',
                onTap: onTap,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SpacesCarouselNavItem extends StatelessWidget {
  final int index;
  final int currentIndex;
  final IconData icon;
  final String label;
  final ValueChanged<int> onTap;

  const _SpacesCarouselNavItem({
    required this.index,
    required this.currentIndex,
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final selected = currentIndex == index;

    return Expanded(
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          onTap(index);
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 220),
          curve: Curves.easeOutCubic,
          decoration: BoxDecoration(
            color: selected
                ? const Color(0xFFF6F1EA).withOpacity(.12)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 21,
                color: selected
                    ? const Color(0xFFF8F4EE)
                    : const Color(0xFFD8C7B5).withOpacity(.74),
              ),
              const SizedBox(height: 4),
              Text(
                label,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: selected
                      ? const Color(0xFFF8F4EE)
                      : const Color(0xFFD8C7B5).withOpacity(.72),
                  fontSize: 10,
                  height: 1,
                  fontWeight: FontWeight.w400,
                  letterSpacing: -.1,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SpacesCarouselCenterNavItem extends StatelessWidget {
  final int index;
  final int currentIndex;
  final ValueChanged<int> onTap;

  const _SpacesCarouselCenterNavItem({
    required this.index,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final selected = currentIndex == index;

    return Expanded(
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          onTap(index);
        },
        child: Center(
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 220),
            curve: Curves.easeOutCubic,
            height: 48,
            width: 48,
            decoration: BoxDecoration(
              color: selected
                  ? const Color(0xFFF8F4EE)
                  : const Color(0xFF3A2D24),
              borderRadius: BorderRadius.circular(17),
              border: Border.all(
                color: const Color(0xFFD8C7B5).withOpacity(.22),
                width: .7,
              ),
            ),
            child: Icon(
              Icons.apps_rounded,
              color: selected
                  ? const Color(0xFF241D18)
                  : const Color(0xFFF8F4EE),
              size: 25,
            ),
          ),
        ),
      ),
    );
  }
}

class _MissingSpaceImage extends StatelessWidget {
  final IconData icon;

  const _MissingSpaceImage({
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFF2B2118),
      child: Center(
        child: Icon(
          icon,
          color: const Color(0xFFD1B98C).withOpacity(.74),
          size: 44,
        ),
      ),
    );
  }
}

class _Dots extends StatelessWidget {
  final int currentIndex;
  final int total;

  const _Dots({
    required this.currentIndex,
    required this.total,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        total,
        (index) {
          final selected = currentIndex == index;

          return AnimatedContainer(
            duration: const Duration(milliseconds: 220),
            margin: const EdgeInsets.symmetric(
              horizontal: 5,
            ),
            height: 6,
            width: selected ? 8 : 6,
            decoration: BoxDecoration(
              color: selected
                  ? const Color(0xFFB8955F)
                  : const Color(0xFFB9ADA3),
              shape: BoxShape.circle,
            ),
          );
        },
      ),
    );
  }
}

String _spaceSubtitle(String id) {
  switch (id) {
    case 'documents':
      return 'FILE CABINET';
    case 'health':
      return 'WELLNESS SPACE';
    case 'money':
      return 'MONEY SYSTEM';
    case 'business':
      return 'MONEY & SALON';
    case 'school':
      return 'LEARNING HUB';
    case 'work':
      return 'CAREER SPACE';
    case 'spiritual':
      return 'PRAYER & PURPOSE';
    case 'home':
      return 'HOME SYSTEM';
    case 'beauty':
      return 'BEAUTY SPACE';
    case 'family':
      return 'FAMILY SPACE';
    case 'library':
      return 'KNOWLEDGE VAULT';
    case 'travel':
      return 'TRAVEL PLANS';
    case 'reserve':
      return 'PRIVATE VAULT';
    case 'custom':
      return 'CUSTOM SPACE';
    default:
      return 'CIANTIS SPACE';
  }
}