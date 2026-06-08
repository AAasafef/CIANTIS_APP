import 'package:flutter/material.dart';

class ModelsScreen extends StatelessWidget {
  const ModelsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F1EB),

      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,

        title: const Text(
          'Models',
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
                'Model Call Setup',
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
                      title: 'Applications',
                      subtitle: 'Review applicants',
                      icon: Icons.assignment_ind_outlined,
                    ),

                    _buildCard(
                      title: 'Requirements',
                      subtitle: 'Set model rules',
                      icon: Icons.rule_outlined,
                    ),

                    _buildCard(
                      title: 'Before Photos',
                      subtitle: 'Add starting photos',
                      icon: Icons.photo_camera_outlined,
                    ),

                    _buildCard(
                      title: 'After Photos',
                      subtitle: 'Add final photos',
                      icon: Icons.add_a_photo_outlined,
                    ),

                    _buildCard(
                      title: 'Releases',
                      subtitle: 'Model permissions',
                      icon: Icons.description_outlined,
                    ),

                    _buildCard(
                      title: 'History',
                      subtitle: 'Past model calls',
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
            Icons.face_retouching_natural_outlined,
            color: Color(0xFF8B735B),
            size: 38,
          ),

          SizedBox(height: 18),

          Text(
            'No model calls added yet',
            style: TextStyle(
              color: Color(0xFF2B2118),
              fontSize: 24,
              fontWeight: FontWeight.w700,
            ),
          ),

          SizedBox(height: 8),

          Text(
            'Create model calls, set requirements, review applications, save photos, and attach model releases when you are ready.',
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