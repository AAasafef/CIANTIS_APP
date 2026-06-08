import 'package:flutter/material.dart';

import '../../../../widgets/ciantis_side_drawer.dart';
import '../../../../widgets/grid_menu.dart';
import '../../../../widgets/spaces_bottom_nav_bar.dart';

import '../../../calendar/calendar_screen.dart';
import '../../../settings/settings_screen.dart';
import '../../../shared/coming_soon_screen.dart';
import '../../../spaces/spaces_screen.dart';

import 'client_profile_screen.dart';

class ClientListScreen extends StatefulWidget {
  const ClientListScreen({super.key});

  @override
  State<ClientListScreen> createState() => _ClientListScreenState();
}

class _ClientListScreenState extends State<ClientListScreen> {
  final ScrollController scrollController = ScrollController();

  bool showBottomNav = true;

  @override
  void initState() {
    super.initState();

    scrollController.addListener(() {
      final direction = scrollController.position.userScrollDirection;

      if (direction.toString().contains('reverse') && showBottomNav) {
        setState(() {
          showBottomNav = false;
        });
      }

      if (direction.toString().contains('forward') && !showBottomNav) {
        setState(() {
          showBottomNav = true;
        });
      }
    });
  }

  @override
  void dispose() {
    scrollController.dispose();
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

  void _openClientProfile() {
    _openScreen(
      const ClientProfileScreen(),
    );
  }

  void _openComingSoon(String title, IconData icon) {
    _openScreen(
      ComingSoonScreen(
        title: title,
        subtitle: '$title will connect here later.',
        icon: icon,
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
      _openComingSoon(
        'AI',
        Icons.auto_awesome_rounded,
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
  Widget build(BuildContext context) {
    final isTablet = MediaQuery.of(context).size.width >= 760;

    return Scaffold(
      drawer: const CiantisSideDrawer(),
      backgroundColor: const Color(0xFFF4EFE8),
      extendBody: true,
      bottomNavigationBar: AnimatedSlide(
        duration: const Duration(milliseconds: 260),
        curve: Curves.easeOutCubic,
        offset: showBottomNav ? Offset.zero : const Offset(0, 1.25),
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
        child: isTablet
            ? _TabletLayout(
                onOpenClientProfile: _openClientProfile,
                onOpenComingSoon: _openComingSoon,
              )
            : _PhoneLayout(
                controller: scrollController,
                onOpenClientProfile: _openClientProfile,
                onOpenComingSoon: _openComingSoon,
              ),
      ),
    );
  }
}

class _PhoneLayout extends StatelessWidget {
  final ScrollController controller;
  final VoidCallback onOpenClientProfile;
  final void Function(String title, IconData icon) onOpenComingSoon;

  const _PhoneLayout({
    required this.controller,
    required this.onOpenClientProfile,
    required this.onOpenComingSoon,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: controller,
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.fromLTRB(24, 24, 24, 128),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _Header(
            onAddClient: onOpenClientProfile,
          ),
          const SizedBox(height: 22),
          const _SearchBar(),
          const SizedBox(height: 18),
          _QuickActions(
            onOpenClientProfile: onOpenClientProfile,
            onOpenComingSoon: onOpenComingSoon,
          ),
          const SizedBox(height: 26),
          const _SectionTitle('Client Book'),
          const SizedBox(height: 12),
          _EmptyClientState(
            onOpenClientProfile: onOpenClientProfile,
            onOpenComingSoon: onOpenComingSoon,
          ),
          const SizedBox(height: 26),
          const _SectionTitle('Client Profile Preview'),
          const SizedBox(height: 12),
          _ClientProfilePreview(
            onOpenClientProfile: onOpenClientProfile,
          ),
          const SizedBox(height: 26),
          const _SectionTitle('Business Tools'),
          const SizedBox(height: 12),
          _BusinessToolGrid(
            onOpenComingSoon: onOpenComingSoon,
          ),
        ],
      ),
    );
  }
}

class _TabletLayout extends StatelessWidget {
  final VoidCallback onOpenClientProfile;
  final void Function(String title, IconData icon) onOpenComingSoon;

  const _TabletLayout({
    required this.onOpenClientProfile,
    required this.onOpenComingSoon,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 320,
          padding: const EdgeInsets.fromLTRB(22, 24, 18, 24),
          decoration: const BoxDecoration(
            color: Color(0xFFF8F4EE),
            border: Border(
              right: BorderSide(
                color: Color(0xFFE2D8CD),
                width: .8,
              ),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _Header(
                compact: true,
                onAddClient: onOpenClientProfile,
              ),
              const SizedBox(height: 18),
              const _SearchBar(),
              const SizedBox(height: 18),
              _QuickActions(
                vertical: true,
                onOpenClientProfile: onOpenClientProfile,
                onOpenComingSoon: onOpenComingSoon,
              ),
              const SizedBox(height: 24),
              const _SectionTitle('Contacts'),
              const SizedBox(height: 12),
              Expanded(
                child: _EmptyContactPanel(
                  onOpenClientProfile: onOpenClientProfile,
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.fromLTRB(28, 24, 28, 120),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _TabletProfileHeader(
                  onOpenClientProfile: onOpenClientProfile,
                ),
                const SizedBox(height: 22),
                const _ProfileDashboardGrid(),
                const SizedBox(height: 24),
                _ClientDetailSections(
                  onOpenClientProfile: onOpenClientProfile,
                ),
                const SizedBox(height: 24),
                const _AiSummaryPanel(),
                const SizedBox(height: 24),
                _BusinessToolGrid(
                  onOpenComingSoon: onOpenComingSoon,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _Header extends StatelessWidget {
  final bool compact;
  final VoidCallback onAddClient;

  const _Header({
    required this.onAddClient,
    this.compact = false,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Builder(
          builder: (context) {
            return GestureDetector(
              onTap: () {
                Scaffold.of(context).openDrawer();
              },
              child: const _IconButtonBox(
                icon: Icons.menu_rounded,
              ),
            );
          },
        ),
        const SizedBox(width: 14),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                compact ? 'Clients' : 'Client Book',
                style: TextStyle(
                  fontSize: compact ? 34 : 42,
                  height: .98,
                  fontWeight: FontWeight.w300,
                  letterSpacing: -1.2,
                  color: const Color(0xFF241D18),
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'BUSINESS CONTACT CENTER',
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w300,
                  letterSpacing: 2.5,
                  color: Color(0xFF8B7D72),
                ),
              ),
            ],
          ),
        ),
        GestureDetector(
          onTap: onAddClient,
          child: const _IconButtonBox(
            icon: Icons.add_rounded,
          ),
        ),
      ],
    );
  }
}

class _SearchBar extends StatelessWidget {
  const _SearchBar();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 52,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: const Color(0xFFFBF8F4).withOpacity(.94),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: const Color(0xFFE2D8CD),
          width: .8,
        ),
      ),
      child: const Row(
        children: [
          Icon(
            Icons.search_rounded,
            color: Color(0xFF8B6F55),
            size: 21,
          ),
          SizedBox(width: 12),
          Expanded(
            child: Text(
              'Search clients, phone, service, notes...',
              style: TextStyle(
                color: Color(0xFF8B7D72),
                fontSize: 13,
                fontWeight: FontWeight.w300,
              ),
            ),
          ),
          Icon(
            Icons.tune_rounded,
            color: Color(0xFF9A8D83),
            size: 19,
          ),
        ],
      ),
    );
  }
}

class _QuickActions extends StatelessWidget {
  final bool vertical;
  final VoidCallback onOpenClientProfile;
  final void Function(String title, IconData icon) onOpenComingSoon;

  const _QuickActions({
    required this.onOpenClientProfile,
    required this.onOpenComingSoon,
    this.vertical = false,
  });

  @override
  Widget build(BuildContext context) {
    final items = [
      _QuickActionData(
        Icons.person_add_alt_1_outlined,
        'Add Client',
        onOpenClientProfile,
      ),
      _QuickActionData(
        Icons.download_outlined,
        'Import',
        () {
          onOpenComingSoon(
            'Import Clients',
            Icons.download_outlined,
          );
        },
      ),
      _QuickActionData(
        Icons.sms_outlined,
        'Messages',
        () {
          onOpenComingSoon(
            'Messages',
            Icons.sms_outlined,
          );
        },
      ),
      _QuickActionData(
        Icons.event_available_outlined,
        'Bookings',
        () {
          onOpenComingSoon(
            'Bookings',
            Icons.event_available_outlined,
          );
        },
      ),
    ];

    if (vertical) {
      return Column(
        children: items.map((item) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: _QuickActionCard(
              item: item,
              fullWidth: true,
            ),
          );
        }).toList(),
      );
    }

    return SizedBox(
      height: 92,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        itemCount: items.length,
        separatorBuilder: (_, __) {
          return const SizedBox(width: 12);
        },
        itemBuilder: (context, index) {
          return _QuickActionCard(
            item: items[index],
          );
        },
      ),
    );
  }
}

