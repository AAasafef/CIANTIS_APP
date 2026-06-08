import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import '../../widgets/ciantis_text_side_menu.dart';
import '../../widgets/grid_menu.dart';
import '../../widgets/spaces_bottom_nav_bar.dart';

import '../calendar/calendar_screen.dart';
import '../settings/settings_screen.dart';
import '../shared/coming_soon_screen.dart';
import '../spaces/spaces_screen.dart';

import 'library_collection_screen.dart';
import 'library_section_screen.dart';

class LibraryScreen extends StatefulWidget {
  const LibraryScreen({
    super.key,
  });

  @override
  State<LibraryScreen> createState() =>
      _LibraryScreenState();
}

class _LibraryScreenState extends State<LibraryScreen> {
  final PageController pageController = PageController();

  bool showBottomNav = true;
  int pageIndex = 0;

  int selectedThemeIndex = 0;
  int previewThemeIndex = 0;
  int savedThemeIndex = 0;

  String selectedCategory = 'Dashboard';
  String selectedSubCategory = 'All';

  static const Color background = Color(0xFF17100C);
  static const Color darkBackground = Color(0xFF0F0A07);
  static const Color cardColor = Color(0xFF231914);
  static const Color cardSoft = Color(0xFF2D211A);
  static const Color borderColor = Color(0xFF4A382B);
  static const Color creamText = Color(0xFFFFF3E2);
  static const Color softText = Color(0xFFD4C3AE);
  static const Color mutedText = Color(0xFF9F8C7A);
  static const Color gold = Color(0xFFC6A06B);
  static const Color softGold = Color(0xFFE8D6B8);

  final Map<String, List<String>> drawerTabs = {
    'Dashboard': [],
    'Library Sections': [
      'Books',
      'Audiobooks',
      'Saved Documents',
      'Notes & Highlights',
      'Bookmarks',
      'Quotes',
      'Reading Goals',
      'Wishlist',
    ],
    'Collection': [
      'Currently Reading',
      'Nursing School',
      'Business & Money',
      'Spiritual Growth',
      'Hair Education',
      'Parenting',
    ],
    'Add From Spaces': [
      'School',
      'Business',
      'Documents',
      'Health',
      'Spiritual',
    ],
    'Library Settings': [
      'Change Background',
      'Privacy / Lock',
      'Reading Preferences',
      'Manual Add Rules',
    ],
  };

  final List<_LibraryTheme> themes = const [
    _LibraryTheme(
      name: 'Quiet Stone',
      imagePath:
          'assets/images/library/themes/theme_01.png',
    ),
    _LibraryTheme(
      name: 'Leather Desk',
      imagePath:
          'assets/images/library/themes/theme_02.png',
    ),
    _LibraryTheme(
      name: 'Midnight Hall',
      imagePath:
          'assets/images/library/themes/theme_03.png',
    ),
    _LibraryTheme(
      name: 'Dark Study',
      imagePath:
          'assets/images/library/themes/theme_04.png',
    ),
    _LibraryTheme(
      name: 'Stone Notebook',
      imagePath:
          'assets/images/library/themes/theme_05.png',
    ),
    _LibraryTheme(
      name: 'Olive Plaster',
      imagePath:
          'assets/images/library/themes/theme_06.png',
    ),
    _LibraryTheme(
      name: 'Soft Plaster',
      imagePath:
          'assets/images/library/themes/theme_07.png',
    ),
    _LibraryTheme(
      name: 'Lamp Desk',
      imagePath:
          'assets/images/library/themes/theme_08.png',
    ),
    _LibraryTheme(
      name: 'Marble Noir',
      imagePath:
          'assets/images/library/themes/theme_09.png',
    ),
    _LibraryTheme(
      name: 'Old Library',
      imagePath:
          'assets/images/library/themes/theme_10.png',
    ),
    _LibraryTheme(
      name: 'Cream Chair',
      imagePath:
          'assets/images/library/themes/theme_11.png',
    ),
    _LibraryTheme(
      name: 'Reading Desk',
      imagePath:
          'assets/images/library/themes/theme_12.png',
    ),
    _LibraryTheme(
      name: 'Modern Shelves',
      imagePath:
          'assets/images/library/themes/theme_13.png',
    ),
    _LibraryTheme(
      name: 'Warm Office',
      imagePath:
          'assets/images/library/themes/theme_14.png',
    ),
    _LibraryTheme(
      name: 'Linen Rest',
      imagePath:
          'assets/images/library/themes/theme_15.png',
    ),
    _LibraryTheme(
      name: 'Executive Desk',
      imagePath:
          'assets/images/library/themes/theme_16.png',
    ),
    _LibraryTheme(
      name: 'Soft Workspace',
      imagePath:
          'assets/images/library/themes/theme_17.png',
    ),
    _LibraryTheme(
      name: 'Neutral Blocks',
      imagePath:
          'assets/images/library/themes/theme_18.png',
    ),
    _LibraryTheme(
      name: 'Sunlit Door',
      imagePath:
          'assets/images/library/themes/theme_19.png',
    ),
    _LibraryTheme(
      name: 'Golden Window',
      imagePath:
          'assets/images/library/themes/theme_20.png',
    ),
  ];

