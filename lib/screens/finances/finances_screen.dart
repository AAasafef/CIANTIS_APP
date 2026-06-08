// lib/screens/finances/finances_screen.dart

import 'package:flutter/material.dart';

class FinancesScreen extends StatefulWidget {
  const FinancesScreen({super.key});

  @override
  State<FinancesScreen> createState() => _FinancesScreenState();
}

class _FinancesScreenState extends State<FinancesScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final List<_MoneyFolder> folders = const [
    _MoneyFolder('Bills', Icons.receipt_long_rounded),
    _MoneyFolder('Budget', Icons.account_balance_wallet_rounded),
    _MoneyFolder('Savings Goals', Icons.savings_rounded),
    _MoneyFolder('Debt Payoff', Icons.trending_down_rounded),
    _MoneyFolder('Credit', Icons.credit_score_rounded),
    _MoneyFolder('Subscriptions', Icons.repeat_rounded),
    _MoneyFolder('Income', Icons.payments_rounded),
    _MoneyFolder('Taxes', Icons.description_rounded),
    _MoneyFolder('Documents', Icons.folder_rounded),
    _MoneyFolder('Reports', Icons.analytics_rounded),
  ];

  final List<_MoneyAction> actions = const [
    _MoneyAction('Add Bill', Icons.add_card_rounded),
    _MoneyAction('Log Income', Icons.attach_money_rounded),
    _MoneyAction('Track Spending', Icons.shopping_bag_rounded),
    _MoneyAction('Savings Goal', Icons.flag_rounded),
    _MoneyAction('Debt Plan', Icons.timeline_rounded),
    _MoneyAction('Credit Plan', Icons.shield_rounded),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: _MoneySideMenu(folders: folders),
      backgroundColor: const Color(0xFFF7F1EA),
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/images/spaces/money.jpg',
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color(0xFFE8DDD2),
                      Color(0xFFF7F1EA),
                      Color(0xFFD7C7B8),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Positioned.fill(
            child: Container(color: Colors.black.withOpacity(.28)),
          ),
          SafeArea(
            child: Column(
              children: [
                _TopBar(
                  onMenuTap: () => _scaffoldKey.currentState?.openDrawer(),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.fromLTRB(18, 6, 18, 120),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 18),
                        const Text(
                          'Money Space',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 34,
                            fontWeight: FontWeight.w300,
                            letterSpacing: .4,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          'Private planning for bills, savings, credit, debt, and financial goals.',
                          style: TextStyle(
                            color: Colors.white.withOpacity(.86),
                            fontSize: 13,
                            height: 1.4,
                          ),
                        ),
                        const SizedBox(height: 26),
                        const _MoneySnapshot(),
                        const SizedBox(height: 18),
                        _SectionTitle(
                          title: 'Quick Actions',
                          action: 'edit',
                          onTap: () {},
                        ),
                        const SizedBox(height: 10),
                        GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: actions.length,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            mainAxisExtent: 86,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                          ),
                          itemBuilder: (_, index) {
                            final item = actions[index];
                            return _ActionTile(item: item);
                          },
                        ),
                        const SizedBox(height: 20),
                        const _SectionTitle(title: 'Folders'),
                        const SizedBox(height: 10),
                        ...folders.map((folder) => _FolderRow(folder: folder)),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: const _MoneyBottomNav(),
    );
  }
}

class _TopBar extends StatelessWidget {
  final VoidCallback onMenuTap;

  const _TopBar({required this.onMenuTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(14, 8, 14, 4),
      child: Row(
        children: [
          IconButton(
            onPressed: onMenuTap,
            icon: const Icon(Icons.menu_rounded, color: Colors.white),
          ),
          const Spacer(),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.notifications_none_rounded,
                color: Colors.white),
          ),
        ],
      ),
    );
  }
}

class _MoneySideMenu extends StatelessWidget {
  final List<_MoneyFolder> folders;

