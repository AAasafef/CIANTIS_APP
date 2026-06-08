import 'package:flutter/material.dart';

import '../../theme/ciantis_theme.dart';

class SampleClientBookScreen extends StatefulWidget {
  const SampleClientBookScreen({super.key});

  @override
  State<SampleClientBookScreen> createState() =>
      _SampleClientBookScreenState();
}

class _SampleClientBookScreenState extends State<SampleClientBookScreen> {
  int selectedIndex = 0;

  final List<_SampleClient> clients = const [
    _SampleClient(
      name: 'Aaliyah Johnson',
      service: 'Tape-In Extensions',
      nextAppointment: 'May 24, 2025',
      clientType: 'VIP Client',
      score: '94 / 100',
      loyalty: '87%',
      rebooking: '92%',
      noShow: 'Low',
      lateRisk: 'Medium',
      aftercare: 'Excellent',
      deposit: 'On Time',
      accent: Color(0xFFB89B78),
    ),
    _SampleClient(
      name: 'Alexis Washington',
      service: 'Color + Style',
      nextAppointment: 'May 28, 2025',
      clientType: 'Loyal Client',
      score: '88 / 100',
      loyalty: '82%',
      rebooking: '78%',
      noShow: 'Low',
      lateRisk: 'Low',
      aftercare: 'Good',
      deposit: 'On Time',
      accent: Color(0xFF8FA47A),
    ),
    _SampleClient(
      name: 'Brianna Moore',
      service: 'K-Tip Extensions',
      nextAppointment: 'May 20, 2025',
      clientType: 'VIP Client',
      score: '90 / 100',
      loyalty: '84%',
      rebooking: '88%',
      noShow: 'Low',
      lateRisk: 'Medium',
      aftercare: 'Excellent',
      deposit: 'On Time',
      accent: Color(0xFFC09B68),
    ),
    _SampleClient(
      name: 'Brittany Thomas',
      service: 'Lace Install',
      nextAppointment: 'May 26, 2025',
      clientType: 'Needs Attention',
      score: '72 / 100',
      loyalty: '61%',
      rebooking: '65%',
      noShow: 'Medium',
      lateRisk: 'High',
      aftercare: 'Fair',
      deposit: 'Watch',
      accent: Color(0xFFC47D58),
    ),
    _SampleClient(
      name: 'Cassandra Lee',
      service: 'Natural Hair + Treatment',
      nextAppointment: 'May 30, 2025',
      clientType: 'Quiet Client',
      score: '86 / 100',
      loyalty: '80%',
      rebooking: '84%',
      noShow: 'Low',
      lateRisk: 'Low',
      aftercare: 'Good',
      deposit: 'On Time',
      accent: Color(0xFFA88E74),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final client = clients[selectedIndex];
    final isTablet = MediaQuery.of(context).size.width >= 800;

    return Scaffold(
      backgroundColor: _c.ivory,
      body: SafeArea(
        child: isTablet
            ? _TabletClientBookView(
                clients: clients,
                selectedIndex: selectedIndex,
                onClientSelected: (index) {
                  setState(() => selectedIndex = index);
                },
                client: client,
              )
            : _PhoneClientBookView(
                clients: clients,
                selectedIndex: selectedIndex,
                onClientSelected: (index) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => _PhoneClientProfilePage(
                        client: clients[index],
                      ),
                    ),
                  );
                },
              ),
      ),
    );
  }
}

class _PhoneClientBookView extends StatelessWidget {
  final List<_SampleClient> clients;
  final int selectedIndex;
  final ValueChanged<int> onClientSelected;

  const _PhoneClientBookView({
    required this.clients,
    required this.selectedIndex,
    required this.onClientSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const _PhoneTopBar(title: 'CLIENT BOOK'),
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 8, 20, 0),
          child: Row(
            children: [
              const Expanded(child: _SearchBox()),
              const SizedBox(width: 10),
              _CircleButton(icon: Icons.tune_rounded),
            ],
          ),
        ),
        const SizedBox(height: 14),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: _FilterRow(),
        ),
        const SizedBox(height: 18),
        Expanded(
          child: Stack(
            children: [
              ListView.separated(
                padding: const EdgeInsets.fromLTRB(20, 0, 46, 100),
                itemCount: clients.length,
                separatorBuilder: (_, __) => const SizedBox(height: 12),
                itemBuilder: (context, index) {
                  return _ClientListCard(
                    client: clients[index],
                    selected: index == selectedIndex,
                    onTap: () => onClientSelected(index),
                  );
                },
              ),
              const Positioned(
                right: 16,
                top: 0,
                bottom: 90,
                child: _AlphabetRail(),
              ),
            ],
          ),
        ),
        const _MockBottomNav(),
      ],
    );
  }
}

