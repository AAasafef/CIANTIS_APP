import 'package:flutter/material.dart';

import '../../../../widgets/ciantis_side_drawer.dart';
import '../../../../widgets/grid_menu.dart';
import '../../../../widgets/spaces_bottom_nav_bar.dart';

import '../../../calendar/calendar_screen.dart';
import '../../../settings/settings_screen.dart';
import '../../../shared/coming_soon_screen.dart';
import '../../../spaces/spaces_screen.dart';

class ClientProfileScreen extends StatefulWidget {
  const ClientProfileScreen({super.key});

  @override
  State<ClientProfileScreen> createState() => _ClientProfileScreenState();
}

class _ClientProfileScreenState extends State<ClientProfileScreen> {
  final ScrollController scrollController = ScrollController();

  bool showBottomNav = true;

  @override
  void initState() {
    super.initState();

    scrollController.addListener(() {
      final direction = scrollController.position.userScrollDirection;

      if (direction.toString().contains('reverse') && showBottomNav) {
        setState(() => showBottomNav = false);
      }

      if (direction.toString().contains('forward') && !showBottomNav) {
        setState(() => showBottomNav = true);
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
      builder: (_) => const GridMenu(),
    );
  }

  void _openScreen(Widget screen) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => screen),
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
      _openScreen(const SpacesScreen());
      return;
    }

    if (index == 1) {
      _openScreen(const CalendarScreen());
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
      _openScreen(const SettingsScreen());
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
            ? _TabletProfileView(
                controller: scrollController,
                onOpenComingSoon: _openComingSoon,
              )
            : _PhoneProfileView(
                controller: scrollController,
                onOpenComingSoon: _openComingSoon,
              ),
      ),
    );
  }
}

class _PhoneProfileView extends StatelessWidget {
  final ScrollController controller;
  final void Function(String title, IconData icon) onOpenComingSoon;

  const _PhoneProfileView({
    required this.controller,
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
          _ProfileTopHeader(
            onOpenComingSoon: onOpenComingSoon,
          ),
          const SizedBox(height: 22),
          const _ClientIdentityCard(),
          const SizedBox(height: 18),
          const _ClientActionRow(),
          const SizedBox(height: 22),
          const _ProfileMetricsGrid(),
          const SizedBox(height: 26),
          const _SectionTitle('Client Record'),
          const SizedBox(height: 12),
          _ClientRecordSections(
            onOpenComingSoon: onOpenComingSoon,
          ),
          const SizedBox(height: 26),
          const _SectionTitle('AI Summary'),
          const SizedBox(height: 12),
          const _AiSummaryCard(),
          const SizedBox(height: 26),
          const _SectionTitle('Business Tools'),
          const SizedBox(height: 12),
          _BusinessToolsGrid(
            onOpenComingSoon: onOpenComingSoon,
          ),
        ],
      ),
    );
  }
}

class _TabletProfileView extends StatelessWidget {
  final ScrollController controller;
  final void Function(String title, IconData icon) onOpenComingSoon;

