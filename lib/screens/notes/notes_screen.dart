import 'package:flutter/material.dart';

import '../../widgets/ciantis_side_drawer.dart';

class NotesScreen extends StatefulWidget {
  final String spaceId;
  final String spaceName;
  final String? linkedItemId;

  const NotesScreen({
    super.key,
    required this.spaceId,
    required this.spaceName,
    this.linkedItemId,
  });

  @override
  State<NotesScreen> createState() => _NotesScreenState();
}

class _NotesScreenState extends State<NotesScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: const CiantisSideDrawer(),
      endDrawer: const _NotebookDrawer(),
      backgroundColor: const Color(0xFFF8F6F3),

      floatingActionButton: FloatingActionButton.extended(
        elevation: 0,
        backgroundColor: const Color(0xFF26211D),
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Page Editor coming in Phase 1 Step 5'),
            ),
          );
        },
        icon: const Icon(Icons.add_rounded),
        label: const Text('New Note'),
      ),

      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/images/spaces/library.jpg',
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) {
                return Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Color(0xFFF6F4F1),
                        Color(0xFFEFE9E2),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),

          Positioned.fill(
            child: Container(
              color: Colors.white.withOpacity(.72),
            ),
          ),

          SafeArea(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(
                24,
                20,
                24,
                120,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      _TopButton(
                        icon: Icons.menu_rounded,
                        onTap: () {
                          _scaffoldKey.currentState?.openDrawer();
                        },
                      ),

                      const Spacer(),

                      _TopButton(
                        icon: Icons.search_rounded,
                        onTap: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                'Search arrives in Phase 2',
                              ),
                            ),
                          );
                        },
                      ),

                      const SizedBox(width: 10),

                      _TopButton(
                        icon: Icons.view_sidebar_outlined,
                        onTap: () {
                          _scaffoldKey.currentState?.openEndDrawer();
                        },
                      ),
                    ],
                  ),

                  const Spacer(),

                  const Text(
                    'Notes',
                    style: TextStyle(
                      fontSize: 56,
                      fontWeight: FontWeight.w300,
                      color: Color(0xFF26211D),
                      letterSpacing: -2,
                      height: .95,
                    ),
                  ),

                  const SizedBox(height: 12),

                  const Text(
                    'UNIVERSAL NOTES',
                    style: TextStyle(
                      fontSize: 11,
                      letterSpacing: 4,
                      color: Color(0xFF8E847B),
                      fontWeight: FontWeight.w300,
                    ),
                  ),

                  const SizedBox(height: 20),

                  Container(
                    width: 240,
                    height: 1,
                    color: const Color(0xFFDDD4CB),
                  ),

                  const SizedBox(height: 20),

                  const Text(
                    'Capture thoughts, ideas, study notes, prayers, client notes, plans, and inspiration across every CIANTIS space.',
                    style: TextStyle(
                      color: Color(0xFF5F554C),
                      height: 1.7,
                      fontSize: 14,
                      fontWeight: FontWeight.w300,
                    ),
                  ),

                  const SizedBox(height: 28),

                  GestureDetector(
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                            'Notebook system arrives in Phase 1 Step 2',
                          ),
                        ),
                      );
                    },
                    child: const Text(
                      'Open Notebook Collection →',
                      style: TextStyle(
                        color: Color(0xFF9D7D58),
                        fontSize: 13,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ),

                  const Spacer(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _NotebookDrawer extends StatelessWidget {
  const _NotebookDrawer();

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: const Color(0xFFF8F6F3),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Collection',
                style: TextStyle(
                  fontSize: 38,
                  fontWeight: FontWeight.w300,
                  color: Color(0xFF26211D),
                  letterSpacing: -1,
                ),
              ),

              const SizedBox(height: 10),

              const Text(
                'NOTEBOOKS',
                style: TextStyle(
                  fontSize: 10,
                  letterSpacing: 3,
                  color: Color(0xFF8E847B),
                ),
              ),

              const SizedBox(height: 30),

              _DrawerItem(
                icon: Icons.menu_book_outlined,
                title: 'Notebooks',
              ),

              _DrawerItem(
                icon: Icons.star_border_rounded,
                title: 'Favorites',
              ),

              _DrawerItem(
                icon: Icons.push_pin_outlined,
                title: 'Pinned',
              ),

              _DrawerItem(
                icon: Icons.archive_outlined,
                title: 'Archive',
              ),

              _DrawerItem(
                icon: Icons.delete_outline_rounded,
                title: 'Deleted Notes',
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _DrawerItem extends StatelessWidget {
  final IconData icon;
  final String title;

  const _DrawerItem({
    required this.icon,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(.70),
        borderRadius: BorderRadius.circular(22),
      ),
      child: Row(
        children: [
          Icon(
            icon,
            color: const Color(0xFF6B6157),
          ),
          const SizedBox(width: 14),
          Text(
            title,
            style: const TextStyle(
              color: Color(0xFF26211D),
              fontWeight: FontWeight.w300,
              fontSize: 15,
            ),
          ),
        ],
      ),
    );
  }
}

class _TopButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const _TopButton({
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(18),
      onTap: onTap,
      child: Container(
        width: 48,
        height: 48,
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(.75),
          borderRadius: BorderRadius.circular(18),
        ),
        child: Icon(
          icon,
          color: const Color(0xFF26211D),
        ),
      ),
    );
  }
}