class _PhoneClientProfilePage extends StatelessWidget {
  final _SampleClient client;

  const _PhoneClientProfilePage({
    required this.client,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _c.ivory,
      body: SafeArea(
        child: Column(
          children: [
            const _PhoneTopBar(title: 'CLIENT PROFILE'),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.fromLTRB(20, 6, 20, 110),
                children: [
                  _PhoneProfileCard(client: client),
                  const SizedBox(height: 16),
                  _ScoreGrid(client: client),
                  const SizedBox(height: 16),
                  _ProfileSectionsCard(),
                  const SizedBox(height: 16),
                  _AiSummaryCard(client: client),
                ],
              ),
            ),
            const _MockBottomNav(),
          ],
        ),
      ),
    );
  }
}

class _TabletClientBookView extends StatelessWidget {
  final List<_SampleClient> clients;
  final int selectedIndex;
  final ValueChanged<int> onClientSelected;
  final _SampleClient client;

  const _TabletClientBookView({
    required this.clients,
    required this.selectedIndex,
    required this.onClientSelected,
    required this.client,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: _c.ivory,
      child: Row(
        children: [
          SizedBox(
            width: 275,
            child: _TabletClientListPanel(
              clients: clients,
              selectedIndex: selectedIndex,
              onClientSelected: onClientSelected,
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(12, 18, 22, 22),
              child: _BookLayout(client: client),
            ),
          ),
        ],
      ),
    );
  }
}

class _TabletClientListPanel extends StatelessWidget {
  final List<_SampleClient> clients;
  final int selectedIndex;
  final ValueChanged<int> onClientSelected;

