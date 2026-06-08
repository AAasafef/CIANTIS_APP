import 'package:flutter/material.dart';

import '../../../../widgets/ciantis_text_side_menu.dart';

class StudentManagementScreen extends StatefulWidget {
  const StudentManagementScreen({
    super.key,
  });

  @override
  State<StudentManagementScreen> createState() =>
      _StudentManagementScreenState();
}

class _StudentManagementScreenState
    extends State<StudentManagementScreen> {
  String selectedCategory = 'Students';
  String selectedSubCategory = 'All';

  final Map<String, List<String>> drawerTabs = {
    'Dashboard': [],
    'Students': [
      'New Students',
      'Active Students',
      'Completed Students',
      'Follow Ups',
    ],
    'Enrollment': [
      'Applications',
      'Deposits Paid',
      'Balances Due',
      'Agreements',
    ],
    'Class Progress': [
      'Theory',
      'Demo',
      'Hands-On',
      'Practice',
      'Completed',
    ],
    'Payments': [
      'Deposits',
      'Balances',
      'Paid in Full',
      'Invoices',
    ],
    'Certificates': [
      'Ready to Issue',
      'Issued',
      'Pending',
      'Reprint',
    ],
    'Communication': [
      'Messages',
      'Reminders',
      'Follow Ups',
      'Notes',
    ],
    'Settings': [
      'Privacy / Lock',
      'Export',
      'Templates',
    ],
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4EFE8),
      drawerEnableOpenDragGesture: true,
      drawer: CiantisTextSideMenu(
        title: 'Students',
        subtitle: 'CLASS MANAGEMENT',
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
                            'Students',
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
                      'Manage student records, deposits, progress, certificates, communication, and follow-up support.',
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
                            'STUDENTS',
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 13,
                              letterSpacing: 3,
                            ),
                          ),
                          const SizedBox(height: 12),
                          const Text(
                            'Student Overview',
                            style: TextStyle(
                              fontSize: 34,
                              fontWeight: FontWeight.w300,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 14),
                          Text(
                            'Keep every student organized from inquiry to class day, certificate, and post-class follow-up.',
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
                                  title: 'Active',
                                  value: '0',
                                  icon: Icons.school_outlined,
                                ),
                              ),
                              const SizedBox(width: 14),
                              Expanded(
                                child: _statCard(
                                  title: 'Completed',
                                  value: '0',
                                  icon: Icons.workspace_premium_outlined,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 14),
                          Row(
                            children: [
                              Expanded(
                                child: _statCard(
                                  title: 'Balances',
                                  value: '\$0',
                                  icon: Icons.payments_outlined,
                                ),
                              ),
                              const SizedBox(width: 14),
                              Expanded(
                                child: _statCard(
                                  title: 'Follow Ups',
                                  value: '0',
                                  icon: Icons.notifications_none_rounded,
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
                          title: 'Add Student',
                          subtitle: 'Create student profile',
                          icon: Icons.person_add_alt_outlined,
                        ),
                        _featureCard(
                          title: 'Progress',
                          subtitle: 'Track class completion',
                          icon: Icons.timeline_outlined,
                        ),
                        _featureCard(
                          title: 'Payments',
                          subtitle: 'Deposits and balances',
                          icon: Icons.account_balance_wallet_outlined,
                        ),
                        _featureCard(
                          title: 'Certificates',
                          subtitle: 'Completion status',
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
                            'This section will hold student profiles, enrollment status, payment records, progress notes, certificates, and follow-up reminders.',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.black.withOpacity(.58),
                              height: 1.6,
                            ),
                          ),
                          const SizedBox(height: 24),
                          _actionCard(
                            icon: Icons.add_rounded,
                            title: 'Add Student Record',
                            subtitle: 'Track name, class, deposit, and progress.',
                          ),
                          const SizedBox(height: 14),
                          _actionCard(
                            icon: Icons.checklist_outlined,
                            title: 'Update Progress',
                            subtitle: 'Mark theory, demo, practice, or completion.',
                          ),
                          const SizedBox(height: 14),
                          _actionCard(
                            icon: Icons.message_outlined,
                            title: 'Add Follow-Up Note',
                            subtitle: 'Save reminders, messages, and support notes.',
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