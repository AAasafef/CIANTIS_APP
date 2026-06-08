import 'package:flutter/material.dart';

class InventoryScreen extends StatelessWidget {
  const InventoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F1EB),

      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,

        title: const Text(
          'Inventory',
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
                'Inventory Setup',
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
                    _buildActionCard(
                      title: 'Products',
                      subtitle: 'Add retail items',
                      icon: Icons.shopping_bag_outlined,
                    ),

                    _buildActionCard(
                      title: 'Hair',
                      subtitle: 'Track bundles & extensions',
                      icon: Icons.face_retouching_natural_outlined,
                    ),

                    _buildActionCard(
                      title: 'Supplies',
                      subtitle: 'Add salon supplies',
                      icon: Icons.inventory_2_outlined,
                    ),

                    _buildActionCard(
                      title: 'Tools',
                      subtitle: 'Track equipment',
                      icon: Icons.handyman_outlined,
                    ),

                    _buildActionCard(
                      title: 'Low Stock',
                      subtitle: 'Set alerts',
                      icon: Icons.warning_amber_rounded,
                    ),

                    _buildActionCard(
                      title: 'History',
                      subtitle: 'View inventory changes',
                      icon: Icons.history_rounded,
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
            Icons.inventory_2_outlined,
            color: Color(0xFF8B735B),
            size: 38,
          ),

          SizedBox(height: 18),

          Text(
            'No inventory added yet',
            style: TextStyle(
              color: Color(0xFF2B2118),
              fontSize: 24,
              fontWeight: FontWeight.w700,
            ),
          ),

          SizedBox(height: 8),

          Text(
            'Add products, hair, supplies, and tools when you are ready. Nothing is pre-filled.',
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

  Widget _buildActionCard({
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
              height: 1.35,
            ),
          ),
        ],
      ),
    );
  }
}