  const _TabletClientListPanel({
    required this.clients,
    required this.selectedIndex,
    required this.onClientSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: _c.ivory,
        border: Border(
          right: BorderSide(color: _c.line),
        ),
      ),
      child: Column(
        children: [
          const SizedBox(height: 22),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                _CircleButton(
                  icon: Icons.arrow_back_ios_new_rounded,
                  onTap: () => Navigator.pop(context),
                ),
                const SizedBox(width: 16),
                const Expanded(
                  child: Text(
                    'CLIENT BOOK',
                    style: TextStyle(
                      fontSize: 20,
                      letterSpacing: 2,
                      fontWeight: FontWeight.w400,
                      color: Color(0xFF302823),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 18),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: _SearchBox(),
          ),
          const SizedBox(height: 14),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: _FilterRow(),
          ),
          const SizedBox(height: 18),
          Expanded(
            child: Stack(
              children: [
                ListView.separated(
                  padding: const EdgeInsets.fromLTRB(20, 0, 42, 20),
                  itemCount: clients.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 12),
                  itemBuilder: (context, index) {
                    return _ClientListCard(
                      client: clients[index],
                      selected: selectedIndex == index,
                      compact: true,
                      onTap: () => onClientSelected(index),
                    );
                  },
                ),
                const Positioned(
                  right: 12,
                  top: 0,
                  bottom: 20,
                  child: _AlphabetRail(),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
            child: SizedBox(
              height: 48,
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.add_rounded, size: 18),
                label: const Text('New Client'),
                style: ElevatedButton.styleFrom(
                  elevation: 0,
                  backgroundColor: _c.taupe,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _BookLayout extends StatelessWidget {
  final _SampleClient client;

  const _BookLayout({
    required this.client,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: _c.linen,
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: _c.line),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.06),
            blurRadius: 30,
            offset: const Offset(0, 16),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30),
        child: Stack(
          children: [
            Row(
              children: [
                Expanded(child: _BookPage(child: _ProfilePage(client: client))),
                Container(width: 1, color: _c.line),
                Expanded(child: _BookPage(child: _OverviewPage(client: client))),
                Container(width: 1, color: _c.line),
                Expanded(child: _BookPage(child: _AiSummaryPage(client: client))),
              ],
            ),
            Positioned.fill(
              child: IgnorePointer(
                child: Center(
                  child: Container(
                    width: 28,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.transparent,
                          _c.taupe.withOpacity(.10),
                          Colors.transparent,
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            ...List.generate(4, (index) {
              return Positioned(
                left: MediaQuery.of(context).size.width < 900 ? null : null,
                top: 120.0 + (index * 135),
                child: const SizedBox.shrink(),
              );
            }),
          ],
        ),
      ),
    );
  }
}

class _BookPage extends StatelessWidget {
  final Widget child;

  const _BookPage({
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: _c.paper,
      padding: const EdgeInsets.all(26),
      child: child,
    );
  }
}

class _ProfilePage extends StatelessWidget {
  final _SampleClient client;

  const _ProfilePage({
    required this.client,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        const Text(
          'CIANTIS',
          style: TextStyle(
            fontSize: 24,
            letterSpacing: 4,
            color: Color(0xFF302823),
            fontWeight: FontWeight.w400,
          ),
        ),
        const SizedBox(height: 12),
        const Text(
          'CLIENT PROFILE',
          style: TextStyle(
            fontSize: 13,
            letterSpacing: 1.4,
            color: Color(0xFF65584F),
          ),
        ),
        const SizedBox(height: 24),
        _ProfilePhoto(client: client, large: true),
        const SizedBox(height: 18),
        Text(
          client.name,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 28,
            color: Color(0xFF302823),
            fontWeight: FontWeight.w400,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          client.clientType.toUpperCase(),
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 12,
            letterSpacing: 1.3,
            color: _c.taupe,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          client.service,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 15,
            color: Color(0xFF4D443E),
          ),
        ),
        const SizedBox(height: 20),
        const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _RoundAction(icon: Icons.call_rounded, label: 'Call'),
            _RoundAction(icon: Icons.chat_bubble_rounded, label: 'Text'),
            _RoundAction(icon: Icons.mail_rounded, label: 'Email'),
            _RoundAction(icon: Icons.more_horiz_rounded, label: 'More'),
          ],
        ),
        const SizedBox(height: 24),
        _InfoRows(client: client),
        const SizedBox(height: 22),
        _ScoreGrid(client: client),
      ],
    );
  }
}

class _OverviewPage extends StatelessWidget {
  final _SampleClient client;

  const _OverviewPage({
    required this.client,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        const Text(
          'Profile Overview',
          style: TextStyle(
            fontSize: 16,
            color: Color(0xFF302823),
            fontWeight: FontWeight.w400,
          ),
        ),
        const SizedBox(height: 18),
        const _ProfileSectionsCard(),
        const SizedBox(height: 24),
        _RefreshSummaryButton(),
        const SizedBox(height: 10),
        Text(
          'AI will analyze this client’s profile and refresh the saved summary.',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 11,
            height: 1.4,
            color: _c.mutedText,
          ),
        ),
      ],
    );
  }
}

class _AiSummaryPage extends StatelessWidget {
  final _SampleClient client;

  const _AiSummaryPage({
    required this.client,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        const Row(
          children: [
            Expanded(
              child: Text(
                'AI SUMMARY',
                style: TextStyle(
                  fontSize: 16,
                  letterSpacing: 1.2,
                  color: Color(0xFF302823),
                ),
              ),
            ),
            Icon(Icons.refresh_rounded, size: 20, color: Color(0xFF9A7D5F)),
            SizedBox(width: 16),
            Icon(Icons.more_horiz_rounded, size: 20, color: Color(0xFF9A7D5F)),
          ],
        ),
        const SizedBox(height: 22),
        _AiSummaryCard(client: client),
        const SizedBox(height: 18),
        _RecommendationCard(),
        const SizedBox(height: 18),
        _RefreshSummaryButton(),
        const SizedBox(height: 10),
        SizedBox(
          height: 44,
          child: OutlinedButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.lock_outline_rounded, size: 16),
            label: const Text('SAVE TO CLIENT FILE'),
            style: OutlinedButton.styleFrom(
              foregroundColor: _c.taupe,
              side: BorderSide(color: _c.line),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _PhoneTopBar extends StatelessWidget {
  final String title;

  const _PhoneTopBar({
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 18, 20, 8),
      child: Row(
        children: [
          _CircleButton(
            icon: Icons.menu_rounded,
            transparent: true,
          ),
          Expanded(
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 17,
                letterSpacing: 1.8,
                fontWeight: FontWeight.w400,
                color: Color(0xFF302823),
              ),
            ),
          ),
          _CircleButton(
            icon: Icons.add_rounded,
            filled: true,
          ),
        ],
      ),
    );
  }
}

class _SearchBox extends StatelessWidget {
  const _SearchBox();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 44,
      decoration: BoxDecoration(
        color: _c.softPanel,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: _c.line),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 14),
      child: Row(
        children: [
          Icon(Icons.search_rounded, size: 18, color: _c.mutedText),
          const SizedBox(width: 8),
          Text(
            'Search clients...',
            style: TextStyle(
              fontSize: 13,
              color: _c.mutedText,
            ),
          ),
        ],
      ),
    );
  }
}

