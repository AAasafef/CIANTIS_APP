import 'package:flutter/material.dart';

class SubscriptionScreen extends StatelessWidget {
  const SubscriptionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4EFE8),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.fromLTRB(24, 20, 24, 120),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              _SubscriptionHeader(),
              SizedBox(height: 28),
              _TrialsEndingSoonCard(),
              SizedBox(height: 22),
              _MonthlyStoryCard(),
              SizedBox(height: 26),
              _SearchAndFilterRow(),
              SizedBox(height: 28),
              _SectionTitle(title: 'Subscriptions'),
              SizedBox(height: 14),
              SubscriptionCard(
                name: 'ChatGPT Plus',
                category: 'Productivity',
                amount: '\$20/mo',
                renewal: 'Renews Jun 2',
                icon: Icons.auto_awesome_rounded,
              ),
              SizedBox(height: 14),
              SubscriptionCard(
                name: 'Canva Pro',
                category: 'Design',
                amount: '\$12.99/mo',
                renewal: 'Renews Jun 8',
                icon: Icons.design_services_rounded,
              ),
              SizedBox(height: 14),
              SubscriptionCard(
                name: 'Netflix',
                category: 'Entertainment',
                amount: '\$15.49/mo',
                renewal: 'Renews Jun 18',
                icon: Icons.movie_creation_outlined,
              ),
              SizedBox(height: 14),
              SubscriptionCard(
                name: 'Spotify Premium',
                category: 'Music',
                amount: '\$11.99/mo',
                renewal: 'Renews Jun 23',
                icon: Icons.headphones_rounded,
              ),
              SizedBox(height: 14),
              SubscriptionCard(
                name: 'iCloud+',
                category: 'Storage',
                amount: '\$2.99/mo',
                renewal: 'Renews Jul 1',
                icon: Icons.cloud_outlined,
              ),
              SizedBox(height: 28),
              _AIInsightCard(),
              SizedBox(height: 22),
              _SpendingOverviewCard(),
            ],
          ),
        ),
      ),
    );
  }
}

class _SubscriptionHeader extends StatelessWidget {
  const _SubscriptionHeader();

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Subscriptions',
                style: TextStyle(
                  fontSize: 48,
                  height: .95,
                  fontWeight: FontWeight.w300,
                  letterSpacing: -1.6,
                  color: Color(0xFF241D18),
                ),
              ),
              SizedBox(height: 10),
              Text(
                'RECURRING SERVICES & TRIALS',
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w300,
                  letterSpacing: 3.2,
                  color: Color(0xFF8B7D72),
                ),
              ),
            ],
          ),
        ),
        Container(
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
          child: const Icon(
            Icons.add_rounded,
            color: Color(0xFF241D18),
            size: 25,
          ),
        ),
      ],
    );
  }
}

class _TrialsEndingSoonCard extends StatelessWidget {
  const _TrialsEndingSoonCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(22, 22, 22, 20),
      decoration: BoxDecoration(
        color: const Color(0xFFFBF8F4).withOpacity(.9),
        borderRadius: BorderRadius.circular(28),
        border: Border.all(
          color: const Color(0xFFE2D8CD),
          width: .7,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text(
            'Trials Ending Soon',
            style: TextStyle(
              color: Color(0xFF241D18),
              fontSize: 28,
              fontWeight: FontWeight.w300,
              letterSpacing: -.8,
            ),
          ),
          SizedBox(height: 6),
          Text(
            'Cancel or remind yourself before they charge.',
            style: TextStyle(
              color: Color(0xFF8B7D72),
              fontSize: 13,
              fontWeight: FontWeight.w300,
            ),
          ),
          SizedBox(height: 18),
          TrialRow(
            title: 'Canva Pro Trial',
            subtitle: 'Design',
            daysLeft: '2 days left',
          ),
          SizedBox(height: 14),
          TrialRow(
            title: 'Skillshare',
            subtitle: 'Learning',
            daysLeft: '4 days left',
          ),
          SizedBox(height: 14),
          TrialRow(
            title: 'Audible',
            subtitle: 'Books',
            daysLeft: '6 days left',
          ),
        ],
      ),
    );
  }
}

