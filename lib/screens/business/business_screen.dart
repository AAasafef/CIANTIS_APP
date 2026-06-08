import 'package:flutter/material.dart';

import '../../widgets/ciantis_text_side_menu.dart';

import 'ideas_screen.dart';
import 'income_screen.dart';
import 'marketing_screen.dart';
import 'vendors_screen.dart';

import 'salon/salon_dashboard_screen.dart';

class BusinessScreen extends StatefulWidget {
  const BusinessScreen({super.key});

  @override
  State<BusinessScreen> createState() =>
      _BusinessScreenState();
}

class _BusinessScreenState extends State<BusinessScreen> {
  String selectedCategory = 'Dashboard';
  String selectedSubCategory = 'All';

  final Map<String, List<String>> drawerTabs = {
    'Dashboard': [],
    'Salon': [
      'Services',
      'Clients',
      'Bookings',
      'Classes',
      'Model Calls',
    ],
    'Marketing': [
      'Content',
      'Campaigns',
      'Promotions',
      'Social Media',
      'Branding',
    ],
    'Income': [
      'Revenue',
      'Expenses',
      'Profit',
      'Reports',
    ],
    'Documents': [
      'Contracts',
      'Forms',
      'Licenses',
      'Receipts',
      'Business Records',
    ],
    'Vendors': [
      'Suppliers',
      'Contacts',
      'Ordering',
      'Inventory',
    ],
    'Ideas': [
      'Future Projects',
      'Business Plans',
      'Products',
      'Courses',
    ],
    'Business Settings': [
      'Reminders',
      'Privacy / Lock',
      'Export',
    ],
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F1EB),
      drawerEnableOpenDragGesture: true,
      drawer: CiantisTextSideMenu(
        title: 'Business',
        subtitle: 'BUSINESS SPACE',
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
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Builder(
          builder: (context) {
            return IconButton(
              icon: const Icon(
                Icons.menu_rounded,
                color: Color(0xFF2B2118),
              ),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            );
          },
        ),
        title: const Text(
          'Business Space',
          style: TextStyle(
            color: Color(0xFF2B2118),
            fontSize: 28,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: GridView.count(
          physics: const BouncingScrollPhysics(),
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
                        const SalonDashboardScreen(),
                  ),
                );
              },
              child: _buildCard(
                title: 'Salon',
                subtitle:
                    'Services, clients, bookings & classes',
                icon:
                    Icons.face_retouching_natural_outlined,
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) =>
                        const MarketingScreen(),
                  ),
                );
              },
              child: _buildCard(
                title: 'Marketing',
                subtitle:
                    'Content, campaigns & promotions',
                icon: Icons.campaign_outlined,
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) =>
                        const IncomeScreen(),
                  ),
                );
              },
              child: _buildCard(
                title: 'Income',
                subtitle:
                    'Revenue, expenses & profit tracking',
                icon: Icons.payments_outlined,
              ),
            ),
            GestureDetector(
              onTap: () {},
              child: _buildCard(
                title: 'Documents',
                subtitle:
                    'Contracts, forms & business records',
                icon: Icons.folder_copy_outlined,
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) =>
                        const VendorsScreen(),
                  ),
                );
              },
              child: _buildCard(
                title: 'Vendors',
                subtitle:
                    'Suppliers, contacts & ordering',
                icon: Icons.inventory_2_outlined,
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) =>
                        const IdeasScreen(),
                  ),
                );
              },
              child: _buildCard(
                title: 'Ideas',
                subtitle:
                    'Future projects & business plans',
                icon: Icons.lightbulb_outline,
              ),
            ),
          ],
        ),
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
        crossAxisAlignment:
            CrossAxisAlignment.start,
        children: [
          Container(
            height: 56,
            width: 56,
            decoration: BoxDecoration(
              color: const Color(0xFFF1E7DA),
              borderRadius:
                  BorderRadius.circular(18),
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
          const SizedBox(height: 6),
          Text(
            subtitle,
            style: const TextStyle(
              color: Colors.grey,
              fontSize: 12,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }
}