class _QuickActionCard extends StatelessWidget {
  final _QuickActionData item;
  final bool fullWidth;

  const _QuickActionCard({
    required this.item,
    this.fullWidth = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: item.onTap,
      child: Container(
        width: fullWidth ? double.infinity : 132,
        height: 82,
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: const Color(0xFFFBF8F4),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: const Color(0xFFE2D8CD),
            width: .8,
          ),
        ),
        child: Row(
          children: [
            Icon(
              item.icon,
              color: const Color(0xFF8B6F55),
              size: 22,
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                item.title,
                style: const TextStyle(
                  color: Color(0xFF241D18),
                  fontSize: 13,
                  fontWeight: FontWeight.w300,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _EmptyClientState extends StatelessWidget {
  final VoidCallback onOpenClientProfile;
  final void Function(String title, IconData icon) onOpenComingSoon;

  const _EmptyClientState({
    required this.onOpenClientProfile,
    required this.onOpenComingSoon,
  });

  @override
  Widget build(BuildContext context) {
    return _Panel(
      child: Column(
        children: [
          Container(
            height: 72,
            width: 72,
            decoration: BoxDecoration(
              color: const Color(0xFFF0E6DB),
              borderRadius: BorderRadius.circular(24),
            ),
            child: const Icon(
              Icons.people_outline_rounded,
              color: Color(0xFF8B6F55),
              size: 30,
            ),
          ),
          const SizedBox(height: 18),
          const Text(
            'No clients added yet',
            style: TextStyle(
              color: Color(0xFF241D18),
              fontSize: 23,
              fontWeight: FontWeight.w300,
              letterSpacing: -.4,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Add clients manually or import them later from your phone contacts, Booksy, Vagaro, StyleSeat, Square, Shopify, or CSV.',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Color(0xFF6F6258),
              fontSize: 13,
              height: 1.45,
              fontWeight: FontWeight.w300,
            ),
          ),
          const SizedBox(height: 20),
          GestureDetector(
            onTap: onOpenClientProfile,
            child: const _PrimaryButton(
              label: 'Add First Client',
              icon: Icons.add_rounded,
            ),
          ),
          const SizedBox(height: 10),
          GestureDetector(
            onTap: () {
              onOpenComingSoon(
                'Import Clients',
                Icons.file_download_outlined,
              );
            },
            child: const _SecondaryButton(
              label: 'Import Clients Later',
              icon: Icons.file_download_outlined,
            ),
          ),
        ],
      ),
    );
  }
}

class _EmptyContactPanel extends StatelessWidget {
  final VoidCallback onOpenClientProfile;

  const _EmptyContactPanel({
    required this.onOpenClientProfile,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onOpenClientProfile,
      child: const _Panel(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.contacts_outlined,
              color: Color(0xFF8B6F55),
              size: 42,
            ),
            SizedBox(height: 16),
            Text(
              'No contacts yet',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Color(0xFF241D18),
                fontSize: 22,
                fontWeight: FontWeight.w300,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Your imported and saved clients will appear here.',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Color(0xFF6F6258),
                fontSize: 13,
                height: 1.4,
                fontWeight: FontWeight.w300,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TabletProfileHeader extends StatelessWidget {
  final VoidCallback onOpenClientProfile;

  const _TabletProfileHeader({
    required this.onOpenClientProfile,
  });

  @override
  Widget build(BuildContext context) {
    return _Panel(
      child: Row(
        children: [
          Container(
            height: 96,
            width: 96,
            decoration: BoxDecoration(
              color: const Color(0xFFF0E6DB),
              borderRadius: BorderRadius.circular(28),
              border: Border.all(
                color: const Color(0xFFE2D8CD),
                width: .8,
              ),
            ),
            child: const Icon(
              Icons.person_outline_rounded,
              color: Color(0xFF8B6F55),
              size: 36,
            ),
          ),
          const SizedBox(width: 22),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Client Profile',
                  style: TextStyle(
                    color: Color(0xFF241D18),
                    fontSize: 34,
                    height: 1,
                    fontWeight: FontWeight.w300,
                    letterSpacing: -1,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  'Select or add a client to begin building their full profile.',
                  style: TextStyle(
                    color: Color(0xFF6F6258),
                    fontSize: 14,
                    height: 1.4,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 16),
          GestureDetector(
            onTap: onOpenClientProfile,
            child: const _PrimaryButton(
              label: 'Add Client',
              icon: Icons.add_rounded,
              compact: true,
            ),
          ),
        ],
      ),
    );
  }
}

class _ClientProfilePreview extends StatelessWidget {
  final VoidCallback onOpenClientProfile;

  const _ClientProfilePreview({
    required this.onOpenClientProfile,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onOpenClientProfile,
      child: const _Panel(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _ProfileSection(
              title: 'Identity',
              icon: Icons.person_outline_rounded,
            ),
            _ProfileSection(
              title: 'Contact Information',
              icon: Icons.call_outlined,
            ),
            _ProfileSection(
              title: 'Booking Profile',
              icon: Icons.event_note_outlined,
            ),
            _ProfileSection(
              title: 'Hair Profile',
              icon: Icons.face_retouching_natural_outlined,
            ),
            _ProfileSection(
              title: 'Hair Health',
              icon: Icons.eco_outlined,
            ),
            _ProfileSection(
              title: 'Extension Readiness',
              icon: Icons.extension_outlined,
            ),
            _ProfileSection(
              title: 'Skin Profile',
              icon: Icons.spa_outlined,
            ),
            _ProfileSection(
              title: 'Nail Profile',
              icon: Icons.pan_tool_alt_outlined,
            ),
            _ProfileSection(
              title: 'Medical / Safety',
              icon: Icons.health_and_safety_outlined,
            ),
            _ProfileSection(
              title: 'Client Behavior Notes',
              icon: Icons.psychology_outlined,
            ),
            _ProfileSection(
              title: 'Policies & Consent',
              icon: Icons.verified_user_outlined,
            ),
            _ProfileSection(
              title: 'Photos & Documents',
              icon: Icons.photo_library_outlined,
            ),
            _ProfileSection(
              title: 'Messages',
              icon: Icons.sms_outlined,
            ),
            _ProfileSection(
              title: 'Activity Log',
              icon: Icons.timeline_outlined,
            ),
          ],
        ),
      ),
    );
  }
}

class _ProfileDashboardGrid extends StatelessWidget {
  const _ProfileDashboardGrid();

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: MediaQuery.of(context).size.width > 1050 ? 4 : 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      mainAxisSpacing: 12,
      crossAxisSpacing: 12,
      childAspectRatio: 2.5,
      children: const [
        _DashboardMetric(
          title: 'Client Type',
          value: 'Not Set',
        ),
        _DashboardMetric(
          title: 'Lifetime Value',
          value: '\$0',
        ),
        _DashboardMetric(
          title: 'Next Appointment',
          value: 'None',
        ),
        _DashboardMetric(
          title: 'AI Summary',
          value: 'Not Created',
        ),
      ],
    );
  }
}

class _ClientDetailSections extends StatelessWidget {
  final VoidCallback onOpenClientProfile;

  const _ClientDetailSections({
    required this.onOpenClientProfile,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onOpenClientProfile,
      child: const _Panel(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _SectionTitle('Full Client Record'),
            SizedBox(height: 12),
            _ProfileSection(
              title: 'Name, phone, email, birthday, address',
              icon: Icons.badge_outlined,
            ),
            _ProfileSection(
              title: 'Preferred contact method and reminders',
              icon: Icons.notifications_none_rounded,
            ),
            _ProfileSection(
              title: 'Emergency contact and trusted contact',
              icon: Icons.contact_phone_outlined,
            ),
            _ProfileSection(
              title: 'Booking habits, lateness, cancellation history',
              icon: Icons.event_busy_outlined,
            ),
            _ProfileSection(
              title: 'Deposit status, balance due, refund notes',
              icon: Icons.payments_outlined,
            ),
            _ProfileSection(
              title: 'Hair texture, density, length, porosity, elasticity',
              icon: Icons.face_retouching_natural_rounded,
            ),
            _ProfileSection(
              title: 'Damage, shedding, breakage, scalp condition',
              icon: Icons.eco_outlined,
            ),
            _ProfileSection(
              title: 'Install history, tension tolerance, maintenance habits',
              icon: Icons.extension_rounded,
            ),
            _ProfileSection(
              title: 'Skin sensitivity, allergies, adhesive reactions',
              icon: Icons.spa_rounded,
            ),
            _ProfileSection(
              title: 'Natural nail health, pedicure concerns, Gel-X history',
              icon: Icons.back_hand_outlined,
            ),
            _ProfileSection(
              title: 'Products used, formulas, color history',
              icon: Icons.science_outlined,
            ),
            _ProfileSection(
              title: 'Waivers, photo consent, model consent, policies',
              icon: Icons.verified_outlined,
            ),
          ],
        ),
      ),
    );
  }
}

class _AiSummaryPanel extends StatelessWidget {
  const _AiSummaryPanel();

  @override
  Widget build(BuildContext context) {
    return const _Panel(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  'AI Client Summary',
                  style: TextStyle(
                    color: Color(0xFF241D18),
                    fontSize: 24,
                    fontWeight: FontWeight.w300,
                    letterSpacing: -.4,
                  ),
                ),
              ),
              _PrimaryButton(
                label: 'Refresh',
                icon: Icons.refresh_rounded,
                compact: true,
              ),
            ],
          ),
          SizedBox(height: 14),
          Text(
            'Once client details are added, Ciantis will refresh this summary based on the saved profile, service history, notes, appointments, photos, messages, and activity log.',
            style: TextStyle(
              color: Color(0xFF6F6258),
              fontSize: 14,
              height: 1.5,
              fontWeight: FontWeight.w300,
            ),
          ),
        ],
      ),
    );
  }
}

