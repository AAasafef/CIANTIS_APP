import 'package:flutter/material.dart';

import '../../models/search_result_item.dart';
import '../../services/global_search_service.dart';

import '../../widgets/ciantis_side_drawer.dart';
import '../../widgets/grid_menu.dart';
import '../../widgets/spaces_bottom_nav_bar.dart';

import '../calendar/calendar_screen.dart';
import '../settings/settings_screen.dart';
import '../shared/coming_soon_screen.dart';
import '../spaces/spaces_screen.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({
    super.key,
  });

  @override
  State<SearchScreen> createState() =>
      _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController searchController =
      TextEditingController();

  final ScrollController scrollController =
      ScrollController();

  bool showBottomNav = true;

  List<SearchResultItem> results = [];

  @override
  void initState() {
    super.initState();

    results = GlobalSearchService.instance.recent();

    searchController.addListener(_runSearch);

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

  void _runSearch() {
    setState(() {
      results = GlobalSearchService.instance.search(
        searchController.text,
      );
    });
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

  @override
  void dispose() {
    searchController.removeListener(_runSearch);
    searchController.dispose();
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final query = searchController.text.trim();

    return Scaffold(
      backgroundColor: const Color(0xFFF4EFE8),
      drawer: const CiantisSideDrawer(),
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
      body: SafeArea(
        child: SingleChildScrollView(
          controller: scrollController,
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.fromLTRB(
            24,
            20,
            24,
            128,
          ),
          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.start,
            children: [
              const Text(
                'Search',
                style: TextStyle(
                  fontSize: 48,
                  height: .95,
                  fontWeight: FontWeight.w300,
                  letterSpacing: -1.6,
                  color: Color(0xFF241D18),
                ),
              ),

              const SizedBox(height: 10),

              const Text(
                'FIND ANYTHING IN CIANTIS',
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w300,
                  letterSpacing: 3.2,
                  color: Color(0xFF8B7D72),
                ),
              ),

              const SizedBox(height: 24),

              Container(
                height: 52,
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFFFBF8F4)
                      .withOpacity(.72),
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(
                    color: const Color(0xFFE2D8CD),
                    width: .7,
                  ),
                ),
                child: Row(
                  children: [
                    const Icon(
                      Icons.search_rounded,
                      color: Color(0xFF8B7D72),
                      size: 21,
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: TextField(
                        controller: searchController,
                        cursorColor: const Color(0xFF241D18),
                        style: const TextStyle(
                          color: Color(0xFF241D18),
                          fontSize: 15,
                          fontWeight: FontWeight.w300,
                        ),
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText:
                              'Search quietly...',
                          hintStyle: TextStyle(
                            color: Color(0xFF9A8D83),
                            fontSize: 15,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                      ),
                    ),
                    if (query.isNotEmpty)
                      GestureDetector(
                        onTap: () {
                          searchController.clear();
                        },
                        child: const Icon(
                          Icons.close_rounded,
                          color: Color(0xFF8B7D72),
                          size: 20,
                        ),
                      ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              Text(
                query.isEmpty
                    ? 'Recent'
                    : '${results.length} Result${results.length == 1 ? '' : 's'}',
                style: const TextStyle(
                  color: Color(0xFF241D18),
                  fontSize: 22,
                  fontWeight: FontWeight.w300,
                  letterSpacing: -.4,
                ),
              ),

              const SizedBox(height: 14),

              if (results.isEmpty)
                const _EmptySearchState()
              else
                Column(
                  children: results.map((item) {
                    return Padding(
                      padding:
                          const EdgeInsets.only(bottom: 12),
                      child: _SearchResultTile(
                        item: item,
                      ),
                    );
                  }).toList(),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _EmptySearchState extends StatelessWidget {
  const _EmptySearchState();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(
        24,
        34,
        24,
        34,
      ),
      decoration: BoxDecoration(
        color: const Color(0xFFFBF8F4)
            .withOpacity(.68),
        borderRadius: BorderRadius.circular(28),
        border: Border.all(
          color: const Color(0xFFE2D8CD),
          width: .7,
        ),
      ),
      child: Column(
        children: [
          Container(
            height: 54,
            width: 54,
            decoration: BoxDecoration(
              color: const Color(0xFFF0E6DB)
                  .withOpacity(.82),
              borderRadius: BorderRadius.circular(18),
            ),
            child: const Icon(
              Icons.search_rounded,
              color: Color(0xFF8B6F55),
              size: 25,
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'Nothing found',
            style: TextStyle(
              color: Color(0xFF241D18),
              fontSize: 21,
              fontWeight: FontWeight.w300,
              letterSpacing: -.3,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'As you add documents, notes, calendar items, clients, goals, and space activity, they will become searchable here.',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Color(0xFF6F6258),
              fontSize: 13,
              fontWeight: FontWeight.w300,
              height: 1.45,
            ),
          ),
        ],
      ),
    );
  }
}

class _SearchResultTile extends StatelessWidget {
  final SearchResultItem item;

  const _SearchResultTile({
    required this.item,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: const Color(0xFFFBF8F4)
            .withOpacity(.76),
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
              color: const Color(0xFFF0E6DB)
                  .withOpacity(.88),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Icon(
              _iconForSource(item.sourceType),
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
                  item.title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Color(0xFF241D18),
                    fontSize: 16,
                    fontWeight: FontWeight.w300,
                    letterSpacing: -.1,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  item.subtitle,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Color(0xFF6F6258),
                    fontSize: 12,
                    fontWeight: FontWeight.w300,
                    height: 1.35,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  '${item.spaceName} · ${item.sourceType}',
                  style: const TextStyle(
                    color: Color(0xFF8B7D72),
                    fontSize: 10,
                    fontWeight: FontWeight.w300,
                    letterSpacing: 1.3,
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
    );
  }

  static IconData _iconForSource(String sourceType) {
    switch (sourceType) {
      case 'document':
        return Icons.folder_copy_outlined;
      case 'calendar':
        return Icons.calendar_month_outlined;
      case 'client':
        return Icons.person_outline_rounded;
      case 'goal':
        return Icons.flag_outlined;
      case 'journal':
        return Icons.edit_note_rounded;
      case 'activity':
        return Icons.timeline_rounded;
      case 'notification':
        return Icons.notifications_none_rounded;
      default:
        return Icons.search_rounded;
    }
  }
}