class _FilterRow extends StatelessWidget {
  const _FilterRow();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _FilterPill(text: 'All Clients', active: true),
        const SizedBox(width: 10),
        _FilterPill(text: 'VIP Clients'),
        const SizedBox(width: 10),
        _FilterPill(text: 'Favorites'),
      ],
    );
  }
}

class _FilterPill extends StatelessWidget {
  final String text;
  final bool active;

  const _FilterPill({
    required this.text,
    this.active = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 32,
      padding: const EdgeInsets.symmetric(horizontal: 14),
      decoration: BoxDecoration(
        color: active ? _c.champagne.withOpacity(.20) : Colors.transparent,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: active ? _c.champagne.withOpacity(.28) : Colors.transparent,
        ),
      ),
      alignment: Alignment.center,
      child: Text(
        text,
        style: TextStyle(
          fontSize: 12,
          color: active ? _c.deepTaupe : _c.mutedText,
        ),
      ),
    );
  }
}

class _ClientListCard extends StatelessWidget {
  final _SampleClient client;
  final bool selected;
  final bool compact;
  final VoidCallback onTap;

  const _ClientListCard({
    required this.client,
    required this.selected,
    required this.onTap,
    this.compact = false,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: selected ? _c.champagne.withOpacity(.20) : _c.card,
      borderRadius: BorderRadius.circular(17),
      child: InkWell(
        borderRadius: BorderRadius.circular(17),
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.all(compact ? 10 : 12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(17),
            border: Border.all(color: _c.line),
          ),
          child: Row(
            children: [
              _MiniPhoto(client: client),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      client.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 15,
                        color: Color(0xFF302823),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      client.service,
                      style: TextStyle(
                        fontSize: 12,
                        color: _c.text,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Next Appt: ${client.nextAppointment}',
                      style: TextStyle(
                        fontSize: 11,
                        color: _c.mutedText,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              if (client.clientType.contains('VIP'))
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 5,
                  ),
                  decoration: BoxDecoration(
                    color: _c.champagne.withOpacity(.22),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: _c.champagne.withOpacity(.35)),
                  ),
                  child: Text(
                    'VIP',
                    style: TextStyle(
                      fontSize: 10,
                      color: _c.deepTaupe,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                )
              else
                Icon(Icons.chevron_right_rounded, color: _c.mutedText),
            ],
          ),
        ),
      ),
    );
  }
}

class _AlphabetRail extends StatelessWidget {
  const _AlphabetRail();

