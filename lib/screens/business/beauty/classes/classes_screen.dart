import 'package:flutter/material.dart';

import '../../../../widgets/ciantis_text_side_menu.dart';

import 'course_detail_screen.dart';
import 'model_call_screen.dart';
import 'student_management_screen.dart';

class ClassesScreen extends StatefulWidget {
  const ClassesScreen({
    super.key,
  });

  @override
  State<ClassesScreen> createState() =>
      _ClassesScreenState();
}

class _ClassesScreenState extends State<ClassesScreen> {
  String selectedCategory = 'Dashboard';
  String selectedSubCategory = 'All';

  final Map<String, List<String>> drawerTabs = {
    'Dashboard': [],
    'Classes': [
      'I-Tip Install',
      'K-Tip Install',
      'Tape-Ins',
      'Sew-Ins',
      'Silk Press',
    ],
    'Students': [
      'New Students',
      'Active Students',
      'Completed Students',
      'Follow Ups',
    ],
    'Courses': [
      'Course Details',
      'Curriculum',
      'Kits',
      'Certificates',
    ],
    'Model Calls': [
      'Hair Models',
      'Nail Models',
      'Approved Models',
      'Pending Models',
    ],
    'Payments': [
      'Deposits',
      'Balances',
      'Paid in Full',
      'Invoices',
    ],
    'Policies': [
      'Class Rules',
      'Deposit Policy',
      'Cancellation Policy',
      'Refund Policy',
    ],
    'Settings': [
      'Reminders',
      'Privacy / Lock',
      'Export',
    ],
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4EFE8),
      drawerEnableOpenDragGesture: true,
      drawer: CiantisTextSideMenu(
        title: 'Classes',
        subtitle: 'BEAUTY EDUCATION',
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
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 140),
              sliver: SliverList(
                delegate: SliverChildListDelegate(
                  [
                    Row(
                      children: [
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
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: const Icon(
                                  Icons.menu_rounded,
                                  color: Color(0xFF2D241D),
                                ),
                              ),
                            );
                          },
                        ),
                        const SizedBox(width: 16),
                        const Expanded(
                          child: Text(
                            'Classes',
                            style: TextStyle(
                              fontSize: 40,
                              fontWeight: FontWeight.w300,
                              letterSpacing: -1,
                              color: Color(0xFF2D241D),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 14),
                    Text(
                      'Manage beauty training, students, course details, model calls, kits, and payments.',
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
                            'TRAINING',
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 13,
                              letterSpacing: 3,
                            ),
                          ),
                          const SizedBox(height: 12),
                          const Text(
                            'Class Overview',
                            style: TextStyle(
                              fontSize: 34,
                              fontWeight: FontWeight.w300,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 14),
                          Text(
                            'Organize luxury hair extension classes, students, kits, models, policies, and class income.',
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
                                child: _statCard(
                                  title: 'Courses',
                                  value: '5',
                                  icon: Icons.school_outlined,
                                ),
                              ),
                              const SizedBox(width: 14),
                              Expanded(
                                child: _statCard(
                                  title: 'Students',
                                  value: '0',
                                  icon: Icons.people_outline,
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
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const CourseDetailScreen(),
                              ),
                            );
                          },
                          child: _featureCard(
                            title: 'Course Details',
                            subtitle: 'Curriculum, kit, pricing',
                            icon: Icons.menu_book_outlined,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const StudentManagementScreen(),
                              ),
                            );
                          },
                          child: _featureCard(
                            title: 'Students',
                            subtitle: 'Manage student records',
                            icon: Icons.groups_outlined,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const ModelCallScreen(),
                              ),
                            );
                          },
                          child: _featureCard(
                            title: 'Model Calls',
                            subtitle: 'Models for class practice',
                            icon: Icons.face_retouching_natural_outlined,
                          ),
                        ),
                        _featureCard(
                          title: 'Payments',
                          subtitle: 'Deposits and balances',
                          icon: Icons.payments_outlined,
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
                            'This section will hold class details, training notes, student records, kits, models, payments, and reminders.',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.black.withOpacity(.58),
                              height: 1.6,
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

  Widget _statCard({
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
          Icon(icon, color: Colors.white),
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

  Widget _featureCard({
    required String title,
    required String subtitle,
    required IconData icon,
  }) {
    return Container(
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
    );
  }
}