class TrialRow extends StatelessWidget {
  final String title;
  final String subtitle;
  final String daysLeft;

  const TrialRow({
    super.key,
    required this.title,
    required this.subtitle,
    required this.daysLeft,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(14, 13, 14, 13),
      decoration: BoxDecoration(
        color: const Color(0xFFF4EFE8).withOpacity(.72),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: const Color(0xFFE2D8CD),
          width: .6,
        ),
      ),
      child: Row(
        children: [
          Container(
            height: 38,
            width: 38,
            decoration: BoxDecoration(
              color: const Color(0xFFFBF8F4),
              borderRadius: BorderRadius.circular(14),
              border: Border.all(
                color: const Color(0xFFE2D8CD),
                width: .6,
              ),
            ),
            child: const Icon(
              Icons.timer_outlined,
              size: 18,
              color: Color(0xFFC6A06B),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Color(0xFF241D18),
                    fontSize: 15,
                    fontWeight: FontWeight.w300,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  subtitle,
                  style: const TextStyle(
                    color: Color(0xFF8B7D72),
                    fontSize: 11,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ],
            ),
          ),
          Text(
            daysLeft,
            style: const TextStyle(
              color: Color(0xFFC6A06B),
              fontSize: 12,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}

class _MonthlyStoryCard extends StatelessWidget {
  const _MonthlyStoryCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(26),
      decoration: BoxDecoration(
        color: const Color(0xFFFBF8F4).withOpacity(.9),
        borderRadius: BorderRadius.circular(30),
        border: Border.all(
          color: const Color(0xFFE2D8CD),
          width: .7,
        ),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'This Month',
            style: TextStyle(
              color: Color(0xFF8B7D72),
              fontSize: 11,
              fontWeight: FontWeight.w300,
              letterSpacing: 3,
            ),
          ),
          SizedBox(height: 14),
          Text(
            '\$412',
            style: TextStyle(
              color: Color(0xFF241D18),
              fontSize: 54,
              height: 1,
              fontWeight: FontWeight.w300,
              letterSpacing: -1.4,
            ),
          ),
          SizedBox(height: 10),
          Text(
            'Spent on recurring services',
            style: TextStyle(
              color: Color(0xFF6F6258),
              fontSize: 15,
              fontWeight: FontWeight.w300,
            ),
          ),
          SizedBox(height: 18),
          Divider(
            color: Color(0xFFE2D8CD),
            height: 1,
          ),
          SizedBox(height: 16),
          Text(
            '18 active subscriptions • 3 trials ending soon • estimated \$456 next month',
            style: TextStyle(
              color: Color(0xFF8B7D72),
              fontSize: 13,
              height: 1.45,
              fontWeight: FontWeight.w300,
            ),
          ),
        ],
      ),
    );
  }
}

class _SearchAndFilterRow extends StatelessWidget {
  const _SearchAndFilterRow();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: 56,
            padding: const EdgeInsets.symmetric(horizontal: 18),
            decoration: BoxDecoration(
              color: const Color(0xFFFBF8F4).withOpacity(.9),
              borderRadius: BorderRadius.circular(22),
              border: Border.all(
                color: const Color(0xFFE2D8CD),
                width: .7,
              ),
            ),
            child: const Row(
              children: [
                Icon(
                  Icons.search_rounded,
                  color: Color(0xFF8B7D72),
                  size: 20,
                ),
                SizedBox(width: 12),
                Text(
                  'Search...',
                  style: TextStyle(
                    color: Color(0xFF8B7D72),
                    fontSize: 15,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(width: 10),
        Container(
          height: 56,
          width: 56,
          decoration: BoxDecoration(
            color: const Color(0xFFFBF8F4).withOpacity(.9),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: const Color(0xFFE2D8CD),
              width: .7,
            ),
          ),
          child: const Icon(
            Icons.tune_rounded,
            color: Color(0xFF241D18),
            size: 21,
          ),
        ),
      ],
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String title;

  const _SectionTitle({
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(
        color: Color(0xFF241D18),
        fontSize: 30,
        fontWeight: FontWeight.w300,
        letterSpacing: -.8,
      ),
    );
  }
}

class SubscriptionCard extends StatelessWidget {
  final String name;
  final String category;
  final String amount;
  final String renewal;
  final IconData icon;

  const SubscriptionCard({
    super.key,
    required this.name,
    required this.category,
    required this.amount,
    required this.renewal,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: const Color(0xFFFBF8F4).withOpacity(.9),
        borderRadius: BorderRadius.circular(26),
        border: Border.all(
          color: const Color(0xFFE2D8CD),
          width: .7,
        ),
      ),
      child: Row(
        children: [
          Container(
            height: 54,
            width: 54,
            decoration: BoxDecoration(
              color: const Color(0xFFF4EFE8),
              borderRadius: BorderRadius.circular(17),
              border: Border.all(
                color: const Color(0xFFE2D8CD),
                width: .6,
              ),
            ),
            child: Icon(
              icon,
              color: const Color(0xFF241D18),
              size: 24,
            ),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    color: Color(0xFF241D18),
                    fontSize: 17,
                    fontWeight: FontWeight.w300,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  category,
                  style: const TextStyle(
                    color: Color(0xFF8B7D72),
                    fontSize: 12,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                amount,
                style: const TextStyle(
                  color: Color(0xFF241D18),
                  fontSize: 15,
                  fontWeight: FontWeight.w300,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                renewal,
                style: const TextStyle(
                  color: Color(0xFF8B7D72),
                  fontSize: 11,
                  fontWeight: FontWeight.w300,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _AIInsightCard extends StatelessWidget {
  const _AIInsightCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: const Color(0xFFFBF8F4).withOpacity(.9),
        borderRadius: BorderRadius.circular(28),
        border: Border.all(
          color: const Color(0xFFE2D8CD),
          width: .7,
        ),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'AI Suggestions',
            style: TextStyle(
              color: Color(0xFF241D18),
              fontSize: 28,
              fontWeight: FontWeight.w300,
              letterSpacing: -.8,
            ),
          ),
          SizedBox(height: 16),
          _InsightLine(text: 'You have 4 unused subscriptions.'),
          SizedBox(height: 10),
          _InsightLine(text: 'Potential savings: \$172/year.'),
          SizedBox(height: 10),
          _InsightLine(text: '3 subscriptions overlap in features.'),
        ],
      ),
    );
  }
}

class _InsightLine extends StatelessWidget {
  final String text;

  const _InsightLine({
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.only(top: 8),
          height: 4,
          width: 4,
          decoration: BoxDecoration(
            color: const Color(0xFFC6A06B),
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(
              color: Color(0xFF6F6258),
              fontSize: 14,
              height: 1.45,
              fontWeight: FontWeight.w300,
            ),
          ),
        ),
      ],
    );
  }
}

class _SpendingOverviewCard extends StatelessWidget {
  const _SpendingOverviewCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: const Color(0xFFFBF8F4).withOpacity(.9),
        borderRadius: BorderRadius.circular(28),
        border: Border.all(
          color: const Color(0xFFE2D8CD),
          width: .7,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text(
            'Spending Overview',
            style: TextStyle(
              color: Color(0xFF241D18),
              fontSize: 28,
              fontWeight: FontWeight.w300,
              letterSpacing: -.8,
            ),
          ),
          SizedBox(height: 20),
          _SpendingLine(label: 'Entertainment', amount: '\$173'),
          SizedBox(height: 12),
          _SpendingLine(label: 'Productivity', amount: '\$107'),
          SizedBox(height: 12),
          _SpendingLine(label: 'Business', amount: '\$58'),
          SizedBox(height: 12),
          _SpendingLine(label: 'Education', amount: '\$42'),
        ],
      ),
    );
  }
}

class _SpendingLine extends StatelessWidget {
  final String label;
  final String amount;

  const _SpendingLine({
    required this.label,
    required this.amount,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            label,
            style: const TextStyle(
              color: Color(0xFF6F6258),
              fontSize: 14,
              fontWeight: FontWeight.w300,
            ),
          ),
        ),
        Text(
          amount,
          style: const TextStyle(
            color: Color(0xFF241D18),
            fontSize: 14,
            fontWeight: FontWeight.w300,
          ),
        ),
      ],
    );
  }
}