  @override
  void dispose() {
    pageController.dispose();
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
              'Your assistant for voice commands, reminders, summaries, and hands-free navigation will connect here.',
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

  void _handleScrollDirection(
    UserScrollNotification notification,
  ) {
    if (notification.direction == ScrollDirection.reverse &&
        showBottomNav) {
      setState(() {
        showBottomNav = false;
      });
    }

    if (notification.direction == ScrollDirection.forward &&
        !showBottomNav) {
      setState(() {
        showBottomNav = true;
      });
    }
  }

  void _openThemePicker() {
    savedThemeIndex = selectedThemeIndex;
    previewThemeIndex = selectedThemeIndex;

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (_) {
        return StatefulBuilder(
          builder: (context, modalSetState) {
            return Container(
              padding: const EdgeInsets.fromLTRB(
                18,
                12,
                18,
                24,
              ),
              decoration: const BoxDecoration(
                color: Color(0xFFE8D8C4),
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(34),
                ),
              ),
              child: SafeArea(
                top: false,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      height: 4,
                      width: 44,
                      decoration: BoxDecoration(
                        color: const Color(0xFF9B876E)
                            .withOpacity(.45),
                        borderRadius:
                            BorderRadius.circular(20),
                      ),
                    ),
                    const SizedBox(height: 18),
                    const Text(
                      'Change Background',
                      style: TextStyle(
                        color: Color(0xFF241D18),
                        fontSize: 20,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      'Swipe to preview backgrounds',
                      style: TextStyle(
                        color: Color(0xFF6F6258),
                        fontSize: 12,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    const SizedBox(height: 18),
                    SizedBox(
                      height: 82,
                      child: PageView.builder(
                        controller: PageController(
                          viewportFraction: .23,
                          initialPage: selectedThemeIndex,
                        ),
                        itemCount: themes.length,
                        onPageChanged: (index) {
                          modalSetState(() {
                            previewThemeIndex = index;
                          });

                          setState(() {
                            selectedThemeIndex = index;
                          });
                        },
                        itemBuilder: (context, index) {
                          final selected =
                              index == previewThemeIndex;

                          return GestureDetector(
                            onTap: () {
                              modalSetState(() {
                                previewThemeIndex = index;
                              });

                              setState(() {
                                selectedThemeIndex = index;
                              });
                            },
                            child: AnimatedContainer(
                              duration: const Duration(
                                milliseconds: 220,
                              ),
                              margin:
                                  const EdgeInsets.symmetric(
                                horizontal: 5,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.circular(14),
                                border: Border.all(
                                  color: selected
                                      ? const Color(0xFFC6A06B)
                                      : Colors.transparent,
                                  width: 2,
                                ),
                              ),
                              child: ClipRRect(
                                borderRadius:
                                    BorderRadius.circular(12),
                                child: Image.asset(
                                  themes[index].imagePath,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      themes[previewThemeIndex].name,
                      style: const TextStyle(
                        color: Color(0xFF4B3A2C),
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                selectedThemeIndex =
                                    previewThemeIndex;
                                savedThemeIndex =
                                    previewThemeIndex;
                              });

                              Navigator.pop(context);
                            },
                            child: Container(
                              height: 46,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color:
                                    const Color(0xFFC6A06B),
                                borderRadius:
                                    BorderRadius.circular(16),
                              ),
                              child: const Text(
                                'Confirm Background',
                                style: TextStyle(
                                  color: Color(0xFF241D18),
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                selectedThemeIndex =
                                    savedThemeIndex;
                                previewThemeIndex =
                                    savedThemeIndex;
                              });

                              Navigator.pop(context);
                            },
                            child: Container(
                              height: 46,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: Colors.transparent,
                                borderRadius:
                                    BorderRadius.circular(16),
                                border: Border.all(
                                  color:
                                      const Color(0xFFBCA88F),
                                ),
                              ),
                              child: const Text(
                                'Cancel',
                                style: TextStyle(
                                  color: Color(0xFF241D18),
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget _dashboardBackground({
    required Widget child,
  }) {
    return Stack(
      children: [
        Positioned.fill(
          child: Image.asset(
            themes[selectedThemeIndex].imagePath,
            fit: BoxFit.cover,
          ),
        ),
        Positioned.fill(
          child: Container(
            color: Colors.black.withOpacity(.38),
          ),
        ),
        Positioned.fill(
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.black.withOpacity(.18),
                  Colors.black.withOpacity(.30),
                  Colors.black.withOpacity(.68),
                ],
              ),
            ),
          ),
        ),
        child,
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: darkBackground,
      drawerEnableOpenDragGesture: true,
      drawer: CiantisTextSideMenu(
        title: 'Library',
        subtitle: 'PERSONAL LIBRARY',
        drawerTabs: drawerTabs,
        selectedCategory: selectedCategory,
        selectedSubCategory: selectedSubCategory,
        onMainTabSelected: (category) {
          setState(() {
            selectedCategory = category;
            selectedSubCategory = 'All';
          });
        },
        onSubTabSelected: (category, subCategory) {
          setState(() {
            selectedCategory = category;
            selectedSubCategory = subCategory;
          });

          if (category == 'Library Settings' &&
              subCategory == 'Change Background') {
            Navigator.pop(context);

            Future.delayed(
              const Duration(milliseconds: 260),
              () {
                if (mounted) {
                  _openThemePicker();
                }
              },
            );
          }
        },
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
            currentIndex: 2,
            onTap: _handleBottomNavTap,
          ),
        ),
      ),
      body: PageView(
        controller: pageController,
        physics: const BouncingScrollPhysics(),
        onPageChanged: (index) {
          setState(() {
            pageIndex = index;
          });
        },
        children: [
          _dashboardPage(context),
          _collectionPage(context),
        ],
      ),
    );
  }

  Widget _dashboardPage(BuildContext context) {
    return NotificationListener<UserScrollNotification>(
      onNotification: (notification) {
        _handleScrollDirection(notification);
        return false;
      },
      child: _dashboardBackground(
        child: SafeArea(
          child: SingleChildScrollView(
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
                _topHeader(context),

                const SizedBox(height: 10),

                const Text(
                  'PERSONAL LIBRARY',
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w300,
                    letterSpacing: 3.2,
                    color: softGold,
                  ),
                ),

                const SizedBox(height: 18),

                const Text(
                  'Your personal collection of books, audiobooks, saved documents, notes, quotes, and reading goals.',
                  style: TextStyle(
                    fontSize: 14,
                    color: softText,
                    height: 1.55,
                    fontWeight: FontWeight.w300,
                  ),
                ),

                const SizedBox(height: 26),

                _heroLibraryCard(),

                const SizedBox(height: 20),

                _searchBox(
                  hint:
                      'Search books, notes, documents, quotes...',
                ),

                const SizedBox(height: 24),

                _sectionHeader(
                  title: 'Library Sections',
                  action: 'View All',
                ),

                const SizedBox(height: 14),

                _sectionIconRow(context),

                const SizedBox(height: 28),

                _sectionHeader(
                  title: 'Collection',
                  action: 'View All',
                ),

                const SizedBox(height: 14),

                _collectionPreviewRow(context),

                const SizedBox(height: 26),

                _addFromSpacesCard(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _collectionPage(BuildContext context) {
    return NotificationListener<UserScrollNotification>(
      onNotification: (notification) {
        _handleScrollDirection(notification);
        return false;
      },
      child: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.fromLTRB(
            18,
            22,
            18,
            128,
          ),
          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.start,
            children: [
              _collectionTopBar(context),

              const SizedBox(height: 8),

              const Center(
                child: Text(
                  'Collection',
                  style: TextStyle(
                    color: creamText,
                    fontSize: 44,
                    height: .95,
                    fontWeight: FontWeight.w300,
                    letterSpacing: -1.3,
                  ),
                ),
              ),

              const SizedBox(height: 10),

              const Center(
                child: Text(
                  'CURATED BOOKS',
                  style: TextStyle(
                    color: gold,
                    fontSize: 11,
                    letterSpacing: 4,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ),

              const SizedBox(height: 24),

              _searchBox(
                hint: 'Search your collection...',
                dark: true,
              ),

              const SizedBox(height: 22),

              _bookshelfSection(
                title: 'Currently Reading',
                books: const [
                  _BookDisplay(
                    title: 'Atomic\nHabits',
                    author: 'James Clear',
                    color: Color(0xFFE8D9C3),
                    textColor: Color(0xFF4A2B18),
                    progress: '68%',
                  ),
                  _BookDisplay(
                    title: 'Psychology\nof Money',
                    author: 'Morgan Housel',
                    color: Color(0xFFD8C8B7),
                    textColor: Color(0xFF2A1A11),
                    progress: '41%',
                  ),
                  _BookDisplay(
                    title: 'Think\nRich',
                    author: 'Napoleon Hill',
                    color: Color(0xFF151411),
                    textColor: Color(0xFFE6B76C),
                    progress: '23%',
                  ),
                  _BookDisplay(
                    title: 'Midnight\nLibrary',
                    author: 'Matt Haig',
                    color: Color(0xFF1E252A),
                    textColor: Color(0xFFE8C783),
                    progress: '12%',
                  ),
                ],
              ),

              _bookshelfSection(
                title: 'Nursing School',
                books: const [
                  _BookDisplay(
                    title: 'Pharmacology\nfor Nurses',
                    author: '',
                    color: Color(0xFF101722),
                    textColor: Color(0xFFE2B76B),
                    progress: '89%',
                  ),
                  _BookDisplay(
                    title: 'Fundamentals\nof Nursing',
                    author: '',
                    color: Color(0xFFDDC8A8),
                    textColor: Color(0xFF342114),
                    progress: '79%',
                  ),
                  _BookDisplay(
                    title: 'Medical\nSurgical',
                    author: '',
                    color: Color(0xFF1A2A25),
                    textColor: Color(0xFFDFAE5E),
                    progress: '72%',
                  ),
                  _BookDisplay(
                    title: 'Dosage\nCalculations',
                    author: '',
                    color: Color(0xFF221A14),
                    textColor: Color(0xFFE0B766),
                    progress: '65%',
                  ),
                ],
              ),

              _bookshelfSection(
                title: 'Business & Money',
                books: const [
                  _BookDisplay(
                    title: 'Millionaire\nNext Door',
                    author: '',
                    color: Color(0xFF191512),
                    textColor: Color(0xFFE0B766),
                    progress: '74%',
                  ),
                  _BookDisplay(
                    title: 'Rich Dad\nPoor Dad',
                    author: '',
                    color: Color(0xFF291B33),
                    textColor: Color(0xFFDFAE5E),
                    progress: '81%',
                  ),
                  _BookDisplay(
                    title: 'Second\nBrain',
                    author: '',
                    color: Color(0xFF22311F),
                    textColor: Color(0xFFE2B76B),
                    progress: '55%',
                  ),
                  _BookDisplay(
                    title: '5 AM\nClub',
                    author: '',
                    color: Color(0xFF3B2114),
                    textColor: Color(0xFFEBD2A2),
                    progress: '47%',
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _topHeader(BuildContext context) {
    return Row(
      crossAxisAlignment:
          CrossAxisAlignment.start,
      children: [
        const Expanded(
          child: Text(
            'Library',
            style: TextStyle(
              fontSize: 48,
              height: .95,
              fontWeight: FontWeight.w300,
              letterSpacing: -1.6,
              color: creamText,
            ),
          ),
        ),
        Builder(
          builder: (context) {
            return GestureDetector(
              onTap: () {
                Scaffold.of(context).openDrawer();
              },
              child: _topIconButton(
                Icons.menu_rounded,
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _collectionTopBar(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: () {
            pageController.animateToPage(
              0,
              duration:
                  const Duration(milliseconds: 350),
              curve: Curves.easeOutCubic,
            );
          },
          child: _topIconButton(
            Icons.arrow_back_ios_new_rounded,
          ),
        ),
        const Spacer(),
        Builder(
          builder: (context) {
            return GestureDetector(
              onTap: () {
                Scaffold.of(context).openDrawer();
              },
              child: _topIconButton(
                Icons.menu_rounded,
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _topIconButton(IconData icon) {
    return Container(
      height: 48,
      width: 48,
      decoration: BoxDecoration(
        color: const Color(0xFF2B211A)
            .withOpacity(.92),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: const Color(0xFF4C392C),
          width: .7,
        ),
      ),
      child: Icon(
        icon,
        color: softGold,
        size: 22,
      ),
    );
  }

  Widget _heroLibraryCard() {
    return Container(
      height: 254,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: const Color(0xFF5A4433),
          width: .7,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.32),
            blurRadius: 28,
            offset: const Offset(0, 18),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: Stack(
          children: [
            Positioned.fill(
              child: Image.asset(
                'assets/images/spaces/library.jpg',
                fit: BoxFit.cover,
              ),
            ),
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Colors.black.withOpacity(.18),
                      Colors.black.withOpacity(.38),
                      Colors.black.withOpacity(.82),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              left: 22,
              right: 22,
              bottom: 22,
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [
                  const Text(
                    'CURATED KNOWLEDGE',
                    style: TextStyle(
                      color: gold,
                      fontSize: 10,
                      fontWeight: FontWeight.w300,
                      letterSpacing: 2.5,
                    ),
                  ),
                  const SizedBox(height: 11),
                  const Text(
                    'A quiet place for\nwhat you choose\nto keep.',
                    style: TextStyle(
                      color: creamText,
                      fontSize: 25,
                      fontWeight: FontWeight.w300,
                      height: 1.08,
                      letterSpacing: -.4,
                    ),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'Books • Notes • Quotes • Documents',
                    style: TextStyle(
                      color: softText,
                      fontSize: 12,
                      fontWeight: FontWeight.w300,
                      letterSpacing: .4,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: const [
                      _HeroAction(
                        icon: Icons.menu_book_outlined,
                        label: 'Read',
                      ),
                      SizedBox(width: 22),
                      _HeroAction(
                        icon: Icons.format_list_bulleted_rounded,
                        label: 'Organize',
                      ),
                      SizedBox(width: 22),
                      _HeroAction(
                        icon: Icons.bookmark_border_rounded,
                        label: 'Save',
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _searchBox({
    required String hint,
    bool dark = false,
  }) {
    return Container(
      height: 52,
      padding:
          const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: dark
            ? const Color(0xFF221812).withOpacity(.96)
            : const Color(0xFF2D211A).withOpacity(.92),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: const Color(0xFF49382D),
          width: .7,
        ),
      ),
      child: Row(
        children: [
          const Icon(
            Icons.search_rounded,
            color: softGold,
            size: 21,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              hint,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: softText,
                fontSize: 13,
                fontWeight: FontWeight.w300,
              ),
            ),
          ),
          const Icon(
            Icons.tune_rounded,
            color: softGold,
            size: 19,
          ),
        ],
      ),
    );
  }

  Widget _sectionHeader({
    required String title,
    required String action,
  }) {
    return Row(
      children: [
        Expanded(
          child: Text(
            title,
            style: const TextStyle(
              color: creamText,
              fontSize: 20,
              fontWeight: FontWeight.w300,
              letterSpacing: -.2,
            ),
          ),
        ),
        Text(
          action,
          style: const TextStyle(
            color: gold,
            fontSize: 12,
            fontWeight: FontWeight.w300,
          ),
        ),
        const SizedBox(width: 4),
        const Icon(
          Icons.chevron_right_rounded,
          color: gold,
          size: 20,
        ),
      ],
    );
  }

  Widget _sectionIconRow(BuildContext context) {
    final items = [
      _LibraryItem(
        'Books',
        'Your personal book shelf.',
        Icons.menu_book_outlined,
      ),
      _LibraryItem(
        'Audiobooks',
        'Listen and track audio learning.',
        Icons.headphones_outlined,
      ),
      _LibraryItem(
        'Documents',
        'Manually added from other spaces.',
        Icons.description_outlined,
      ),
      _LibraryItem(
        'Notes',
        'Reading notes and reflections.',
        Icons.edit_note_outlined,
      ),
      _LibraryItem(
        'Bookmarks',
        'Saved reading spots.',
        Icons.bookmark_border,
      ),
      _LibraryItem(
        'Quotes',
        'Wisdom and reminders.',
        Icons.format_quote,
      ),
    ];

    return SizedBox(
      height: 92,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        itemCount: items.length,
        separatorBuilder: (_, __) {
          return const SizedBox(width: 16);
        },
        itemBuilder: (context, index) {
          final item = items[index];

          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => LibrarySectionScreen(
                    title: item.title,
                    subtitle: item.subtitle,
                    icon: item.icon,
                  ),
                ),
              );
            },
            child: SizedBox(
              width: 70,
              child: Column(
                children: [
                  Container(
                    height: 56,
                    width: 56,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: const Color(0xFF2D211A)
                          .withOpacity(.96),
                      border: Border.all(
                        color: const Color(0xFF4B392C),
                        width: .7,
                      ),
                    ),
                    child: Icon(
                      item.icon,
                      color: softGold,
                      size: 24,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    item.title,
                    maxLines: 1,
                    overflow:
                        TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: creamText,
                      fontSize: 11,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _collectionPreviewRow(BuildContext context) {
    final collections = [
      _CollectionPreview(
        title: 'Nursing School',
        items: '24 items',
        image: 'assets/images/spaces/school.jpg',
      ),
      _CollectionPreview(
        title: 'Business & Money',
        items: '18 items',
        image: 'assets/images/spaces/business.jpg',
      ),
      _CollectionPreview(
        title: 'Spiritual Growth',
        items: '31 items',
        image: 'assets/images/spaces/spiritual.jpg',
      ),
    ];

    return SizedBox(
      height: 108,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        itemCount: collections.length,
        separatorBuilder: (_, __) {
          return const SizedBox(width: 12);
        },
        itemBuilder: (context, index) {
          final item = collections[index];

          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) =>
                      LibraryCollectionScreen(
                    title: item.title,
                  ),
                ),
              );
            },
            child: Container(
              width: 178,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: const Color(0xFF211813)
                    .withOpacity(.90),
                borderRadius:
                    BorderRadius.circular(18),
                border: Border.all(
                  color: const Color(0xFF4A382B),
                  width: .7,
                ),
              ),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius:
                        BorderRadius.circular(12),
                    child: Image.asset(
                      item.image,
                      width: 58,
                      height: 78,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      mainAxisAlignment:
                          MainAxisAlignment.center,
                      crossAxisAlignment:
                          CrossAxisAlignment.start,
                      children: [
                        Text(
                          item.title,
                          maxLines: 2,
                          overflow:
                              TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: creamText,
                            fontSize: 12,
                            fontWeight: FontWeight.w300,
                            height: 1.25,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          item.items,
                          style: const TextStyle(
                            color: mutedText,
                            fontSize: 11,
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
        },
      ),
    );
  }

  Widget _addFromSpacesCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color:
            const Color(0xFF211813).withOpacity(.88),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: const Color(0xFF4A382B),
          width: .7,
        ),
      ),
      child: Row(
        crossAxisAlignment:
            CrossAxisAlignment.start,
        children: [
          Container(
            height: 44,
            width: 44,
            decoration: BoxDecoration(
              color: const Color(0xFF2F231C),
              borderRadius: BorderRadius.circular(15),
            ),
            child: const Icon(
              Icons.add_link_outlined,
              color: softGold,
              size: 22,
            ),
          ),
          const SizedBox(width: 14),
          const Expanded(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                Text(
                  'Manual Add Only',
                  style: TextStyle(
                    color: creamText,
                    fontSize: 15,
                    fontWeight: FontWeight.w300,
                    letterSpacing: -.1,
                  ),
                ),
                SizedBox(height: 7),
                Text(
                  'Files from other spaces stay where they are unless you choose “Add to Library.”',
                  style: TextStyle(
                    color: softText,
                    fontSize: 12,
                    fontWeight: FontWeight.w300,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _bookshelfSection({
    required String title,
    required List<_BookDisplay> books,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: const Color(0xFF140D09),
        border: Border.all(
          color: const Color(0xFF3A271B),
          width: .8,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.28),
            blurRadius: 20,
            offset: const Offset(0, 12),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            height: 38,
            padding:
                const EdgeInsets.symmetric(horizontal: 16),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xFF1A100B),
                  Color(0xFF372214),
                  Color(0xFF1A100B),
                ],
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    title,
                    style: const TextStyle(
                      color: creamText,
                      fontSize: 14,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ),
                const Text(
                  'View All',
                  style: TextStyle(
                    color: softGold,
                    fontSize: 11,
                    fontWeight: FontWeight.w300,
                  ),
                ),
                const SizedBox(width: 4),
                const Icon(
                  Icons.chevron_right_rounded,
                  color: softGold,
                  size: 18,
                ),
              ],
            ),
          ),
          Container(
            height: 176,
            padding: const EdgeInsets.fromLTRB(
              14,
              18,
              14,
              14,
            ),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xFF2B1B11),
                  Color(0xFF120B07),
                ],
              ),
            ),
            child: Stack(
              children: [
                Positioned(
                  left: 0,
                  right: 0,
                  top: 0,
                  child: Row(
                    mainAxisAlignment:
                        MainAxisAlignment.spaceAround,
                    children: List.generate(
                      4,
                      (_) => Container(
                        height: 4,
                        width: 28,
                        decoration: BoxDecoration(
                          color:
                              const Color(0xFFE8C178)
                                  .withOpacity(.75),
                          borderRadius:
                              BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color:
                                  const Color(0xFFE8C178)
                                      .withOpacity(.70),
                              blurRadius: 14,
                              spreadRadius: 3,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment:
                      MainAxisAlignment.spaceBetween,
                  crossAxisAlignment:
                      CrossAxisAlignment.end,
                  children: books.map((book) {
                    return _bookCover(book);
                  }).toList(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _bookCover(_BookDisplay book) {
    return SizedBox(
      width: 76,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            height: 112,
            width: 68,
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: book.color,
              borderRadius: BorderRadius.circular(4),
              border: Border.all(
                color: Colors.white.withOpacity(.18),
                width: .7,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(.55),
                  blurRadius: 12,
                  offset: const Offset(0, 8),
                ),
                BoxShadow(
                  color: gold.withOpacity(.18),
                  blurRadius: 8,
                  offset: const Offset(0, -2),
                ),
              ],
            ),
            child: Column(
              mainAxisAlignment:
                  MainAxisAlignment.center,
              children: [
                Text(
                  book.title,
                  textAlign: TextAlign.center,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: book.textColor,
                    fontSize: 12,
                    fontWeight: FontWeight.w300,
                    height: 1.05,
                  ),
                ),
                if (book.author.isNotEmpty) ...[
                  const SizedBox(height: 8),
                  Text(
                    book.author,
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    overflow:
                        TextOverflow.ellipsis,
                    style: TextStyle(
                      color:
                          book.textColor.withOpacity(.82),
                      fontSize: 7,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ],
              ],
            ),
          ),
          const SizedBox(height: 8),
          Container(
            height: 2,
            width: 62,
            alignment: Alignment.centerLeft,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(.16),
              borderRadius: BorderRadius.circular(6),
            ),
            child: FractionallySizedBox(
              widthFactor:
                  _progressToDouble(book.progress),
              child: Container(
                decoration: BoxDecoration(
                  color: gold,
                  borderRadius:
                      BorderRadius.circular(6),
                ),
              ),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            book.progress,
            style: const TextStyle(
              color: gold,
              fontSize: 10,
              fontWeight: FontWeight.w300,
            ),
          ),
        ],
      ),
    );
  }

  double _progressToDouble(String progress) {
    final cleaned = progress.replaceAll('%', '');
    final parsed = double.tryParse(cleaned) ?? 0;
    return (parsed / 100).clamp(0, 1);
  }
}

class _HeroAction extends StatelessWidget {
  final IconData icon;
  final String label;

  const _HeroAction({
    required this.icon,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          color: _LibraryScreenState.gold,
          size: 17,
        ),
        const SizedBox(width: 7),
        Text(
          label,
          style: const TextStyle(
            color: _LibraryScreenState.softGold,
            fontSize: 12,
            fontWeight: FontWeight.w300,
          ),
        ),
      ],
    );
  }
}

class _LibraryItem {
  final String title;
  final String subtitle;
  final IconData icon;

  const _LibraryItem(
    this.title,
    this.subtitle,
    this.icon,
  );
}

class _CollectionPreview {
  final String title;
  final String items;
  final String image;

  const _CollectionPreview({
    required this.title,
    required this.items,
    required this.image,
  });
}

class _BookDisplay {
  final String title;
  final String author;
  final Color color;
  final Color textColor;
  final String progress;

  const _BookDisplay({
    required this.title,
    required this.author,
    required this.color,
    required this.textColor,
    required this.progress,
  });
}

class _LibraryTheme {
  final String name;
  final String imagePath;

  const _LibraryTheme({
    required this.name,
    required this.imagePath,
  });
}