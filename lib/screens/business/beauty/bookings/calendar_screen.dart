import 'package:flutter/material.dart';

import '../../../../widgets/ciantis_text_side_menu.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({
    super.key,
  });

  @override
  State<CalendarScreen> createState() =>
      _CalendarScreenState();
}

class _CalendarScreenState
    extends State<CalendarScreen> {
  String selectedCategory = 'Calendar';
  String selectedSubCategory = 'All';

  final Map<String, List<String>> drawerTabs = {
    'Dashboard': [],
    'Calendar': [
      'Today',
      'This Week',
      'This Month',
      'Availability',
    ],
    'Bookings': [
      'Upcoming',
      'Pending',
      'Completed',
      'Cancelled',
    ],
    'Clients': [
      'New Clients',
      'Returning Clients',
      'VIP Clients',
      'Model Calls',
    ],
    'Services': [
      'Hair',
      'Nails',
      'Pedicures',
      'Classes',
      'Consultations',
    ],
    'Payments': [
      'Deposits',
      'Balances',
      'Invoices',
      'Refunds',
    ],
    'Reminders': [
      'Prep Reminders',
      'Deposit Reminders',
      'Follow Ups',
    ],
    'Settings': [
      'Time Blocks',
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
        title: 'Calendar',
        subtitle: 'BEAUTY BOOKINGS',
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
                140,
              ),
              sliver: SliverList(
                delegate: SliverChildListDelegate(
                  [
                    Row(
                      children: [
                        Builder(
                          builder: (context) {
                            return GestureDetector(
                              onTap: () {
                                Scaffold.of(context)
                                    .openDrawer();
                              },
                              child: Container(
                                height: 52,
                                width: 52,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius:
                                      BorderRadius.circular(20),
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
                            'Calendar',
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
                      'View your beauty appointments, availability, client prep, deposits, and scheduling flow.',
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
                        crossAxisAlignment:
                            CrossAxisAlignment.start,
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
                            'Schedule Overview',
                            style: TextStyle(
                              fontSize: 34,
                              fontWeight: FontWeight.w300,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 14),
                          Text(
                            'Keep track of appointment timing, open slots, client arrival flow, and follow-up reminders.',
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
                                  title: 'Today',
                                  value: '0',
                                  icon: Icons.today_outlined,
                                ),
                              ),
                              const SizedBox(width: 14),
                              Expanded(
                                child: _statCard(
                                  title: 'Week',
                                  value: '0',
                                  icon: Icons.view_week_outlined,
                                ),
                              ),
                            ],
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
                        crossAxisAlignment:
                            CrossAxisAlignment.start,
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
                          const SizedBox(height: 18),
                          _scheduleRow(
                            time: '9:00 AM',
                            title: 'Open Slot',
                            subtitle: 'Available for booking',
                          ),
                          const SizedBox(height: 14),
                          _scheduleRow(
                            time: '12:00 PM',
                            title: 'Open Slot',
                            subtitle: 'Available for booking',
                          ),
                          const SizedBox(height: 14),
                          _scheduleRow(
                            time: '3:00 PM',
                            title: 'Open Slot',
                            subtitle: 'Available for booking',
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 28),
                    GridView.count(
                      shrinkWrap: true,
                      physics:
                          const NeverScrollableScrollPhysics(),
                      crossAxisCount: 2,
                      mainAxisSpacing: 16,
                      crossAxisSpacing: 16,
                      childAspectRatio: .98,
                      children: [
                        _featureCard(
                          title: 'Add Slot',
                          subtitle: 'Create availability',
                          icon: Icons.add_circle_outline,
                        ),
                        _featureCard(
                          title: 'New Booking',
                          subtitle: 'Schedule a client',
                          icon: Icons.event_available_outlined,
                        ),
                        _featureCard(
                          title: 'Reminders',
                          subtitle: 'Prep and follow ups',
                          icon: Icons.notifications_none_rounded,
                        ),
                        _featureCard(
                          title: 'Payments',
                          subtitle: 'Deposits and balances',
                          icon: Icons.payments_outlined,
                        ),
                      ],
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

  Widget _scheduleRow({
    required String time,
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
          SizedBox(
            width: 74,
            child: Text(
              time,
              style: const TextStyle(
                fontSize: 13,
                color: Color(0xFF7A6452),
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const SizedBox(width: 12),
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
                const SizedBox(height: 5),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.black.withOpacity(.55),
                  ),
                ),
              ],
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
        crossAxisAlignment:
            CrossAxisAlignment.start,
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