  const _TabletProfileView({
    required this.controller,
    required this.onOpenComingSoon,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 330,
          padding: const EdgeInsets.fromLTRB(24, 24, 20, 24),
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
              _ProfileTopHeader(
                compact: true,
                onOpenComingSoon: onOpenComingSoon,
              ),
              const SizedBox(height: 22),
              const _ClientIdentityCard(compact: true),
              const SizedBox(height: 16),
              const _ClientActionColumn(),
              const SizedBox(height: 22),
              const _ProfileMetricsGrid(compact: true),
            ],
          ),
        ),
        Expanded(
          child: SingleChildScrollView(
            controller: controller,
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.fromLTRB(30, 24, 30, 128),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const _TabletPageHeader(),
                const SizedBox(height: 24),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 7,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const _SectionTitle('Full Client Record'),
                          const SizedBox(height: 12),
                          _ClientRecordSections(
                            onOpenComingSoon: onOpenComingSoon,
                          ),
                          const SizedBox(height: 24),
                          const _SectionTitle('Business Tools'),
                          const SizedBox(height: 12),
                          _BusinessToolsGrid(
                            onOpenComingSoon: onOpenComingSoon,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 22),
                    const Expanded(
                      flex: 5,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _SectionTitle('AI Summary'),
                          SizedBox(height: 12),
                          _AiSummaryCard(),
                          SizedBox(height: 22),
                          _MessagePreviewCard(),
                          SizedBox(height: 22),
                          _ActivityPreviewCard(),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _ProfileTopHeader extends StatelessWidget {
  final bool compact;
  final void Function(String title, IconData icon) onOpenComingSoon;

  const _ProfileTopHeader({
    required this.onOpenComingSoon,
    this.compact = false,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Builder(
          builder: (context) {
            return GestureDetector(
              onTap: () => Scaffold.of(context).openDrawer(),
              child: const _IconBox(icon: Icons.menu_rounded),
            );
          },
        ),
        const SizedBox(width: 14),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Client Profile',
                style: TextStyle(
                  fontSize: 38,
                  height: .98,
                  fontWeight: FontWeight.w300,
                  letterSpacing: -1.2,
                  color: Color(0xFF241D18),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                compact ? 'CLIENT RECORD' : 'BUSINESS CLIENT RECORD',
                style: const TextStyle(
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
          onTap: () {
            onOpenComingSoon(
              'Edit Client',
              Icons.edit_outlined,
            );
          },
          child: const _IconBox(icon: Icons.edit_outlined),
        ),
      ],
    );
  }
}

class _TabletPageHeader extends StatelessWidget {
  const _TabletPageHeader();

  @override
  Widget build(BuildContext context) {
    return const _Panel(
      child: Row(
        children: [
          Expanded(
            child: Text(
              'Complete Client Profile',
              style: TextStyle(
                color: Color(0xFF241D18),
                fontSize: 34,
                height: 1,
                fontWeight: FontWeight.w300,
                letterSpacing: -1,
              ),
            ),
          ),
          SizedBox(width: 16),
          _PrimaryButton(
            label: 'Save Client',
            icon: Icons.check_rounded,
            compact: true,
          ),
        ],
      ),
    );
  }
}

class _ClientIdentityCard extends StatelessWidget {
  final bool compact;

  const _ClientIdentityCard({
    this.compact = false,
  });

  @override
  Widget build(BuildContext context) {
    return _Panel(
      child: Column(
        children: [
          Container(
            height: compact ? 94 : 112,
            width: compact ? 94 : 112,
            decoration: BoxDecoration(
              color: const Color(0xFFF0E6DB),
              borderRadius: BorderRadius.circular(30),
              border: Border.all(
                color: const Color(0xFFE2D8CD),
                width: .8,
              ),
            ),
            child: const Icon(
              Icons.person_add_alt_1_outlined,
              color: Color(0xFF8B6F55),
              size: 38,
            ),
          ),
          const SizedBox(height: 18),
          const Text(
            'No Client Selected',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Color(0xFF241D18),
              fontSize: 27,
              fontWeight: FontWeight.w300,
              letterSpacing: -.5,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Add or import a client to begin building a full profile.',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Color(0xFF6F6258),
              fontSize: 13,
              height: 1.45,
              fontWeight: FontWeight.w300,
            ),
          ),
          const SizedBox(height: 18),
          const _PrimaryButton(
            label: 'Add Client Details',
            icon: Icons.add_rounded,
          ),
        ],
      ),
    );
  }
}

class _ClientActionRow extends StatelessWidget {
  const _ClientActionRow();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: const [
        Expanded(
          child: _ActionButton(
            icon: Icons.call_outlined,
            label: 'Call',
          ),
        ),
        SizedBox(width: 10),
        Expanded(
          child: _ActionButton(
            icon: Icons.sms_outlined,
            label: 'Text',
          ),
        ),
        SizedBox(width: 10),
        Expanded(
          child: _ActionButton(
            icon: Icons.mail_outline_rounded,
            label: 'Email',
          ),
        ),
        SizedBox(width: 10),
        Expanded(
          child: _ActionButton(
            icon: Icons.chat_bubble_outline_rounded,
            label: 'Message',
          ),
        ),
      ],
    );
  }
}

class _ClientActionColumn extends StatelessWidget {
  const _ClientActionColumn();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        _ActionButton(
          icon: Icons.call_outlined,
          label: 'Call Client',
          fullWidth: true,
        ),
        SizedBox(height: 10),
        _ActionButton(
          icon: Icons.sms_outlined,
          label: 'Text Client',
          fullWidth: true,
        ),
        SizedBox(height: 10),
        _ActionButton(
          icon: Icons.mail_outline_rounded,
          label: 'Email Client',
          fullWidth: true,
        ),
        SizedBox(height: 10),
        _ActionButton(
          icon: Icons.chat_bubble_outline_rounded,
          label: 'Open Messages',
          fullWidth: true,
        ),
      ],
    );
  }
}

