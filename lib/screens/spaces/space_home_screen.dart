import 'package:flutter/material.dart';

import '../../models/space_model.dart';
import '../../widgets/ciantis_text_side_menu.dart';

class SpaceHomeScreen extends StatefulWidget {
  final SpaceModel space;

  const SpaceHomeScreen({
    super.key,
    required this.space,
  });

  @override
  State<SpaceHomeScreen> createState() =>
      _SpaceHomeScreenState();
}

class _SpaceHomeScreenState extends State<SpaceHomeScreen> {
  String selectedCategory = 'Dashboard';
  String selectedSubCategory = 'All';

  late final Map<String, List<String>> drawerTabs = {
    'Dashboard': [],
    'Overview': [
      'Today',
      'Recent Activity',
      'Pinned Items',
    ],
    'Notes': [
      'All Notes',
      'Important Notes',
      'Ideas',
      'Reminders',
    ],
    'Documents': [
      'Uploaded Files',
      'Photos',
      'Receipts',
      'Records',
    ],
    'Tasks': [
      'To Do',
      'Upcoming',
      'Completed',
    ],
    'Goals': [
      'Current Goals',
      'Progress',
      'Plans',
    ],
    'Settings': [
      'Privacy / Lock',
      'Notifications',
      'Space Preferences',
    ],
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F1EA),
      drawerEnableOpenDragGesture: true,
      drawer: CiantisTextSideMenu(
        title: widget.space.title,
        subtitle: 'CIANTIS SPACE',
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
        },
      ),
      body: SafeArea(
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(
                20,
                20,
                20,
                120,
              ),
              sliver: SliverList(
                delegate: SliverChildListDelegate(
                  [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            widget.space.title,
                            style: const TextStyle(
                              fontSize: 38,
                              fontWeight: FontWeight.w300,
                              letterSpacing: -1.1,
                              color: Color(0xFF241D18),
                            ),
                          ),
                        ),
                        Builder(
                          builder: (context) {
                            return GestureDetector(
                              onTap: () {
                                Scaffold.of(context).openDrawer();
                              },
                              child: Container(
                                height: 44,
                                width: 44,
                                decoration: BoxDecoration(
                                  color: const Color(0xFFFBF8F4),
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                    color: const Color(0xFFE1D6CA),
                                    width: 0.7,
                                  ),
                                ),
                                child: const Icon(
                                  Icons.menu_rounded,
                                  color: Color(0xFF241D18),
                                  size: 22,
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Text(
                      widget.space.description,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w300,
                        height: 1.55,
                        color: Color(0xFF6F6258),
                      ),
                    ),
                    const SizedBox(height: 24),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Stack(
                        children: [
                          AspectRatio(
                            aspectRatio: 1.15,
                            child: Image.asset(
                              widget.space.imagePath,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Positioned.fill(
                            child: Container(
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [
                                    Colors.black.withOpacity(.05),
                                    Colors.black.withOpacity(.58),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            left: 18,
                            right: 18,
                            bottom: 18,
                            child: Row(
                              children: [
                                Icon(
                                  widget.space.icon,
                                  color: Colors.white,
                                  size: 28,
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Text(
                                    widget.space.title,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 28,
                                      fontWeight: FontWeight.w300,
                                      letterSpacing: -.7,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                    _sectionCard(
                      title: selectedSubCategory == 'All'
                          ? selectedCategory
                          : selectedSubCategory,
                      subtitle:
                          'This area will hold the tools, notes, files, logs, and planning features connected to this space.',
                      icon: Icons.dashboard_customize_outlined,
                    ),
                    const SizedBox(height: 14),
                    _actionCard(
                      title: 'Add Entry',
                      subtitle: 'Create a new note, log, task, or saved item.',
                      icon: Icons.add_rounded,
                    ),
                    const SizedBox(height: 14),
                    _actionCard(
                      title: 'Upload File',
                      subtitle: 'Attach documents, images, records, or receipts.',
                      icon: Icons.upload_file_outlined,
                    ),
                    const SizedBox(height: 14),
                    _actionCard(
                      title: 'View Activity',
                      subtitle: 'See recent updates connected to this space.',
                      icon: Icons.history_rounded,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _sectionCard({
    required String title,
    required String subtitle,
    required IconData icon,
  }) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: const Color(0xFFFBF8F4),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: const Color(0xFFE1D6CA),
          width: 0.7,
        ),
      ),
      child: Row(
        children: [
          Icon(
            icon,
            color: const Color(0xFF8E6F55),
            size: 28,
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w300,
                    color: Color(0xFF241D18),
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  subtitle,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w300,
                    height: 1.45,
                    color: Color(0xFF6F6258),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _actionCard({
    required String title,
    required String subtitle,
    required IconData icon,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFFBF8F4),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: const Color(0xFFE1D6CA),
          width: 0.7,
        ),
      ),
      child: Row(
        children: [
          Container(
            height: 42,
            width: 42,
            decoration: BoxDecoration(
              color: const Color(0xFFF3ECE4),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              icon,
              color: const Color(0xFF8E6F55),
              size: 21,
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w300,
                    color: Color(0xFF241D18),
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  subtitle,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w300,
                    height: 1.35,
                    color: Color(0xFF6F6258),
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
}