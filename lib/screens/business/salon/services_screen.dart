import 'package:flutter/material.dart';

class ServicesScreen extends StatelessWidget {
  const ServicesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F1EB),

      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,

        title: const Text(
          'Luxury Services',

          style: TextStyle(
            color: Color(0xFF2B2118),
            fontWeight: FontWeight.w700,
            fontSize: 28,
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

          _buildServiceCard(
            title: 'K-Tip Extensions',
            duration: '6 Hours',
            price: '\$1,200+',
            category: 'Luxury Extensions',
          ),

          _buildServiceCard(
            title: 'I-Tip Extensions',
            duration: '5 Hours',
            price: '\$950+',
            category: 'Luxury Extensions',
          ),

          _buildServiceCard(
            title: 'Tape-In Extensions',
            duration: '3 Hours',
            price: '\$650+',
            category: 'Install Services',
          ),

          _buildServiceCard(
            title: 'Luxury Silk Press',
            duration: '2 Hours',
            price: '\$180+',
            category: 'Natural Hair',
          ),

          _buildServiceCard(
            title: 'Luxury Pedicure',
            duration: '90 Minutes',
            price: '\$120+',
            category: 'Nail Services',
          ),

          _buildServiceCard(
            title: 'Gel-X Manicure',
            duration: '2 Hours',
            price: '\$160+',
            category: 'Nail Services',
          ),
        ],
      ),
    );
  }

  Widget _buildServiceCard({
    required String title,
    required String duration,
    required String price,
    required String category,
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
        crossAxisAlignment:
            CrossAxisAlignment.start,

        children: [

          Row(
            mainAxisAlignment:
                MainAxisAlignment.spaceBetween,

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

                  borderRadius:
                      BorderRadius.circular(14),
                ),

                child: Text(
                  price,

                  style: const TextStyle(
                    color: Color(0xFF8B735B),
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 18),

          Row(
            children: [

              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 8,
                ),

                decoration: BoxDecoration(
                  color: const Color(0xFFF5F1EB),

                  borderRadius:
                      BorderRadius.circular(12),
                ),

                child: Text(
                  category,

                  style: const TextStyle(
                    color: Color(0xFF6B5B4D),
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),

              const SizedBox(width: 12),

              const Icon(
                Icons.schedule_outlined,
                size: 18,
                color: Colors.grey,
              ),

              const SizedBox(width: 6),

              Text(
                duration,

                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 13,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}