  const _MoneySideMenu({required this.folders});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: const Color(0xFFF8F2EB),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(22, 18, 22, 18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Money Menu',
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.w300,
                  color: Color(0xFF2D2723),
                ),
              ),
              const SizedBox(height: 14),
              TextField(
                decoration: InputDecoration(
                  hintText: 'Search folders',
                  prefixIcon: const Icon(Icons.search_rounded),
                  filled: true,
                  fillColor: Colors.white.withOpacity(.72),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(22),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const SizedBox(height: 22),
              Expanded(
                child: ListView(
                  children: folders
                      .map(
                        (folder) => ListTile(
                          dense: true,
                          contentPadding: EdgeInsets.zero,
                          leading: Icon(
                            folder.icon,
                            size: 20,
                            color: const Color(0xFF8A7664),
                          ),
                          title: Text(
                            folder.title,
                            style: const TextStyle(
                              fontSize: 15,
                              color: Color(0xFF2D2723),
                            ),
                          ),
                          onTap: () => Navigator.pop(context),
                        ),
                      )
                      .toList(),
                ),
              ),
              Row(
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.settings_outlined),
                  ),
                  const Text('Menu settings'),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _MoneySnapshot extends StatelessWidget {
  const _MoneySnapshot();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(.78),
        borderRadius: BorderRadius.circular(28),
        border: Border.all(color: Colors.white.withOpacity(.44)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Financial Snapshot',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w400,
              color: Color(0xFF2D2723),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Nothing added yet. Your bills, goals, debt, income, and credit plan will show here once you start tracking.',
            style: TextStyle(
              fontSize: 13,
              height: 1.45,
              color: const Color(0xFF2D2723).withOpacity(.72),
            ),
          ),
          const SizedBox(height: 14),
          GestureDetector(
            onTap: () {},
            child: const Text(
              'Start money setup  →',
              style: TextStyle(
                fontSize: 13,
                color: Color(0xFF7E6754),
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String title;
  final String? action;
  final VoidCallback? onTap;

  const _SectionTitle({
    required this.title,
    this.action,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 17,
            fontWeight: FontWeight.w400,
          ),
        ),
        const Spacer(),
        if (action != null)
          GestureDetector(
            onTap: onTap,
            child: Text(
              action!,
              style: TextStyle(
                color: Colors.white.withOpacity(.78),
                fontSize: 12,
              ),
            ),
          ),
      ],
    );
  }
}

class _ActionTile extends StatelessWidget {
  final _MoneyAction item;

  const _ActionTile({required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(.76),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(item.icon, color: const Color(0xFF7E6754), size: 24),
          const SizedBox(height: 8),
          Text(
            item.title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 11.5,
              color: Color(0xFF2D2723),
            ),
          ),
        ],
      ),
    );
  }
}

class _FolderRow extends StatelessWidget {
  final _MoneyFolder folder;

  const _FolderRow({required this.folder});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 9),
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 14),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(.74),
        borderRadius: BorderRadius.circular(22),
      ),
      child: Row(
        children: [
          Icon(folder.icon, color: const Color(0xFF7E6754), size: 21),
          const SizedBox(width: 12),
          Text(
            folder.title,
            style: const TextStyle(
              color: Color(0xFF2D2723),
              fontSize: 14,
            ),
          ),
          const Spacer(),
          const Icon(
            Icons.chevron_right_rounded,
            color: Color(0xFF8A7664),
          ),
        ],
      ),
    );
  }
}

class _MoneyBottomNav extends StatelessWidget {
  const _MoneyBottomNav();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 76,
      padding: const EdgeInsets.symmetric(horizontal: 26),
      decoration: BoxDecoration(
        color: const Color(0xFFF8F2EB).withOpacity(.96),
        borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
      ),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(Icons.layers_outlined, color: Color(0xFF7E6754)),
          Icon(Icons.grid_view_rounded, color: Color(0xFF7E6754)),
          Icon(Icons.calendar_month_outlined, color: Color(0xFF7E6754)),
          Icon(Icons.settings_outlined, color: Color(0xFF7E6754)),
          Icon(Icons.mic_none_rounded, color: Color(0xFF7E6754)),
        ],
      ),
    );
  }
}

class _MoneyFolder {
  final String title;
  final IconData icon;

  const _MoneyFolder(this.title, this.icon);
}

class _MoneyAction {
  final String title;
  final IconData icon;

  const _MoneyAction(this.title, this.icon);
}