class _ActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool fullWidth;

  const _ActionButton({
    required this.icon,
    required this.label,
    this.fullWidth = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 58,
      width: fullWidth ? double.infinity : null,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: const Color(0xFFFBF8F4).withOpacity(.94),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: const Color(0xFFE2D8CD),
          width: .8,
        ),
      ),
      child: Row(
        mainAxisAlignment:
            fullWidth ? MainAxisAlignment.start : MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: const Color(0xFF8B6F55),
            size: 20,
          ),
          const SizedBox(width: 8),
          Flexible(
            child: Text(
              label,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: Color(0xFF241D18),
                fontSize: 12,
                fontWeight: FontWeight.w300,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ProfileMetricsGrid extends StatelessWidget {
  final bool compact;

  const _ProfileMetricsGrid({
    this.compact = false,
  });

  @override
  Widget build(BuildContext context) {
    final crossAxisCount = compact ? 2 : 2;

    return GridView.count(
      crossAxisCount: crossAxisCount,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      mainAxisSpacing: 10,
      crossAxisSpacing: 10,
      childAspectRatio: compact ? 1.55 : 2.15,
      children: const [
        _MetricTile(title: 'Client Type', value: 'Not Set'),
        _MetricTile(title: 'Lifetime Value', value: '\$0'),
        _MetricTile(title: 'Next Visit', value: 'None'),
        _MetricTile(title: 'AI Summary', value: 'Empty'),
      ],
    );
  }
}

class _MetricTile extends StatelessWidget {
  final String title;
  final String value;

  const _MetricTile({
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return _Panel(
      padding: const EdgeInsets.all(14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title.toUpperCase(),
            style: const TextStyle(
              color: Color(0xFF8B7D72),
              fontSize: 9,
              letterSpacing: 1.5,
              fontWeight: FontWeight.w300,
            ),
          ),
          const Spacer(),
          Text(
            value,
            style: const TextStyle(
              color: Color(0xFF241D18),
              fontSize: 18,
              fontWeight: FontWeight.w300,
              letterSpacing: -.2,
            ),
          ),
        ],
      ),
    );
  }
}

class _ClientRecordSections extends StatelessWidget {
  final void Function(String title, IconData icon) onOpenComingSoon;

  const _ClientRecordSections({
    required this.onOpenComingSoon,
  });

  @override
  Widget build(BuildContext context) {
    final sections = [
      _ProfileSectionData(
        'Identity',
        'Name, preferred name, birthday, occupation, profile photo, client type.',
        Icons.badge_outlined,
      ),
      _ProfileSectionData(
        'Contact Information',
        'Phone, text number, email, address, preferred contact method.',
        Icons.contact_phone_outlined,
      ),
      _ProfileSectionData(
        'Emergency Contact',
        'Emergency contact, trusted person, backup contact.',
        Icons.health_and_safety_outlined,
      ),
      _ProfileSectionData(
        'Booking Profile',
        'Preferred days, preferred times, appointment length, booking patterns.',
        Icons.event_note_outlined,
      ),
      _ProfileSectionData(
        'Client Behavior Notes',
        'Late risk, no-show risk, reschedules, communication style, boundaries.',
        Icons.psychology_outlined,
      ),
      _ProfileSectionData(
        'Hair Profile',
        'Texture, curl pattern, density, strand thickness, length, shrinkage.',
        Icons.face_retouching_natural_outlined,
      ),
      _ProfileSectionData(
        'Hair Health',
        'Porosity, elasticity, shedding, breakage, scalp health, dryness, damage.',
        Icons.eco_outlined,
      ),
      _ProfileSectionData(
        'Extension Readiness',
        'Minimum length, density, leave-out, tension tolerance, install history.',
        Icons.extension_outlined,
      ),
      _ProfileSectionData(
        'Skin Profile',
        'Skin type, sensitivity, allergies, eczema, acne, keloid tendency.',
        Icons.spa_outlined,
      ),
      _ProfileSectionData(
        'Nail Profile',
        'Natural nail health, shape, length, Gel-X history, pedicure concerns.',
        Icons.back_hand_outlined,
      ),
      _ProfileSectionData(
        'Medical / Safety',
        'Allergies, contraindications, pregnancy/postpartum, diabetes, medications.',
        Icons.medical_information_outlined,
      ),
      _ProfileSectionData(
        'Service Preferences',
        'Quiet appointment, talkative appointment, luxury experience, style preferences.',
        Icons.favorite_border_rounded,
      ),
      _ProfileSectionData(
        'Service History',
        'Past services, formulas, products used, install dates, maintenance history.',
        Icons.history_rounded,
      ),
      _ProfileSectionData(
        'Deposits & Payments',
        'Deposit status, balance due, refunds, invoices, memberships, packages.',
        Icons.payments_outlined,
      ),
      _ProfileSectionData(
        'Policies & Consent',
        'Cancellation agreement, photo consent, model consent, waiver forms.',
        Icons.verified_user_outlined,
      ),
      _ProfileSectionData(
        'Photos & Documents',
        'Before/after photos, inspiration photos, uploads, scans, client files.',
        Icons.photo_library_outlined,
      ),
      _ProfileSectionData(
        'Messages',
        'Text templates, message drafts, communication history, reminders.',
        Icons.sms_outlined,
      ),
      _ProfileSectionData(
        'AI Summary',
        'Refresh client summary from profile details, notes, photos, and activity.',
        Icons.auto_awesome_outlined,
      ),
      _ProfileSectionData(
        'Activity Log',
        'Every add, edit, import, message, appointment, payment, and change.',
        Icons.timeline_outlined,
      ),
    ];

    return _Panel(
      child: Column(
        children: sections.map((section) {
          return _ProfileSectionRow(
            section: section,
            onTap: () {
              onOpenComingSoon(
                section.title,
                section.icon,
              );
            },
          );
        }).toList(),
      ),
    );
  }
}

class _ProfileSectionRow extends StatelessWidget {
  final _ProfileSectionData section;
  final VoidCallback onTap;

  const _ProfileSectionRow({
    required this.section,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: const Color(0xFFF8F4EE),
          borderRadius: BorderRadius.circular(18),
          border: Border.all(
            color: const Color(0xFFE2D8CD),
            width: .7,
          ),
        ),
        child: Row(
          children: [
            Container(
              height: 42,
              width: 42,
              decoration: BoxDecoration(
                color: const Color(0xFFF0E6DB),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Icon(
                section.icon,
                color: const Color(0xFF8B6F55),
                size: 20,
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    section.title,
                    style: const TextStyle(
                      color: Color(0xFF241D18),
                      fontSize: 15,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    section.subtitle,
                    style: const TextStyle(
                      color: Color(0xFF6F6258),
                      fontSize: 12,
                      height: 1.35,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            const Icon(
              Icons.chevron_right_rounded,
              color: Color(0xFF9A8D83),
            ),
          ],
        ),
      ),
    );
  }
}

class _AiSummaryCard extends StatelessWidget {
  const _AiSummaryCard();

  @override
  Widget build(BuildContext context) {
    return _Panel(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
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
          SizedBox(height: 16),
          Text(
            'No AI summary yet.',
            style: TextStyle(
              color: Color(0xFF241D18),
              fontSize: 17,
              fontWeight: FontWeight.w300,
            ),
          ),
          SizedBox(height: 8),
          Text(
            'Once client details are saved, the refresh button will update this summary from the client profile, notes, appointments, photos, services, messages, payments, imports, and activity log.',
            style: TextStyle(
              color: Color(0xFF6F6258),
              fontSize: 13,
              height: 1.5,
              fontWeight: FontWeight.w300,
            ),
          ),
        ],
      ),
    );
  }
}

class _MessagePreviewCard extends StatelessWidget {
  const _MessagePreviewCard();

  @override
  Widget build(BuildContext context) {
    return const _Panel(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Messages',
            style: TextStyle(
              color: Color(0xFF241D18),
              fontSize: 22,
              fontWeight: FontWeight.w300,
              letterSpacing: -.3,
            ),
          ),
          SizedBox(height: 10),
          Text(
            'Client message drafts, templates, appointment reminders, rebooking texts, and holiday messages will appear here.',
            style: TextStyle(
              color: Color(0xFF6F6258),
              fontSize: 13,
              height: 1.45,
              fontWeight: FontWeight.w300,
            ),
          ),
          SizedBox(height: 14),
          _SecondaryButton(
            label: 'Open Message Center',
            icon: Icons.sms_outlined,
          ),
        ],
      ),
    );
  }
}

