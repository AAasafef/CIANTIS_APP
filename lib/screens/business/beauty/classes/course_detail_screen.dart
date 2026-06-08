import 'package:flutter/material.dart';

import '../../../../widgets/ciantis_text_side_menu.dart';

class CourseDetailScreen extends StatefulWidget {
  const CourseDetailScreen({
    super.key,
  });

  @override
  State<CourseDetailScreen> createState() =>
      _CourseDetailScreenState();
}

class _CourseDetailScreenState extends State<CourseDetailScreen> {
  String selectedCategory = 'Course Details';
  String selectedSubCategory = 'All';

  final Map<String, List<String>> drawerTabs = {
    'Dashboard': [],
    'Course Details': [
      'Overview',
      'Pricing',
      'Duration',
      'Requirements',
    ],
    'Curriculum': [
      'Theory',
      'Demo',
      'Hands-On',
      'Sanitation',
      'Aftercare',
    ],
    'Kits': [
      'Included Items',
      'Student Supplies',
      'Tools',
      'Restock List',
    ],
    'Students': [
      'Enrolled',
      'Deposits Paid',
      'Balances Due',
      'Completed',
    ],
    'Model Calls': [
      'Required Models',
      'Approved Models',
      'Pending Models',
      'Model Rules',
    ],
    'Certificates': [
      'Certificate Template',
      'Issued',
      'Pending',
    ],
    'Policies': [
      'Class Rules',
      'Deposit Policy',
      'Cancellation Policy',
      'Refund Policy',
    ],
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4EFE8),
      drawerEnableOpenDragGesture: true,
      drawer: CiantisTextSideMenu(
        title: 'Course',
        subtitle: 'CLASS DETAILS',
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
                            'Course Details',
                            style: TextStyle(
                              fontSize: 38,
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
                      'Build and organize your luxury class details, curriculum, kit, pricing, policies, and student expectations.',
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
                            'CLASS BLUEPRINT',
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 13,
                              letterSpacing: 3,
                            ),
                          ),
                          const SizedBox(height: 12),
                          const Text(
                            'Luxury Training Setup',
                            style: TextStyle(
                              fontSize: 34,
                              fontWeight: FontWeight.w300,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 14),
                          Text(
                            'Keep every course organized so students understand what they are learning, what is included, and what is expected.',
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
                                  title: 'Hours',
                                  value: '6–8',
                                  icon: Icons.schedule_outlined,
                                ),
                              ),
                              const SizedBox(width: 14),
                              Expanded(
                                child: _statCard(
                                  title: 'Deposit',
                                  value: 'Req.',
                                  icon: Icons.payments_outlined,
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
                        _featureCard(
                          title: 'Curriculum',
                          subtitle: 'Theory, demo, hands-on',
                          icon: Icons.menu_book_outlined,
                        ),
                        _featureCard(
                          title: 'Kit',
                          subtitle: 'Included tools and supplies',
                          icon: Icons.inventory_2_outlined,
                        ),
                        _featureCard(
                          title: 'Pricing',
                          subtitle: 'Deposit, balance, value',
                          icon: Icons.attach_money_rounded,
                        ),
                        _featureCard(
                          title: 'Certificate',
                          subtitle: 'Completion proof',
                          icon: Icons.workspace_premium_outlined,
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
                            'This section will hold editable course details, teaching notes, student expectations, kit lists, model requirements, and class policies.',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.black.withOpacity(.58),
                              height: 1.6,
                            ),
                          ),
                          const SizedBox(height: 24),
                          _actionCard(
                            icon: Icons.edit_note_outlined,
                            title: 'Edit Course Notes',
                            subtitle: 'Add curriculum, timing, and class structure.',
                          ),
                          const SizedBox(height: 14),
                          _actionCard(
                            icon: Icons.add_box_outlined,
                            title: 'Build Kit List',
                            subtitle: 'Track items included with student kits.',
                          ),
                          const SizedBox(height: 14),
                          _actionCard(
                            icon: Icons.policy_outlined,
                            title: 'Add Policies',
                            subtitle: 'Save rules, deposits, cancellations, and expectations.',
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

  Widget _actionCard({
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
              crossAxisAlignment: CrossAxisAlignment.start,
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