  @override
  Widget build(BuildContext context) {
    const letters = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';

    return Container(
      width: 28,
      decoration: BoxDecoration(
        color: _c.softPanel.withOpacity(.72),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: _c.line),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: letters
            .split('')
            .map(
              (letter) => Expanded(
                child: Center(
                  child: Text(
                    letter,
                    style: TextStyle(
                      fontSize: 10,
                      color: _c.deepTaupe,
                    ),
                  ),
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}

class _ProfilePhoto extends StatelessWidget {
  final _SampleClient client;
  final bool large;

  const _ProfilePhoto({
    required this.client,
    this.large = false,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: large ? 215 : 150,
        width: large ? 215 : 150,
        decoration: BoxDecoration(
          color: _c.champagne.withOpacity(.18),
          borderRadius: BorderRadius.circular(22),
          border: Border.all(color: _c.line),
        ),
        child: Center(
          child: Text(
            client.initials,
            style: TextStyle(
              fontSize: large ? 54 : 42,
              color: _c.taupe,
              letterSpacing: 2,
            ),
          ),
        ),
      ),
    );
  }
}

class _MiniPhoto extends StatelessWidget {
  final _SampleClient client;

  const _MiniPhoto({
    required this.client,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 58,
      width: 58,
      decoration: BoxDecoration(
        color: client.accent.withOpacity(.20),
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: _c.line),
      ),
      child: Center(
        child: Text(
          client.initials,
          style: TextStyle(
            color: _c.deepTaupe,
            fontSize: 18,
            letterSpacing: 1,
          ),
        ),
      ),
    );
  }
}

class _PhoneProfileCard extends StatelessWidget {
  final _SampleClient client;

  const _PhoneProfileCard({
    required this.client,
  });

  @override
  Widget build(BuildContext context) {
    return _SoftCard(
      child: Column(
        children: [
          _ProfilePhoto(client: client),
          const SizedBox(height: 16),
          Text(
            client.name,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 27,
              color: Color(0xFF302823),
              fontWeight: FontWeight.w400,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            client.clientType.toUpperCase(),
            style: TextStyle(
              color: _c.taupe,
              fontSize: 12,
              letterSpacing: 1.3,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            client.service,
            style: TextStyle(
              color: _c.text,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 18),
          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _RoundAction(icon: Icons.call_rounded, label: 'Call'),
              _RoundAction(icon: Icons.chat_bubble_rounded, label: 'Text'),
              _RoundAction(icon: Icons.mail_rounded, label: 'Email'),
              _RoundAction(icon: Icons.more_horiz_rounded, label: 'More'),
            ],
          ),
          const SizedBox(height: 18),
          _InfoRows(client: client),
        ],
      ),
    );
  }
}

class _InfoRows extends StatelessWidget {
  final _SampleClient client;

  const _InfoRows({
    required this.client,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _InfoRow(label: 'Client Since', value: 'Jan 12, 2023'),
        _InfoRow(label: 'Last Visit', value: 'Apr 26, 2025'),
        _InfoRow(label: 'Next Appointment', value: client.nextAppointment),
        _InfoRow(label: 'Lifetime Value', value: '\$4,850'),
        _InfoRow(label: 'Client Score', value: client.score),
      ],
    );
  }
}

class _InfoRow extends StatelessWidget {
  final String label;
  final String value;

  const _InfoRow({
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 35,
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: _c.line),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              label,
              style: TextStyle(
                fontSize: 12,
                color: _c.mutedText,
              ),
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 12,
              color: _c.text,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

class _ScoreGrid extends StatelessWidget {
  final _SampleClient client;

  const _ScoreGrid({
    required this.client,
  });

  @override
  Widget build(BuildContext context) {
    return _SoftCard(
      child: Column(
        children: [
          Text(
            'CLIENT SCORES',
            style: TextStyle(
              fontSize: 11,
              letterSpacing: 1.2,
              color: _c.deepTaupe,
            ),
          ),
          const SizedBox(height: 12),
          GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
            childAspectRatio: 2.1,
            children: [
              _ScoreTile(label: 'Rebooking Rate', value: client.rebooking),
              _ScoreTile(label: 'Loyalty Score', value: client.loyalty),
              _ScoreTile(label: 'Aftercare', value: client.aftercare),
              _ScoreTile(label: 'No-Show Risk', value: client.noShow),
              _ScoreTile(label: 'Late Risk', value: client.lateRisk),
              _ScoreTile(label: 'Deposit Status', value: client.deposit),
            ],
          ),
        ],
      ),
    );
  }
}

class _ScoreTile extends StatelessWidget {
  final String label;
  final String value;

  const _ScoreTile({
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: _c.softPanel,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: _c.line),
      ),
      padding: const EdgeInsets.all(10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 10,
              color: _c.mutedText,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            value,
            style: TextStyle(
              fontSize: 17,
              color: value == 'Low' || value == 'On Time'
                  ? const Color(0xFF477A59)
                  : value == 'High'
                      ? const Color(0xFFB45E46)
                      : _c.deepTaupe,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}

class _ProfileSectionsCard extends StatelessWidget {
  const _ProfileSectionsCard();

  @override
  Widget build(BuildContext context) {
    final sections = [
      ['Identity', Icons.person_outline_rounded],
      ['Hair Profile', Icons.face_retouching_natural_rounded],
      ['Hair Health', Icons.eco_outlined],
      ['Extension Readiness', Icons.favorite_border_rounded],
      ['Skin Profile', Icons.spa_outlined],
      ['Nail Profile', Icons.pan_tool_alt_outlined],
      ['Medical / Safety', Icons.health_and_safety_outlined],
      ['Behavior Notes', Icons.psychology_outlined],
      ['Service Preferences', Icons.favorite_outline_rounded],
      ['Policies & Boundaries', Icons.star_border_rounded],
      ['Appointment History', Icons.calendar_month_outlined],
      ['Photo Vault', Icons.photo_camera_outlined],
      ['AI Summary', Icons.auto_awesome_outlined],
    ];

    return _SoftCard(
      child: Column(
        children: sections.map((item) {
          final title = item[0] as String;
          final icon = item[1] as IconData;
          final active = title == 'AI Summary';

          return Container(
            height: 44,
            margin: const EdgeInsets.only(bottom: 6),
            decoration: BoxDecoration(
              color: active ? _c.champagne.withOpacity(.17) : Colors.transparent,
              borderRadius: BorderRadius.circular(13),
              border: Border(
                bottom: BorderSide(color: _c.line),
              ),
            ),
            child: Row(
              children: [
                Icon(icon, size: 17, color: _c.deepTaupe),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    title,
                    style: TextStyle(
                      fontSize: 14,
                      color: _c.text,
                      fontWeight: active ? FontWeight.w500 : FontWeight.w400,
                    ),
                  ),
                ),
                Icon(
                  Icons.keyboard_arrow_down_rounded,
                  size: 18,
                  color: _c.mutedText,
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}

class _AiSummaryCard extends StatelessWidget {
  final _SampleClient client;

  const _AiSummaryCard({
    required this.client,
  });

  @override
  Widget build(BuildContext context) {
    return _SoftCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Expanded(
                child: Text(
                  'AI CLIENT SUMMARY',
                  style: TextStyle(
                    fontSize: 13,
                    letterSpacing: 1,
                    color: Color(0xFF7F644A),
                  ),
                ),
              ),
              Text(
                'May 12, 2025',
                style: TextStyle(
                  fontSize: 11,
                  color: _c.mutedText,
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),
          Text(
            '${client.name.split(' ').first} is a loyal, high-value client who consistently books appointments in advance and arrives on time.\n\n'
            'She prefers natural, low-maintenance looks with long length and minimal heat styling. Her hair is medium density, low porosity, 3C texture with a sensitive scalp.\n\n'
            'She follows aftercare instructions closely and maintains her extensions beautifully between appointments.\n\n'
            'She enjoys a quiet, relaxing appointment experience and appreciates professionalism and attention to detail.',
            style: TextStyle(
              fontSize: 13,
              height: 1.58,
              color: _c.text,
            ),
          ),
        ],
      ),
    );
  }
}

class _RecommendationCard extends StatelessWidget {
  const _RecommendationCard();

  @override
  Widget build(BuildContext context) {
    return _SoftCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'AI RECOMMENDATIONS',
            style: TextStyle(
              fontSize: 13,
              letterSpacing: 1,
              color: Color(0xFF7F644A),
            ),
          ),
          const SizedBox(height: 14),
          Text(
            '• Tape-In Refresh every 6–8 weeks\n'
            '• Deep Moisture Treatment\n'
            '• Use gentle, fragrance-free scalp products\n'
            '• Allow extra consultation time for color decisions',
            style: TextStyle(
              fontSize: 12,
              height: 1.6,
              color: _c.text,
            ),
          ),
        ],
      ),
    );
  }
}

class _RefreshSummaryButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48,
      width: double.infinity,
      child: ElevatedButton.icon(
        onPressed: () {},
        icon: const Icon(Icons.refresh_rounded, size: 18),
        label: const Text('Refresh AI Summary'),
        style: ElevatedButton.styleFrom(
          elevation: 0,
          backgroundColor: _c.taupe,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
      ),
    );
  }
}

class _RoundAction extends StatelessWidget {
  final IconData icon;
  final String label;

  const _RoundAction({
    required this.icon,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 7),
      child: Column(
        children: [
          Container(
            height: 43,
            width: 43,
            decoration: BoxDecoration(
              color: _c.softPanel,
              shape: BoxShape.circle,
              border: Border.all(color: _c.line),
            ),
            child: Icon(icon, size: 18, color: _c.deepTaupe),
          ),
          const SizedBox(height: 6),
          Text(
            label,
            style: TextStyle(
              fontSize: 10,
              color: _c.mutedText,
            ),
          ),
        ],
      ),
    );
  }
}

class _CircleButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onTap;
  final bool filled;
  final bool transparent;

  const _CircleButton({
    required this.icon,
    this.onTap,
    this.filled = false,
    this.transparent = false,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: transparent
          ? Colors.transparent
          : filled
              ? _c.taupe
              : _c.softPanel,
      shape: const CircleBorder(),
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: onTap,
        child: SizedBox(
          height: 40,
          width: 40,
          child: Icon(
            icon,
            size: 20,
            color: filled ? Colors.white : _c.deepTaupe,
          ),
        ),
      ),
    );
  }
}

class _SoftCard extends StatelessWidget {
  final Widget child;

