import 'package:flutter/material.dart';

class ClassesScreen extends StatelessWidget {
  const ClassesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F1EB),

      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,

        title: const Text(
          'Classes',

          style: TextStyle(
            color: Color(0xFF2B2118),
            fontSize: 28,
            fontWeight: FontWeight.w700,
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

      body: ListView(
        physics: const BouncingScrollPhysics(),

        padding: const EdgeInsets.all(20),

        children: [

          _buildClassCard(
            title: 'I-Tip Install Class',
            length: '6–8 Hours',
            price: '\$1,500',
            students: '1 Student',
            status: 'Open',
          ),

          _buildClassCard(
            title: 'K-Tip Install Class',
            length: '6–8 Hours',
            price: '\$1,800',
            students: '1 Student',
            status: 'Open',
          ),

          _buildClassCard(
            title: 'Tape-In Extension Class',
            length: '6 Hours',
            price: '\$1,200',
            students: '2 Students',
            status: 'Open',
          ),

          _buildClassCard(
            title: 'Luxury Silk Press Training',
            length: '4 Hours',
            price: '\$750',
            students: '1 Student',
            status: 'Draft',
          ),

          _buildClassCard(
            title: 'Full Luxury Extension Training',
            length: '24 Hours',
            price: '\$4,500',
            students: 'Private Training',
            status: 'Premium',
          ),
        ],
      ),
    );
  }

  Widget _buildClassCard({
    required String title,
    required String length,
    required String price,
    required String students,
    required String status,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 18),

      padding: const EdgeInsets.all(22),

      decoration: BoxDecoration(
        color: Colors.white,

        borderRadius: BorderRadius.circular(28),

        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),

            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,

            children: [

              Expanded(
                child: Text(
                  title,

                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF2B2118),
                  ),
                ),
              ),

              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 8,
                ),

                decoration: BoxDecoration(
                  color: const Color(0xFFF1E7DA),

                  borderRadius: BorderRadius.circular(14),
                ),

                child: Text(
                  status,

                  style: const TextStyle(
                    color: Color(0xFF8B735B),
                    fontWeight: FontWeight.w700,
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 18),

          Row(
            children: [

              const Icon(
                Icons.schedule_outlined,
                size: 18,
                color: Colors.grey,
              ),

              const SizedBox(width: 8),

              Text(
                length,

                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 13,
                ),
              ),

              const SizedBox(width: 18),

              const Icon(
                Icons.people_alt_outlined,
                size: 18,
                color: Colors.grey,
              ),

              const SizedBox(width: 8),

              Text(
                students,

                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 13,
                ),
              ),
            ],
          ),

          const SizedBox(height: 18),

          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 14,
              vertical: 10,
            ),

            decoration: BoxDecoration(
              color: const Color(0xFFF5F1EB),

              borderRadius: BorderRadius.circular(14),
            ),

            child: Text(
              price,

              style: const TextStyle(
                color: Color(0xFF8B735B),
                fontSize: 18,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }
}