class _BusinessToolGrid extends StatelessWidget {
  final void Function(String title, IconData icon) onOpenComingSoon;

  const _BusinessToolGrid({
    required this.onOpenComingSoon,
  });

  @override
  Widget build(BuildContext context) {
    final tools = [
      _ToolData(
        Icons.sms_outlined,
        'Messages',
      ),
      _ToolData(
        Icons.call_outlined,
        'Calls',
      ),
      _ToolData(
        Icons.calendar_month_outlined,
        'Appointments',
      ),
      _ToolData(
        Icons.payments_outlined,
        'Deposits',
      ),
      _ToolData(
        Icons.receipt_long_outlined,
        'Invoices',
      ),
      _ToolData(
        Icons.photo_library_outlined,
        'Photos',
      ),
      _ToolData(
        Icons.assignment_outlined,
        'Forms',
      ),
      _ToolData(
        Icons.history_rounded,
        'Activity',
      ),
      _ToolData(
        Icons.file_download_outlined,
        'Imports',
      ),
      _ToolData(
        Icons.file_upload_outlined,
        'Exports',
      ),
      _ToolData(
        Icons.storefront_outlined,
        'Booksy',
      ),
      _ToolData(
        Icons.business_center_outlined,
        'Vagaro',
      ),
      _ToolData(
        Icons.chair_outlined,
        'StyleSeat',
      ),
      _ToolData(
        Icons.shopping_bag_outlined,
        'Shopify',
      ),
      _ToolData(
        Icons.square_outlined,
        'Square',
      ),
      _ToolData(
        Icons.auto_awesome_rounded,
        'AI Tools',
      ),
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: tools.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: MediaQuery.of(context).size.width >= 950 ? 4 : 2,
        mainAxisSpacing: 12,
        crossAxisSpacing: 12,
        childAspectRatio: 2.6,
      ),
      itemBuilder: (context, index) {
        final tool = tools[index];

        return GestureDetector(
          onTap: () {
            onOpenComingSoon(
              tool.title,
              tool.icon,
            );
          },
          child: _ToolCard(
            tool: tool,
          ),
        );
      },
    );
  }
}