  const _SoftCard({
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: _c.card,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: _c.line),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.025),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      padding: const EdgeInsets.all(16),
      child: child,
    );
  }
}

class _MockBottomNav extends StatelessWidget {
  const _MockBottomNav();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 82,
      decoration: BoxDecoration(
        color: _c.ivory.withOpacity(.96),
        border: Border(
          top: BorderSide(color: _c.line),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: const [
          _BottomIcon(icon: Icons.home_outlined, label: 'Home'),
          _BottomIcon(icon: Icons.calendar_month_outlined, label: 'Calendar'),
          _BottomIcon(icon: Icons.people_outline_rounded, label: 'Clients', active: true),
          _BottomIcon(icon: Icons.mark_email_unread_outlined, label: 'Messages'),
          _BottomIcon(icon: Icons.more_horiz_rounded, label: 'More'),
        ],
      ),
    );
  }
}

class _BottomIcon extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool active;

  const _BottomIcon({
    required this.icon,
    required this.label,
    this.active = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        color: active ? _c.champagne.withOpacity(.18) : Colors.transparent,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 21, color: active ? _c.deepTaupe : _c.mutedText),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 10,
              color: active ? _c.deepTaupe : _c.mutedText,
            ),
          ),
        ],
      ),
    );
  }
}

