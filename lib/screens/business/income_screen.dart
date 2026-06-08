import 'package:flutter/material.dart';

class IncomeScreen extends StatelessWidget {
  const IncomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F1EB),

      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'Income',
          style: TextStyle(
            color: Color(0xFF2B2118),
            fontSize: 28,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),

      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildEmptyState(),

              const SizedBox(height: 26),

              const Text(
                'Income Setup',
                style: TextStyle(
                  color: Color(0xFF2B2118),
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                ),
              ),

              const SizedBox(height: 18),

              Expanded(
                child: GridView.count(
                  physics: const BouncingScrollPhysics(),
                  crossAxisCount: 2,
                  crossAxisSpacing: 18,
                  mainAxisSpacing: 18,
                  childAspectRatio: 1,
                  children: [
                    _buildCard(
                      title: 'Revenue',
                      subtitle: 'Track money in',
                      icon: Icons.trending_up_outlined,
                    ),

                    _buildCard(
                      title: 'Expenses',
                      subtitle: 'Track money out',
                      icon: Icons.receipt_long_outlined,
                    ),

                    _buildCard(
                      title: 'Deposits',
                      subtitle: 'Record payments',
                      icon: Icons.payments_outlined,
                    ),

                    _buildCard(
                      title: 'Profit',
                      subtitle: 'View net income',
                      icon: Icons.savings_outlined,
                    ),

                    _buildCard(
                      title: 'Taxes',
                      subtitle: 'Organize records',
                      icon: Icons.account_balance_outlined,
                    ),

                    _buildCard(
                      title: 'Reports',
                      subtitle: 'Review totals',
                      icon: Icons.analytics_outlined,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),

      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFF8B735B),
        onPressed: () {},
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),

      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(32),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),

      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.payments_outlined,
            color: Color(0xFF8B735B),
            size: 38,
          ),

          SizedBox(height: 18),

          Text(
            'No income added yet',
            style: TextStyle(
              color: Color(0xFF2B2118),
              fontSize: 24,
              fontWeight: FontWeight.w700,
            ),
          ),

          SizedBox(height: 8),

          Text(
            'Track revenue, deposits, expenses, taxes, profit, and reports when you are ready.',
            style: TextStyle(
              color: Colors.grey,
              fontSize: 14,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCard({
    required String title,
    required String subtitle,
    required IconData icon,
  }) {
    return Container(
      padding: const EdgeInsets.all(20),

      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 18,
            offset: const Offset(0, 10),
          ),
        ],
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 56,
            width: 56,

            decoration: BoxDecoration(
              color: const Color(0xFFF1E7DA),
              borderRadius: BorderRadius.circular(18),
            ),

            child: Icon(
              icon,
              color: const Color(0xFF8B735B),
              size: 30,
            ),
          ),

          const Spacer(),

          Text(
            title,
            style: const TextStyle(
              color: Color(0xFF2B2118),
              fontSize: 20,
              fontWeight: FontWeight.w700,
            ),
          ),

          const SizedBox(height: 4),

          Text(
            subtitle,
            style: const TextStyle(
              color: Colors.grey,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}