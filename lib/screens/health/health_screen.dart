import 'package:flutter/material.dart';

import '../../widgets/ciantis_text_side_menu.dart';
import 'period_screen.dart';

class HealthScreen extends StatefulWidget {
  const HealthScreen({
    super.key,
  });

  @override
  State<HealthScreen> createState() => _HealthScreenState();
}

class _HealthScreenState extends State<HealthScreen> {
  String selectedCategory = 'Dashboard';

  String selectedSubCategory = 'All';

  final Map<String, List<String>> drawerTabs = {
    'Dashboard': [],
    'Main Health': [
      'Health Overview',
      'Daily Check-In',
    ],
    'Body & Wellness': [
      'Weight Tracker',
      'Measurements',
      'Symptoms',
      'Cycle / Hormones',
      'Skin / Hair / Nails',
    ],
    'Food & Nutrition': [
      'Meal Log',
      'Water Tracker',
      'Grocery / Meal Plans',
      'Supplements',
      'Recipes',
    ],
    'Fitness': [
      'Workouts',
      'Stretching',
      'Walking / Steps',
      'Progress Photos',
    ],
    'Medical': [
      'Medications',
      'Appointments',
      'Lab Results',
      'Medical Documents',
      'Doctors / Contacts',
      'Conditions / Diagnoses',
    ],
    'Mental & Spiritual Wellness': [
      'Mood Tracker',
      'Stress / Anxiety',
      'Sleep',
      'Prayer / Reflection',
      'Journaling',
    ],
    'Goals & Reports': [
      'Health Goals',
      'Progress Reports',
      'Export Health Data',
    ],
    'Health Settings': [
      'Reminders',
      'Privacy / Lock',
      'Units',
      'Connected Devices',
    ],
  };