class _SampleClient {
  final String name;
  final String service;
  final String nextAppointment;
  final String clientType;
  final String score;
  final String loyalty;
  final String rebooking;
  final String noShow;
  final String lateRisk;
  final String aftercare;
  final String deposit;
  final Color accent;

  const _SampleClient({
    required this.name,
    required this.service,
    required this.nextAppointment,
    required this.clientType,
    required this.score,
    required this.loyalty,
    required this.rebooking,
    required this.noShow,
    required this.lateRisk,
    required this.aftercare,
    required this.deposit,
    required this.accent,
  });

  String get initials {
    final parts = name.split(' ');
    if (parts.length < 2) return name.substring(0, 1);
    return '${parts.first.substring(0, 1)}${parts.last.substring(0, 1)}';
  }
}

class _c {
  static const ivory = Color(0xFFF8F4EE);
  static const paper = Color(0xFFFBF8F3);
  static const linen = Color(0xFFE8DED2);
  static const card = Color(0xFFFFFCF7);
  static const softPanel = Color(0xFFF3ECE4);
  static const taupe = Color(0xFFB39373);
  static const deepTaupe = Color(0xFF7B634D);
  static const champagne = Color(0xFFCBB293);
  static const text = Color(0xFF433A34);
  static const mutedText = Color(0xFF8A7D73);
  static const line = Color(0xFFE2D7CC);
}