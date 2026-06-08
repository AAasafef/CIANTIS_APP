import 'package:flutter/material.dart';

import 'bookings_screen.dart';
import 'classes_screen.dart';
import 'clients_screen.dart';
import 'consultations_screen.dart';
import 'documents_screen.dart';
import 'gallery_screen.dart';
import 'inventory_screen.dart';
import 'models_screen.dart';
import 'services_screen.dart';

class SalonDashboardScreen extends StatelessWidget {
  const SalonDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F1EB),

      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.all(20),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Salon',
                style: TextStyle(
                  fontSize: 34,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF2B2118),
                  letterSpacing: -1,
                ),
              ),

              const SizedBox(height: 6),

              const Text(
                'Set up and manage your salon business.',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                ),
              ),

              const SizedBox(height: 28),

              Container(
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
                      Icons.storefront_outlined,
                      color: Color(0xFF8B735B),
                      size: 38,
                    ),
                    SizedBox(height: 18),
                    Text(
                      'Your salon is empty',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF2B2118),
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Start by adding your services, clients, bookings, classes, models, products, and business documents.',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                        height: 1.5,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 30),

              const Text(
                'Salon Setup',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF2B2118),
                ),
              ),

              const SizedBox(height: 20),

              GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                crossAxisSpacing: 18,
                mainAxisSpacing: 18,
                childAspectRatio: 1,
                children: [

                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) =>
                              const ServicesScreen(),
                        ),
                      );
                    },
                    child: _buildFeatureCard(
                      title: 'Services',
                      subtitle: 'Add pricing',
                      icon: Icons.design_services_outlined,
                    ),
                  ),

                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) =>
                              const BookingsScreen(),
                        ),
                      );
                    },
                    child: _buildFeatureCard(
                      title: 'Bookings',
                      subtitle: 'Add appointments',
                      icon: Icons.calendar_month_outlined,
                    ),
                  ),

                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) =>
                              const ClientsScreen(),
                        ),
                      );
                    },
                    child: _buildFeatureCard(
                      title: 'Clients',
                      subtitle: 'Add client records',
                      icon: Icons.people_alt_outlined,
                    ),
                  ),

                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) =>
                              const ClassesScreen(),
                        ),
                      );
                    },
                    child: _buildFeatureCard(
                      title: 'Classes',
                      subtitle: 'Create trainings',
                      icon: Icons.menu_book_outlined,
                    ),
                  ),

                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) =>
                              const ModelsScreen(),
                        ),
                      );
                    },
                    child: _buildFeatureCard(
                      title: 'Models',
                      subtitle: 'Track model calls',
                      icon: Icons.face_retouching_natural_outlined,
                    ),
                  ),

                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) =>
                              const ConsultationsScreen(),
                        ),
                      );
                    },
                    child: _buildFeatureCard(
                      title: 'Consultations',
                      subtitle: 'Client intake forms',
                      icon: Icons.assignment_outlined,
                    ),
                  ),

                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) =>
                              const InventoryScreen(),
                        ),
                      );
                    },
                    child: _buildFeatureCard(
                      title: 'Inventory',
                      subtitle: 'Add supplies',
                      icon: Icons.inventory_2_outlined,
                    ),
                  ),

                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) =>
                              const GalleryScreen(),
                        ),
                      );
                    },
                    child: _buildFeatureCard(
                      title: 'Gallery',
                      subtitle: 'Add photos',
                      icon: Icons.photo_library_outlined,
                    ),
                  ),

                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) =>
                              const DocumentsScreen(),
                        ),
                      );
                    },
                    child: _buildFeatureCard(
                      title: 'Documents',
                      subtitle: 'Add forms',
                      icon: Icons.folder_copy_outlined,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFeatureCard({
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
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: Color(0xFF2B2118),
            ),
          ),

          const SizedBox(height: 4),

          Text(
            subtitle,
            style: const TextStyle(
              fontSize: 12,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}