class _ToolCard extends StatelessWidget {
  final _ToolData tool;

  const _ToolCard({
    required this.tool,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFFFBF8F4),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: const Color(0xFFE2D8CD),
          width: .8,
        ),
      ),
      child: Row(
        children: [
          Icon(
            tool.icon,
            color: const Color(0xFF8B6F55),
            size: 22,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              tool.title,
              style: const TextStyle(
                color: Color(0xFF241D18),
                fontSize: 13,
                fontWeight: FontWeight.w300,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ProfileSection extends StatelessWidget {
  final String title;
  final IconData icon;

  const _ProfileSection({
    required this.title,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(
        minHeight: 52,
      ),
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.symmetric(
        horizontal: 14,
        vertical: 12,
      ),
      decoration: BoxDecoration(
        color: const Color(0xFFF8F4EE),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: const Color(0xFFE2D8CD),
          width: .7,
        ),
      ),
      child: Row(
        children: [
          Icon(
            icon,
            color: const Color(0xFF8B6F55),
            size: 20,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                color: Color(0xFF241D18),
                fontSize: 14,
                fontWeight: FontWeight.w300,
                height: 1.3,
              ),
            ),
          ),
          const Icon(
            Icons.chevron_right_rounded,
            color: Color(0xFF9A8D83),
          ),
        ],
      ),
    );
  }
}

class _DashboardMetric extends StatelessWidget {
  final String title;
  final String value;

  const _DashboardMetric({
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return _Panel(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title.toUpperCase(),
            style: const TextStyle(
              color: Color(0xFF8B7D72),
              fontSize: 9,
              letterSpacing: 1.8,
              fontWeight: FontWeight.w300,
            ),
          ),
          const Spacer(),
          Text(
            value,
            style: const TextStyle(
              color: Color(0xFF241D18),
              fontSize: 20,
              fontWeight: FontWeight.w300,
              letterSpacing: -.3,
            ),
          ),
        ],
      ),
    );
  }
}