class _ActivityPreviewCard extends StatelessWidget {
  const _ActivityPreviewCard();

  @override
  Widget build(BuildContext context) {
    return const _Panel(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Activity Log',
            style: TextStyle(
              color: Color(0xFF241D18),
              fontSize: 22,
              fontWeight: FontWeight.w300,
              letterSpacing: -.3,
            ),
          ),
          SizedBox(height: 10),
          Text(
            'Every client change will eventually save here: edits, imports, appointments, refreshed summaries, forms, photos, messages, payments, and deleted items.',
            style: TextStyle(
              color: Color(0xFF6F6258),
              fontSize: 13,
              height: 1.45,
              fontWeight: FontWeight.w300,
            ),
          ),
          SizedBox(height: 14),
          _SecondaryButton(
            label: 'View Activity',
            icon: Icons.timeline_outlined,
          ),
        ],
      ),
    );
  }
}

class _BusinessToolsGrid extends StatelessWidget {
  final void Function(String title, IconData icon) onOpenComingSoon;

  const _BusinessToolsGrid({
    required this.onOpenComingSoon,
  });

  @override
  Widget build(BuildContext context) {
    final tools = [
      _ToolData('Appointments', Icons.calendar_month_outlined),
      _ToolData('Consultation', Icons.assignment_outlined),
      _ToolData('Before & After', Icons.photo_library_outlined),
      _ToolData('Messages', Icons.sms_outlined),
      _ToolData('Calls', Icons.call_outlined),
      _ToolData('Deposits', Icons.payments_outlined),
      _ToolData('Invoices', Icons.receipt_long_outlined),
      _ToolData('Packages', Icons.card_giftcard_outlined),
      _ToolData('Memberships', Icons.workspace_premium_outlined),
      _ToolData('Forms', Icons.description_outlined),
      _ToolData('Waivers', Icons.verified_user_outlined),
      _ToolData('Photos', Icons.image_outlined),
      _ToolData('Documents', Icons.folder_copy_outlined),
      _ToolData('Products Used', Icons.science_outlined),
      _ToolData('Formulas', Icons.colorize_outlined),
      _ToolData('Service Notes', Icons.edit_note_outlined),
      _ToolData('Aftercare', Icons.spa_outlined),
      _ToolData('Rebooking', Icons.event_repeat_outlined),
      _ToolData('Booksy Import', Icons.storefront_outlined),
      _ToolData('Vagaro Import', Icons.business_center_outlined),
      _ToolData('StyleSeat Import', Icons.chair_outlined),
      _ToolData('Square Import', Icons.square_outlined),
      _ToolData('Shopify Import', Icons.shopping_bag_outlined),
      _ToolData('CSV Import', Icons.file_download_outlined),
      _ToolData('Export Client', Icons.file_upload_outlined),
      _ToolData('AI Tools', Icons.auto_awesome_rounded),
      _ToolData('Activity Log', Icons.timeline_outlined),
      _ToolData('Deleted Items', Icons.restore_from_trash_outlined),
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: tools.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: MediaQuery.of(context).size.width >= 950 ? 4 : 2,
        mainAxisSpacing: 12,
        crossAxisSpacing: 12,
        childAspectRatio: 2.35,
      ),
      itemBuilder: (context, index) {
        final tool = tools[index];

        return GestureDetector(
          onTap: () {
            onOpenComingSoon(tool.title, tool.icon);
          },
          child: Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: const Color(0xFFFBF8F4).withOpacity(.94),
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
                  size: 21,
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
          ),
        );
      },
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
      padding: EdgeInsets.symmetric(horizontal: compact ? 14 : 18),
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
      height: 46,
      padding: const EdgeInsets.symmetric(horizontal: 16),
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
          Flexible(
            child: Text(
              label,
              overflow: TextOverflow.ellipsis,
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

class _IconBox extends StatelessWidget {
  final IconData icon;

  const _IconBox({
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

class _ProfileSectionData {
  final String title;
  final String subtitle;
  final IconData icon;

  const _ProfileSectionData(
    this.title,
    this.subtitle,
    this.icon,
  );
}

class _ToolData {
  final String title;
  final IconData icon;

  const _ToolData(
    this.title,
    this.icon,
  );
}