  void _handleSubTabSelected(String category, String subCategory) {
    setState(() {
      selectedCategory = category;
      selectedSubCategory = subCategory;
    });

    if (subCategory == 'Cycle / Hormones') {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => const PeriodScreen(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4EFE8),
      drawerEnableOpenDragGesture: true,
      drawer: CiantisTextSideMenu(
        title: 'Health',
        subtitle: 'WELLNESS SPACE',
        drawerTabs: drawerTabs,
        selectedCategory: selectedCategory,
        selectedSubCategory: selectedSubCategory,
        onMainTabSelected: (category) {
          setState(() {
            selectedCategory = category;
            selectedSubCategory = 'All';
          });
        },
        onSubTabSelected: _handleSubTabSelected,
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
                140,
              ),
              sliver: SliverList(
                delegate: SliverChildListDelegate(
                  [
                    Row(
                      children: [
                        const Expanded(
                          child: Text(
                            'Health',
                            style: TextStyle(
                              fontSize: 40,
                              fontWeight: FontWeight.w300,
                              letterSpacing: -1,
                              color: Color(0xFF2D241D),
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
                                height: 52,
                                width: 52,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(
                                    20,
                                  ),
                                ),
                                child: const Icon(
                                  Icons.menu_rounded,
                                  color: Color(0xFF2D241D),
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 14),
                    Text(
                      'Your private wellness operating system.',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.black.withOpacity(.58),
                        height: 1.6,
                      ),
                    ),
                    const SizedBox(height: 28),
                    Container(
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        gradient: const LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            Color(0xFFD8C6B8),
                            Color(0xFFB59D8B),
                          ],
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'TODAY',
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 13,
                              letterSpacing: 3,
                            ),
                          ),
                          const SizedBox(height: 12),
                          const Text(
                            'Wellness Overview',
                            style: TextStyle(
                              fontSize: 34,
                              fontWeight: FontWeight.w300,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 14),
                          Text(
                            'Track health, nutrition, movement, symptoms, medications, progress, and long-term wellness in one private space.',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.white.withOpacity(.82),
                              height: 1.7,
                            ),
                          ),
                          const SizedBox(height: 30),
                          Row(
                            children: [
                              Expanded(
                                child: _quickStatCard(
                                  title: 'Water',
                                  value: '64oz',
                                  icon: Icons.water_drop_outlined,
                                ),
                              ),
                              const SizedBox(width: 14),
                              Expanded(
                                child: _quickStatCard(
                                  title: 'Sleep',
                                  value: '7.5h',
                                  icon: Icons.dark_mode_outlined,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 14),
                          Row(
                            children: [
                              Expanded(
                                child: _quickStatCard(
                                  title: 'Steps',
                                  value: '4,820',
                                  icon: Icons.directions_walk,
                                ),
                              ),
                              const SizedBox(width: 14),
                              Expanded(
                                child: _quickStatCard(
                                  title: 'Mood',
                                  value: 'Calm',
                                  icon: Icons.spa_outlined,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 28),
                    GridView.count(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      crossAxisCount: 2,
                      mainAxisSpacing: 16,
                      crossAxisSpacing: 16,
                      childAspectRatio: .98,
                      children: [
                        _healthFeatureCard(
                          title: 'Nutrition',
                          subtitle:
                              'Meals, supplements, recipes, hydration',
                          icon: Icons.restaurant_menu_outlined,
                        ),
                        _healthFeatureCard(
                          title: 'Fitness',
                          subtitle:
                              'Workouts, steps, movement, progress',
                          icon: Icons.fitness_center_outlined,
                        ),
                        _healthFeatureCard(
                          title: 'Medical',
                          subtitle:
                              'Medications, records, appointments',
                          icon: Icons.local_hospital_outlined,
                        ),
                        _healthFeatureCard(
                          title: 'Cycle',
                          subtitle:
                              'Period, symptoms, flow, reminders',
                          icon: Icons.female,
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const PeriodScreen(),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 28),
                    Container(
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            selectedSubCategory == 'All'
                                ? selectedCategory
                                : selectedSubCategory,
                            style: const TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.w300,
                              color: Color(0xFF2D241D),
                            ),
                          ),
                          const SizedBox(height: 12),
                          Text(
                            'This section will hold your trackers, notes, logs, documents, reminders, and personal health records.',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.black.withOpacity(.58),
                              height: 1.6,
                            ),
                          ),
                          const SizedBox(height: 24),
                          _sectionActionCard(
                            icon: Icons.add_circle_outline,
                            title: 'Add Entry',
                            subtitle:
                                'Log something new for this health section.',
                          ),
                          const SizedBox(height: 14),
                          _sectionActionCard(
                            icon: Icons.insights_outlined,
                            title: 'View Trends',
                            subtitle:
                                'See patterns, progress, and changes over time.',
                          ),
                          const SizedBox(height: 14),
                          _sectionActionCard(
                            icon: Icons.folder_copy_outlined,
                            title: 'Upload Records',
                            subtitle:
                                'Attach documents, photos, labs, or notes.',
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 28),
                    Container(
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'AI Wellness Assistant',
                            style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.w300,
                              color: Color(0xFF2D241D),
                            ),
                          ),
                          const SizedBox(height: 14),
                          Text(
                            'Future AI tools will help identify trends, organize medical records, summarize symptoms, suggest routines, and connect wellness patterns over time.',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.black.withOpacity(.58),
                              height: 1.7,
                            ),
                          ),
                          const SizedBox(height: 24),
                          Container(
                            padding: const EdgeInsets.all(18),
                            decoration: BoxDecoration(
                              color: const Color(0xFFF4EFE8),
                              borderRadius: BorderRadius.circular(24),
                            ),
                            child: Row(
                              children: [
                                Container(
                                  height: 52,
                                  width: 52,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(
                                      18,
                                    ),
                                  ),
                                  child: const Icon(
                                    Icons.auto_awesome,
                                    color: Color(0xFF8A6B57),
                                  ),
                                ),
                                const SizedBox(width: 16),
                                Expanded(
                                  child: Text(
                                    'Personalized health intelligence coming later.',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.black.withOpacity(.58),
                                      height: 1.6,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
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

  Widget _quickStatCard({
    required String title,
    required String value,
    required IconData icon,
  }) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(.14),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            icon,
            color: Colors.white,
          ),
          const SizedBox(height: 18),
          Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.w300,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            title,
            style: TextStyle(
              color: Colors.white.withOpacity(.75),
              fontSize: 13,
            ),
          ),
        ],
      ),
    );
  }

  Widget _healthFeatureCard({
    required String title,
    required String subtitle,
    required IconData icon,
    VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(22),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 56,
              width: 56,
              decoration: BoxDecoration(
                color: const Color(0xFFF4EFE8),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Icon(
                icon,
                color: const Color(0xFF7A6452),
              ),
            ),
            const Spacer(),
            Text(
              title,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w300,
                color: Color(0xFF2D241D),
              ),
            ),
            const SizedBox(height: 10),
            Text(
              subtitle,
              style: TextStyle(
                fontSize: 13,
                color: Colors.black.withOpacity(.58),
                height: 1.5,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _sectionActionCard({
    required IconData icon,
    required String title,
    required String subtitle,
  }) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: const Color(0xFFF4EFE8),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Row(
        children: [
          Container(
            height: 52,
            width: 52,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(18),
            ),
            child: Icon(
              icon,
              color: const Color(0xFF7A6452),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w400,
                    color: Color(0xFF2D241D),
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.black.withOpacity(.55),
                    height: 1.45,
                  ),
                ),
              ],
            ),
          ),
          const Icon(
            Icons.arrow_forward_ios_rounded,
            size: 16,
            color: Color(0xFFB08D6D),
          ),
        ],
      ),
    );
  }
}