class _PrimaryButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool compact;

  const _PrimaryButton({
    required this.label,
    required this.icon,
    this.compact = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: compact ? 42 : 50,
      padding: EdgeInsets.symmetric(
        horizontal: compact ? 14 : 18,
      ),
      decoration: BoxDecoration(
        color: const Color(0xFF2B2118),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisSize: compact ? MainAxisSize.min : MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: const Color(0xFFF8F4EE),
            size: 18,
          ),
          const SizedBox(width: 8),
          Text(
            label,
            style: const TextStyle(
              color: Color(0xFFF8F4EE),
              fontSize: 13,
              fontWeight: FontWeight.w300,
            ),
          ),
        ],
      ),
    );
  }
}

class _SecondaryButton extends StatelessWidget {
  final String label;
  final IconData icon;

  const _SecondaryButton({
    required this.label,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      padding: const EdgeInsets.symmetric(
        horizontal: 18,
      ),
      decoration: BoxDecoration(
        color: const Color(0xFFFBF8F4),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: const Color(0xFFE2D8CD),
          width: .8,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: const Color(0xFF8B6F55),
            size: 18,
          ),
          const SizedBox(width: 8),
          Text(
            label,
            style: const TextStyle(
              color: Color(0xFF241D18),
              fontSize: 13,
              fontWeight: FontWeight.w300,
            ),
          ),
        ],
      ),
    );
  }
}

class _IconButtonBox extends StatelessWidget {
  final IconData icon;

  const _IconButtonBox({
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      width: 48,
      decoration: BoxDecoration(
        color: const Color(0xFFFBF8F4).withOpacity(.92),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: const Color(0xFFE2D8CD),
          width: .7,
        ),
      ),
      child: Icon(
        icon,
        color: const Color(0xFF241D18),
        size: 22,
      ),
    );
  }
}

class _Panel extends StatelessWidget {
  final Widget child;
  final EdgeInsets padding;

  const _Panel({
    required this.child,
    this.padding = const EdgeInsets.all(18),
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: padding,
      decoration: BoxDecoration(
        color: const Color(0xFFFBF8F4).withOpacity(.92),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: const Color(0xFFE2D8CD),
          width: .7,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.025),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: child,
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String text;

  const _SectionTitle(this.text);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        color: Color(0xFF241D18),
        fontSize: 22,
        fontWeight: FontWeight.w300,
        letterSpacing: -.4,
      ),
    );
  }
}

class _QuickActionData {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  const _QuickActionData(
    this.icon,
    this.title,
    this.onTap,
  );
}

class _ToolData {
  final IconData icon;
  final String title;

  const _ToolData(
    this.icon,
    this.title,
  );
}
